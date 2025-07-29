//
//  Tutorials.swift
//  UpSkilld
//
//  Created by Scholar on 7/29/25.
//

import SwiftUI
import WebKit

//Mark Tilbury: How to Invest for Beginners in 2025: https://www.youtube.com/watch?v=Ay4fmZdZqJE

//Financial Literacy - Full Video: https://www.youtube.com/watch?v=4j2emMn7UaI

//summary of Khan Academy's 30 hour financial literacy course in 1 hour: https://www.youtube.com/watch?v=ouvbeb2wSGA

//Khan Academy finance playlist: https://www.youtube.com/playlist?list=PL9ECA8AEB409B3E4F

//Personal finance for teenagers playlist: https://www.youtube.com/playlist?list=PLUpA0gs6ldq5yr9CoOvVu_CnTGzr3mdj9

struct Tutorials: View {
    var body: some View {
        VStack {
            Text("Mark Tilbury: How to Invest for Teenagers")
                .font(.headline)
                .padding()

            YouTubePlayerView(videoID: "-C_5hzJCHaY")
                .frame(height: 250)
                .cornerRadius(12)
                .shadow(radius: 5)
                .padding()
        }
    }
}


struct YouTubePlayerView: UIViewRepresentable {
    let videoID: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.scrollView.isScrollEnabled = false // Optional: prevent scrolling
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let embedHTML = """
        <html>
            <body style="margin:0px;padding:0px;overflow:hidden">
                <iframe width="100%" height="100%" 
                        src="https://www.youtube.com/embed/\(videoID)?playsinline=1"
                        frameborder="0"
                        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                        allowfullscreen>
                </iframe>
            </body>
        </html>
        """
        uiView.loadHTMLString(embedHTML, baseURL: nil)
    }
}


#Preview {
    Tutorials()
}
