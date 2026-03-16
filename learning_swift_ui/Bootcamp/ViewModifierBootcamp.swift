//
//  ViewModifierBootcamp.swift
//  learning_swift_ui
//
//  Created by Elaine on 2026/3/16.
//

import SwiftUI

// 自定义 modifier
struct DefaultButtonViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundStyle(.white)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(Color.red)
            .cornerRadius(10)
            .shadow(radius: 10)
    }
}

// 自定义一个带参数的 modifier
struct DefaultButtonViewModifierWithParams: ViewModifier {
    let backgroundColor: Color
    func body(content: Content) -> some View {
        content
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(10)
            .shadow(radius: 10)
    }
}

// 提供一个扩展
extension View {
    func withDefaultButtonFormatting() -> some View {
        //self.modifier(DefaultButtonViewModifier())
        modifier(DefaultButtonViewModifier()) // 等价
    }
    
    // 默认参数为蓝色
    func withDefaultButtonWithParams(bgColor: Color = .blue) -> some View {
        modifier(DefaultButtonViewModifierWithParams(backgroundColor: bgColor))
    }
}

struct ViewModifierBootcamp: View {
    var body: some View {
        VStack(spacing: 10) {
            Text("Hello world!")
                .modifier(DefaultButtonViewModifier())
            
            Text("Hello everyone")
                .modifier(DefaultButtonViewModifier())
            
            Text("Click")
                .withDefaultButtonFormatting()
            
            Text("带参数的modifier")
                .withDefaultButtonWithParams(bgColor: .orange)
            Text("不传参数默认为蓝色")
                .withDefaultButtonWithParams()
        }
        .padding()
    }
}

#Preview {
    ViewModifierBootcamp()
}
