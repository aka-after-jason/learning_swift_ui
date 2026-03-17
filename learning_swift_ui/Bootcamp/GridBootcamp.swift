//
//  GridBootcamp.swift
//  learning_swift_ui
//
//  Created by Elaine on 2026/3/17.
//

import SwiftUI

struct GridBootcamp: View {
    
    let columns1: [GridItem] = [
        GridItem(.fixed(50), spacing: 10, alignment: nil),
        GridItem(.fixed(150), spacing: 10, alignment: nil),
        GridItem(.fixed(50), spacing: 10, alignment: nil)
    ]
    
    let columns2: [GridItem] = [
        GridItem(.flexible(), spacing: nil, alignment: nil),
        GridItem(.flexible(), spacing: nil, alignment: nil),
        GridItem(.flexible(), spacing: nil, alignment: nil)
    ]
    
    let columns3: [GridItem] = [
        GridItem(.adaptive(minimum: 100, maximum: 100), spacing: nil, alignment: nil),
        GridItem(.adaptive(minimum: 200, maximum: 200), spacing: nil, alignment: nil)
    ]
    
    // 定义两行的网格
    let rows: [GridItem] = [
        GridItem(.fixed(100), spacing: nil, alignment: nil),
        GridItem(.fixed(100), spacing: nil, alignment: nil)
    ]
    
    var body: some View {
        //lazyvgrid
        lazyhgrid
    }
}

#Preview {
    GridBootcamp()
}

extension GridBootcamp {
    
    private var lazyhgrid: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows) {
                ForEach(0..<20) {index in
                    Rectangle()
                        .fill(.orange)
                        .frame(width: 100) // 这里需要设置宽度
                        .cornerRadius(20)
                }
            }
        }
    }
    
    private var lazyvgrid: some View {
        ScrollView {
            Rectangle()
                .fill(.orange)
                .frame(height: 400)
            
            LazyVGrid(
                columns: columns2,
                alignment: .center,
                spacing: 10,
                pinnedViews: [.sectionHeaders],
                content: {
                    Section(content: {
                        ForEach(0..<40){ _ in
                            Rectangle()
                                .frame(height: 150) // 这里需要设置高度
                        }
                    }, header: {
                        Text("Section1")
                            .foregroundStyle(.white)
                            .font(.title)
                            .background(.blue)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    })
                    
                    Section(content: {
                        ForEach(0..<40){ _ in
                            Rectangle()
                                .fill(.red)
                                .frame(height: 150)
                        }
                    }, header: {
                        Text("Section2")
                            .foregroundStyle(.white)
                            .font(.title)
                            .background(.blue)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    })
                }
            )
        }
        
    }
}
