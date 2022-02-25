//
//  ViewWikipediaResults.swift
//  ProofOfConcept
//
//  Created by Philipp Maier on 2/23/22.
//

import SwiftUI
import WebKit

// Creates a custom representation of a webpage in SwiftUI

struct webView: View {
    
    var address: Geosearch
    
    func buildURL(pageID: Int) -> String {
        var fullURL : String
        let baseURL = "https://en.m.wikipedia.org/w/index.php?curid="
        
        fullURL = baseURL + String(pageID)
        print( fullURL)
        return fullURL
    }
    
    var body: some View{
        
        SwiftUIWebView(url: URL(string: buildURL(pageID: address.pageid)))
        
    }
}

struct SwiftUIWebView: UIViewRepresentable {
    
    let url: URL?
    
    func makeUIView(context: Context) -> WKWebView {
        
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        
        return WKWebView(
            frame: .zero,
            configuration: config)
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
        guard let myURL = url else {
            return
        }
        
        let request = URLRequest(url: myURL)
        
        uiView.load(request)
    }
}
