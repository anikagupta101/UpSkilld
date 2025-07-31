import SwiftUI
import AVKit
import WebKit
import PhotosUI
import MobileCoreServices // Import for UTType.movie

// MARK: - Model
struct ShortVideo2: Identifiable {
    let id = UUID()
    let title: String
    let username: String
    let videoURL: URL? // For local/remote AVPlayer content
    let youtubeID: String? // For YouTube embedded content
    
    // Initializer for local/remote video URLs
    init(title: String, username: String, videoURL: URL?) {
        self.title = title
        self.username = username
        self.videoURL = videoURL
        self.youtubeID = nil
    }
    
    // Initializer for YouTube videos
    init(title: String, username: String, youtubeID: String?) {
        self.title = title
        self.username = username
        self.videoURL = nil
        self.youtubeID = youtubeID
    }
}

// MARK: - YouTube Player View (WebView)
struct YouTubePlayerView2: UIViewRepresentable {
    let videoID: String
    @Binding var isPlaying: Bool

    func makeUIView(context: Context) -> WKWebView {
        // Create a configuration that allows media to autoplay
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        // This is crucial for enabling autoplay without user interaction
        configuration.mediaTypesRequiringUserActionForPlayback = []

        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.scrollView.isScrollEnabled = false
        // Hides the white background flash before the video loads
        webView.isOpaque = false
        webView.backgroundColor = .clear
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        if isPlaying {
            let embedURLString = "https://www.youtube.com/embed/\(videoID)?playsinline=1&autoplay=1"

            // safely check the current URL.
            // First, we check if the current URL string contains our video ID.
            // The '?? false' means "if the URL is nil, treat it as false".
            let isAlreadyLoaded = uiView.url?.absoluteString.contains(videoID) ?? false

            // Only load the new URL if the correct video isn't already loaded.
            if !isAlreadyLoaded {
                if let url = URL(string: embedURLString) {
                    uiView.load(URLRequest(url: url))
                }
            }
        } else {
            // This part remains the same.
            uiView.loadHTMLString("", baseURL: nil)
        }
    }
}

// MARK: - Video Slide View
struct VideoSlideView: View {
    let video: ShortVideo2
    @State private var player: AVPlayer?
    @Binding var isVisible: Bool

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // We use a placeholder for the player view
            if let youtubeID = video.youtubeID {
                YouTubePlayerView2(videoID: youtubeID, isPlaying: $isVisible)
            } else if let player = player {
                VideoPlayer(player: player)
                    .containerRelativeFrame([.horizontal, .vertical])
                    .scaledToFill()
                    .ignoresSafeArea()
            } else {
                // Show a black background while the player is being prepared
                Rectangle().fill(Color.black)
            }

            // Your overlay UI remains unchanged
            VStack(alignment: .leading, spacing: 8) {
                Spacer()
                Text(video.title).font(.title2).bold().foregroundColor(.white).lineLimit(2)
                Text("@\(video.username)").font(.subheadline).foregroundColor(.white.opacity(0.8))
                HStack(spacing: 20) {
                    Button { print("Liked \(video.title)") } label: { Image(systemName: "heart.fill").font(.title2).foregroundColor(.white) }
                    Button { print("Shared \(video.title)") } label: { Image(systemName: "square.and.arrow.up").font(.title2).foregroundColor(.white) }
                }
            }
            .padding([.leading, .bottom], 20)
            .padding(.trailing, 10)
        }
        // CORRECTED LOGIC: This is the most important change.
        .onChange(of: isVisible) {
            if isVisible {
                // When the view becomes visible, create a new player instance and play it.
                guard let url = video.videoURL else { return }
                player = AVPlayer(url: url)
                player?.isMuted = true // Autoplay must be muted
                player?.play()

                // Set up an observer to loop the video when it ends.
                NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player?.currentItem, queue: .main) { _ in
                    player?.seek(to: .zero)
                    player?.play()
                }
            } else {
                // When the view is no longer visible, pause and destroy the player
                // to release memory and network resources.
                player?.pause()
                player = nil
            }
        }
    }
}

