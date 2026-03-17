//
//  KingfisherBootcamp.swift
//  learning_swift_ui
//
//  Created by Elaine on 2026/3/17.
//

import SwiftUI

struct KingfisherBootcamp: View {
    let urlString = "https://picsum.photos/id/237/200/300"
    var body: some View {
        ImageLoader(url: urlString)
            .frame(width: 200, height: 200)
    }
}

#Preview {
    KingfisherBootcamp()
}
