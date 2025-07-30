import SwiftUI
import AVKit
import WebKit

// MARK: - Model
struct ShortVideo2: Identifiable {
    let id = UUID()
    let title: String
    let username: String
    let videoURL: URL?
    let youtubeID: String? // Optional YouTube ID
}

// MARK: - YouTube Player View (WebView)
struct YouTubePlayerView2: UIViewRepresentable {
    let videoID: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.scrollView.isScrollEnabled = false
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let embedHTML = """
        <html>
            <head>
                <style>
                    body, html {
                        margin: 0;
                        padding: 0;
                        overflow: hidden;
                        height: 100%;
                        background-color: black;
                    }
                    .video-container {
                        position: absolute;
                        top: 0;
                        left: 0;
                        width: 100%;
                        height: 100%;
                    }
                    iframe {
                        width: 100%;
                        height: 100%;
                        border: none;
                    }
                </style>
            </head>
            <body>
                <div class="video-container">
                    <iframe 
                        src="https://www.youtube.com/embed/\(videoID)?playsinline=1&autoplay=1&mute=1&loop=1&controls=0&modestbranding=1&rel=0"
                        allow="autoplay; encrypted-media; picture-in-picture"
                        allowfullscreen>
                    </iframe>
                </div>
            </body>
        </html>
        """
        uiView.loadHTMLString(embedHTML, baseURL: nil)
    }
}

// MARK: - Video Slide View
struct VideoSlideView: View {
    let video: ShortVideo2
    @State private var player: AVPlayer?
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            if let url = video.videoURL {
                VideoPlayer(player: AVPlayer(url: url))
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .clipped()
                    .onAppear {
                        player = AVPlayer(url: url)
                        player?.isMuted = true
                        player?.play()
                    }
                    .onDisappear {
                        player?.pause()
                    }
            } else if let youtubeID = video.youtubeID {
                YouTubePlayerView2(videoID: youtubeID)
                    .aspectRatio(9/16, contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .clipped()
            }
            
            // Overlay text/buttons
            VStack(alignment: .leading, spacing: 10) {
                Text(video.title)
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                
                Text("@\(video.username)")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
                
                HStack(spacing: 20) {
                    Button { } label: {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.white)
                    }
                    Button { } label: {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundColor(.white)
                    }
                }
            }
            .padding()
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .ignoresSafeArea()
    }
}

// MARK: - Feed View
struct FeedView2: View {
    let videos: [ShortVideo2]
    
    var body: some View {
        GeometryReader { geometry in
            TabView {
                ForEach(videos) { video in
                    VideoSlideView(video: video)
                        .rotationEffect(.degrees(-90))
                        .frame(width: geometry.size.height, height: geometry.size.width)
                }
            }
            .rotationEffect(.degrees(90))
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(width: geometry.size.width, height: geometry.size.height)
            .ignoresSafeArea()
        }
    }
}

// MARK: - Main ShortFormContent View
struct ShortFormContent: View {
    let sampleVideos: [ShortVideo2] = [
        ShortVideo2(title: "Intro to Saving", username: "money_maven", videoURL: nil, youtubeID: "lWu2fw6APM4"),
        ShortVideo2(title: "Investing 101", username: "wealth_builder", videoURL: nil, youtubeID: "vKuK8AVL-1o")
    ]
    
    var body: some View {
        FeedView2(videos: sampleVideos)
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {  // Wrap in NavigationStack here for preview
        ShortFormContent()
    }
}
