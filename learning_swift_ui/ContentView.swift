//
//  ContentView.swift
//  learning_swift_ui
//
//  Created by Elaine on 2026/3/2.
//

import SwiftUI

/// 所有的UI组件都需要遵循 View 协议,并实现body计算属性
struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Text("What a  nice day")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
