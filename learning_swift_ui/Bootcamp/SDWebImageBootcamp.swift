//
//  SDWebImageBootcamp.swift
//  learning_swift_ui
//
//  Created by Elaine on 2026/3/16.
//

import SwiftUI

struct SDWebImageBootcamp: View {
    let urlString = "https://picsum.photos/id/237/200/300"
    var body: some View {
        ImageLoader(url: urlString)
            .frame(width: 200,height: 200)
    }
}

#Preview {
    SDWebImageBootcamp()
}
