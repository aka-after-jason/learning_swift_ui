//
//  ImageLoader.swift
//  learning_swift_ui
//
//  Created by Elaine on 2026/3/17.
//

import SwiftUI
import SDWebImageSwiftUI
import Kingfisher

struct ImageLoader: View {
    let url: String
    var body: some View {
        // 将来这里可以加入更多的Loader, 比如 kingfisher
        Rectangle()
            .opacity(0)
            .overlay {
                //SDWebImageLoader(url: url)
                    //.allowsHitTesting(false)
                
                KingfisherLoader(url: url)
            }
            .clipped()
    }
}

fileprivate struct KingfisherLoader: View {
    let url: String
    var body: some View {
        KFImage(URL(string: url))
    }
}

fileprivate struct SDWebImageLoader: View {
    let url: String
    var body: some View {
        WebImage(url: URL(string: url)) { image in
            image.resizable()
        } placeholder: {
                Rectangle().foregroundColor(.gray)
        }
        .onSuccess { image, data, cacheType in
            
        }
        .onFailure { error in
            
        }
        .indicator(.activity) // Activity Indicator
        .transition(.fade(duration: 0.5)) // Fade Transition with duration
        .scaledToFit()
        //.frame(width: 300, height: 300, alignment: .center)
        //.aspectRatio(contentMode: contentMode)
    }
}

#Preview {
    ImageLoader(url: "")
}