// MARK: - Feed View (No changes needed here)
struct FeedView2: View {
    @Binding var videos: [ShortVideo2]
    @State private var currentVideoID: UUID? //added
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 0) {
                ForEach(videos) { video in
                    VideoSlideView(video: video, isVisible: .constant(currentVideoID == video.id))
                        .frame(height: UIScreen.main.bounds.height)
                        .clipped()
                        .id(video.id)
                }
            }
            .scrollTargetLayout() //added
        }
        .onAppear {
            currentVideoID = videos.first?.id
        }
        .scrollTargetBehavior(.paging)
        .ignoresSafeArea()
        .scrollPosition(id: $currentVideoID) //added
    }
}


// MARK: - Post Video View
struct PostVideoView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var videos: [ShortVideo2]
    
    @State private var videoTitle: String = ""
    @State private var username: String = ""
    @State private var videoInput: String = "" // For URL input
    @State private var selectedItem: PhotosPickerItem? = nil // For local video selection
    @State private var localVideoURL: URL? = nil // To store the temporary URL of the picked video
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section("Video Details") {
                    TextField("Title", text: $videoTitle)
                    TextField("Your Username", text: $username)
                }
                
                Section("Video Source") {
                    TextField("Enter YouTube URL or Direct Video URL", text: $videoInput)
                        .autocapitalization(.none)
                        .keyboardType(.URL)
                    
                    PhotosPicker(selection: $selectedItem, matching: .videos) {
                        Label("Select MP4 from Library", systemImage: "video.fill")
                    }
                    .onChange(of: selectedItem) { newItem in
                        Task {
                            localVideoURL = nil // Reset previous local video URL
                            if let item = newItem {
                                do {
                                    // Load the video as a URL, which is more efficient for large files
                                    if let url = try await item.loadTransferable(type: URL.self) {
                                        // The URL returned by PhotosPicker is often a temporary file URL.
                                        // For persistence, you'd copy this to a permanent location in your app's sandbox.
                                        localVideoURL = url
                                        videoInput = url.absoluteString // Update videoInput field for user to see
                                        alertMessage = "Local video selected. Tap Save."
                                    } else {
                                        alertMessage = "Could not load video URL from Photos Picker."
                                    }
                                } catch {
                                    print("Error loading video from PhotosPicker: \(error.localizedDescription)")
                                    alertMessage = "Failed to load local video: \(error.localizedDescription)"
                                }
                            } else {
                                alertMessage = "No video selected."
                            }
                            showingAlert = true
                        }
                    }
                    
                    if let url = localVideoURL {
                        Text("Selected Local Video: \(url.lastPathComponent)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                
                Button("Save Video") {
                    saveVideo()
                }
                .alert("Status", isPresented: $showingAlert) {
                    Button("OK") { }
                } message: {
                    Text(alertMessage)
                }
            }
            .navigationTitle("New Short Video")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func saveVideo() {
        guard !videoTitle.isEmpty, !username.isEmpty else {
            alertMessage = "Please fill in title and username."
            showingAlert = true
            return
        }
        
        // Prioritize local video if selected via PhotosPicker
        if let url = localVideoURL {
            videos.insert(ShortVideo2(title: videoTitle, username: username, videoURL: url), at: 0)
            alertMessage = "Local video added successfully!"
            dismiss()
            return // Exit after handling local video
        }
        
        // If no local video, try to parse the URL string
        if let url = URL(string: videoInput), url.scheme != nil {
            if let youtubeID = extractYouTubeID(from: url) {
                videos.insert(ShortVideo2(title: videoTitle, username: username, youtubeID: youtubeID), at: 0)
                alertMessage = "YouTube video added successfully!"
                dismiss()
            } else if url.absoluteString.lowercased().hasSuffix(".mp4") || url.absoluteString.lowercased().hasSuffix(".mov") {
                // Assume it's a direct video URL (MP4, MOV, etc.) if it has the correct extension
                videos.insert(ShortVideo2(title: videoTitle, username: username, videoURL: url), at: 0)
                alertMessage = "Direct video URL added successfully!"
                dismiss()
            } else {
                alertMessage = "Could not identify video type. Please provide a valid YouTube URL or a direct link to an MP4/MOV file."
                showingAlert = true
            }
        } else {
            alertMessage = "Please enter a valid URL or select a local video."
            showingAlert = true
        }
    }
    
    private func extractYouTubeID(from url: URL) -> String? {
        let urlString = url.absoluteString
        
        // Pattern 1: Standard watch URL (https://www.youtube.com/embed/\(videoID)?playsinline=1&autoplay=1&controls=0&showinfo=0&loop=1&playlist=\(videoID)&modestbranding=1)
        if let regex = try? NSRegularExpression(pattern: "v=([a-zA-Z0-9_-]+)", options: []),
           let match = regex.firstMatch(in: urlString, options: [], range: NSRange(location: 0, length: urlString.utf16.count)) {
            if let idRange = Range(match.range(at: 1), in: urlString) {
                return String(urlString[idRange])
            }
        }
        
        // Pattern 2: Shortened youtu.be URL (youtube.com)
        if let regex = try? NSRegularExpression(pattern: "youtu\\.be/([a-zA-Z0-9_-]+)", options: []),
           let match = regex.firstMatch(in: urlString, options: [], range: NSRange(location: 0, length: urlString.utf16.count)) {
            if let idRange = Range(match.range(at: 1), in: urlString) {
                return String(urlString[idRange])
            }
        }
        
        // Pattern 3: Embedded URL (youtu.be)
        if let regex = try? NSRegularExpression(pattern: "embed/([a-zA-Z0-9_-]+)", options: []),
           let match = regex.firstMatch(in: urlString, options: [], range: NSRange(location: 0, length: urlString.utf16.count)) {
            if let idRange = Range(match.range(at: 1), in: urlString) {
                return String(urlString[idRange])
            }
        }
        
        // Pattern 4: Shorts URL (youtu.be/)
        if let regex = try? NSRegularExpression(pattern: "/shorts/([a-zA-Z0-9_-]+)", options: []),
           let match = regex.firstMatch(in: urlString, options: [], range: NSRange(location: 0, length: urlString.utf16.count)) {
            if let idRange = Range(match.range(at: 1), in: urlString) {
                return String(urlString[idRange])
            }
        }
        
        // Consider if the URL itself is just the ID (less common but possible)
        if urlString.range(of: "^[a-zA-Z0-9_-]{11}$", options: .regularExpression) != nil {
            return urlString
        }

        return nil
    }
}

// MARK: - Main ShortFormContent View (No changes needed here)
struct ShortFormContent: View {
    @State private var sampleVideos: [ShortVideo2] = [
        ShortVideo2(title: "Finance", username: "finance!", youtubeID: "lWu2fw6APM4"),
        ShortVideo2(title: "Investing", username: "investing", youtubeID: "vKuK8AVL-1o"),
        ShortVideo2(title: "Millionaire Mindset", username: "millionaires", youtubeID: "l52CNKgAP7g"),
        ShortVideo2(title: "Student Discounts", username: "discounts", youtubeID: "gjx_zc0Ut7U"),
        ShortVideo2(title: "Passive Income", username: "passiveincome", youtubeID: "aGLjcLFup94"),
        ShortVideo2(title: "Student Scholarships", username: "scholarships", youtubeID: "NF_dqRMssa8"),
        ShortVideo2(title: "FAFSA", username: "fafsa", youtubeID: "XrByfVYcugU"),
    ]
    
    @State private var showingPostSheet = false
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            FeedView2(videos: $sampleVideos)
                .statusBarHidden(true)
            
            Button {
                showingPostSheet.toggle()
            } label: {
                Image(systemName: "plus.circle.fill")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()
                    .shadow(radius: 5)
            }
            .sheet(isPresented: $showingPostSheet) {
                PostVideoView(videos: $sampleVideos)
            }
        }
    }
}

// MARK: - Preview (No changes needed here)
#Preview {
    ShortFormContent()
}
