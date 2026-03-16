//
//  ViewBuilderBootcamp.swift
//  learning_swift_ui
//
//  Created by Elaine on 2026/3/16.
//

import SwiftUI

struct RegularHeaderView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Title")
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            Text("Description")
                .font(.callout)
            
            RoundedRectangle(cornerRadius: 5)
                .frame(height: 2)
        }
        .padding()
     }
}

struct GenericHeaderView<T: View>: View {
    let title: String
    let content: T
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.semibold)
            content
            RoundedRectangle(cornerRadius: 5)
                .frame(height: 2)
        }
        .padding()
    }
}

struct ViewBuilderHeaderView<T: View>: View {
    let title: String
    @ViewBuilder let content: T
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.semibold)
            content
            RoundedRectangle(cornerRadius: 5)
                .frame(height: 2)
        }
        .padding()
    }
}


// 自定义 HStack
struct CustomeHStack<T: View>: View {
    let content: T
    init(@ViewBuilder content: () -> T){
        self.content = content()
    }
    var body: some View {
        HStack {
            content
        }
    }
}


struct ChooseView: View {
    
    enum ViewType {
        case one, two, three
    }
    
    let viewType: ViewType
    
    var body: some View {
        VStack {
            headerSection
        }
    }
    
    // @ViewBuilder 的第二种用法
    @ViewBuilder private var headerSection: some View {
        switch viewType {
        case .one:
            viewOne
        case .two:
            viewTwo
        case .three:
            viewThree
        }
    }
    
    private var viewOne: some View {
        Text("One")
    }
    
    private var viewTwo: some View {
        VStack {
            Text("Two")
            Image(systemName: "bolt.fill")
        }
    }
    
    private var viewThree: some View {
        Image(systemName: "heart.fill")
    }
}


struct ViewBuilderBootcamp: View {
    var body: some View {
        VStack {
            RegularHeaderView()
            
            GenericHeaderView(title: "Generic1", content: Text("Description"))
                .font(.callout)
            
            GenericHeaderView(title: "Generic 2", content:
                VStack {
                    Image(systemName: "heart.fill")
                    Text("Description")
                })
            
            
            ViewBuilderHeaderView(title: "ViewBuilder1") {
                VStack {
                    Image(systemName: "heart.fill")
                    Text("Description")
                }
            }
            
            HStack {
                Text("系统的HStack")
            }
            
            CustomeHStack {
                Text("自定义的HStack")
            }
            
            
            ChooseView(viewType: .two)
            
            Spacer()
        }
    }
}


#Preview {
    ViewBuilderBootcamp()
}
