//
//  GenericsBootcamp.swift
//  learning_swift_ui
//
//  Created by Elaine on 2026/3/16.
//

import Combine
import SwiftUI

struct StringModel {
    let info: String?
    
    func removeInfo() -> StringModel {
        StringModel(info: nil) // 返回一个空的 StringModel
    }
}

struct BoolModel {
    let info: Bool?
    
    func removeInfo() -> BoolModel {
        BoolModel(info: nil)
    }
}

// 泛型的使用
struct GenericModel<T> {
    let info: T?
    
    func removeInfo() -> GenericModel {
        return GenericModel(info: nil)
    }
}

class GenericsBootcampViewModel: ObservableObject {
    @Published var stringModel = StringModel(info: "Hello World!")
    @Published var boolModel = BoolModel(info: true)
    
    @Published var genericStringModel = GenericModel(info: "Generic")
    @Published var genericBoolModel = GenericModel(info: true)
    
    func removeData() {
        stringModel = stringModel.removeInfo()
        boolModel = boolModel.removeInfo()
        genericStringModel = genericStringModel.removeInfo()
        genericBoolModel = genericBoolModel.removeInfo()
    }
}

// 泛型 view
struct GenericView<T: View>: View {
    let title: String
    let content: T
    var body: some View {
        VStack {
            Text(title)
            content
        }
    }
}

struct GenericsBootcamp: View {
    @StateObject private var vm = GenericsBootcampViewModel()

    var body: some View {
        VStack {
            Text(vm.stringModel.info ?? "no data")
            Text(vm.boolModel.info?.description ?? "no data")
            Text(vm.genericStringModel.info ?? "no data")
            Text(vm.genericBoolModel.info?.description ?? "no data")
            
            GenericView(title: "这是泛型的View", content: Image(systemName: "heart.fill"))
        }
        .onTapGesture {
            vm.removeData()
        }
    }
}

#Preview {
    GenericsBootcamp()
}
