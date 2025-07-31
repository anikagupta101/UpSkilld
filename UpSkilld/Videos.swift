//
//  Videos.swift
//  UpSkilld
//
//  Created by Scholar on 7/31/25.
//

import SwiftUI
import WebKit

struct Videos: View {
    var body: some View {
        ZStack {
            Image("backgroundImage")
                .resizable()
                .ignoresSafeArea()
                .allowsHitTesting(false)
            
            VStack(spacing: 10) {
                Text("Mark Tilbury: How to Invest for Teenagers")
                    //.padding()
                YouTubePlayerView(videoID: "-C_5hzJCHaY")
                .frame(width: 350, height: 200)
                //.frame(width: 300, height: 200)
                .cornerRadius(12)
                .shadow(radius: 5)
                //.padding()
                
                Text("Financial Literacy - Full Video")
                    //.padding()
                YouTubePlayerView(videoID: "4j2emMn7UaI")
                    .frame(width: 350, height: 200)
                    .cornerRadius(12)
                    .shadow(radius: 5)
                    //.padding()
                
                Text("Financial Literacy In 63 Minutes")
                .padding(.bottom, -10)
                Text("summary of Khan Academy's 30 hour financial literacy course")
                    //.offset(x:0, y: -10)
                    .font(.caption)
                    //.padding()
                YouTubePlayerView(videoID: "ouvbeb2wSGA")
                    .frame(width: 350, height: 200)
                    .cornerRadius(12)
                    .shadow(radius: 5)
                    //.padding()
            } //closes VStack
        } //closes ZStack
    } //closes var body
} //closes struct


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
    Videos()
}
