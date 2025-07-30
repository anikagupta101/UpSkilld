import SwiftUI
import AVKit
import WebKit

// MARK: - Model
struct ShortVideo2: Identifiable {
    let id = UUID()
    let title: String
    let username: String
    let videoURL: URL? // For local/remote AVPlayer content
    let youtubeID: String? // For YouTube embedded content
}

// MARK: - YouTube Player View (WebView)
struct YouTubePlayerView2: UIViewRepresentable {
    let videoID: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.scrollView.isScrollEnabled = false // Prevent scrolling within the web view
        webView.navigationDelegate = context.coordinator // Set the navigation delegate
        // Allow inline playback and autoplay
        webView.configuration.allowsInlineMediaPlayback = true
        let preferences = WKPreferences()
        preferences.javaScriptCanOpenWindowsAutomatically = true
        webView.configuration.preferences = preferences
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let embedURLString = "https://www.youtube.com/embed/\(videoID)?playsinline=1&autoplay=1&controls=0&showinfo=0&loop=1&playlist=\(videoID)&modestbranding=1"
        // Explanation of parameters:
        // playsinline=1: Allows playback in the WebView itself on iOS
        // autoplay=1: Starts playing automatically
        // controls=0: Hides YouTube player controls
        // showinfo=0: Hides video title and uploader info
        // loop=1 & playlist=VIDEO_ID: Makes the video loop
        // modestbranding=1: Removes YouTube logo from the control bar
        
        // Note: Autoplay on mobile browsers can be tricky and might require user interaction first.
        // For a true TikTok experience, consider using YouTube's iOS Player Helper library,
        // which gives more control than a simple WKWebView embed. However, for a quick solution,
        // this is a good start.
        
        if let url = URL(string: embedURLString) {
            uiView.load(URLRequest(url: url))
        }
    }
    
    // MARK: - Coordinator for WKWebViewDelegate
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: YouTubePlayerView2
        
        init(_ parent: YouTubePlayerView2) {
            self.parent = parent
        }
        
        // Handle potential navigation issues or allow specific URLs
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if navigationAction.navigationType == .linkActivated {
                // Prevent opening links within the webview, e.g., if user taps on YouTube logo
                decisionHandler(.cancel)
            } else {
                decisionHandler(.allow)
            }
        }
    }
}


// MARK: - Video Slide View
struct VideoSlideView: View {
    let video: ShortVideo2
    @State private var player: AVPlayer?
    @State private var isPlaying: Bool = false // To manage play/pause state
    
    var body: some View {
        ZStack(alignment: .bottomLeading) { // Put overlay content within ZStack
            if let url = video.videoURL {
                VideoPlayer(player: player)
                    // The .container, .scaledToFill, .ignoresSafeArea are crucial for filling the screen
                    .containerRelativeFrame([.horizontal, .vertical]) // SwiftUI 5+ for filling screen
                    .scaledToFill()
                    .ignoresSafeArea() // Ensure it goes edge to edge
                    .onAppear {
                        setupAVPlayer(url: url)
                        isPlaying = true
                    }
                    .onDisappear {
                        player?.pause()
                        player = nil // Release player when view disappears
                        isPlaying = false
                    }
            } else if let youtubeID = video.youtubeID {
                YouTubePlayerView2(videoID: youtubeID)
                    .containerRelativeFrame([.horizontal, .vertical]) // Fill screen
                    .scaledToFill() // Or .scaledToFit depending on desired YouTube behavior
                    .ignoresSafeArea()
                    // Note: YouTube playback controls within WKWebView are less controllable
                    // than AVPlayer. Autoplay might not always work without user interaction.
            }
            
            // Overlay text/buttons
            VStack(alignment: .leading, spacing: 8) { // Increased spacing for better readability
                Spacer() // Pushes content to the bottom
                
                Text(video.title)
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                    .lineLimit(2) // Limit lines for long titles
                
                Text("@\(video.username)")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
                
                // Example Interaction Buttons (replace with actual functionality)
                HStack(spacing: 20) { // Increased spacing between buttons
                    Button {
                        // Action for Heart
                        print("Liked \(video.title)")
                    } label: {
                        Image(systemName: "heart.fill")
                            .font(.title2) // Make icons larger
                            .foregroundColor(.white)
                    }
                    
                    Button {
                        // Action for Share
                        print("Shared \(video.title)")
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                            .font(.title2) // Make icons larger
                            .foregroundColor(.white)
                    }
                }
            }
            .padding([.leading, .bottom], 20) // Adjust padding for better placement
            .padding(.trailing, 10) // Small padding on the right for balance
        }
    }
    
    private func setupAVPlayer(url: URL) {
        player = AVPlayer(url: url)
        player?.isMuted = true // Start muted
        player?.play()
        
        // Loop the video
        NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: nil) // Remove previous observers
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime,
                                               object: player?.currentItem,
                                               queue: .main) { _ in
            player?.seek(to: .zero) // Go to beginning
            player?.play() // Play again
        }
    }
}

// MARK: - Feed View
struct FeedView2: View {
    let videos: [ShortVideo2]
    
    var body: some View {
        // Use TabView directly without GeometryReader and rotations for a native vertical scroll
        // Each TabView item will naturally fill the screen.
        TabView {
            ForEach(videos) { video in
                VideoSlideView(video: video)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // Swipe vertically
        //.ignoresSafeArea() // Let content extend to safe areas
    }
}

// MARK: - Main ShortFormContent View
struct ShortFormContent: View {
    let sampleVideos: [ShortVideo2] = [
        // Using sample YouTube IDs for demonstration
        // Note: For actual app, you'd likely fetch real vertical video URLs
        ShortVideo2(title: "Finance", username: "finance!", videoURL: nil, youtubeID: "lWu2fw6APM4"),
        ShortVideo2(title: "Investing", username: "investing", videoURL: nil, youtubeID: "vKuK8AVL-1o"),
        ShortVideo2(title: "Millionare Mindset", username: "millionares", videoURL: nil, youtubeID: "l52CNKgAP7g"),
        ShortVideo2(title: "Student Discounts", username: "discounts", videoURL: nil, youtubeID: "gjx_zc0Ut7U"),
        ShortVideo2(title: "Passive Income", username: "passiveincome", videoURL: nil, youtubeID: "aGLjcLFup94"),
        ShortVideo2(title: "Student Scholarships", username: "scholarships", videoURL: nil, youtubeID: "NF_dqRMssa8"),
        ShortVideo2(title: "FAFSA", username: "fafsa", videoURL: nil, youtubeID: "XrByfVYcugU"),
    ]
    
    var body: some View {
        FeedView2(videos: sampleVideos)
            .statusBarHidden(true) // Hide status bar for full immersive experience
    }
}

// MARK: - Preview
#Preview {
    // No need for NavigationStack here unless your app's root is a NavStack
    // For a standalone TikTok-like feed, it's typically full screen.
    ShortFormContent()
}
