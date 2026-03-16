//
//  Test.swift
//  learning_swift_ui
//
//  Created by Elaine on 2026/3/2.
//

import SwiftUI
import Combine

struct Test: View {
    var body: some View {
        // TextExample()
        // ImageExample()
        // ButtonExample()
        // HStackExample()
        // VStackExample()
        // ZStackExample()
        // LazyVGridExample()
        // LazyHGridExample()
        //StateExample()
        //ParentView()
        //MainView()
        //AppRootView()
        //NavigationExample()
        //ModernNavigationExample()
        //TabViewExample()
        AnimationExample()
    }
}



/// 动画和手势
/// 基础动画
/// SwiftUI 提供了简单易用的动画系统,只需要几行代码可实现流畅的动画效果
struct AnimationExample: View {
    @State private var scale = 1.0
    @State private var rotation = 0.0
    @State private var color = Color.blue
    var body: some View {
        VStack{
            Rectangle().fill(color).frame(width: 100,height: 100).scaleEffect(scale).rotationEffect(.degrees(rotation))
            // 应用动画
                .animation(.spring(), value: scale)
                .animation(.easeInOut(duration: 1), value: rotation)
                .animation(.easeInOut, value: color)
        }
        
        HStack(spacing:20){
            Button("缩放"){
                scale = scale == 1.0 ? 1.5 : 1.0
            }
            
            Button("旋转"){
                rotation = rotation == 0 ? 360 : 0
            }
            
            Button("变色"){
                color = color == .blue ? .red : .blue
            }
        }
    }
}



/// TabView 用于创建标签式界面,方便在不同视图间切换
struct TabViewExample: View {
    var body: some View {
        TabView{
            MyHomeView().tabItem {
                Label("首页",systemImage: "house")
            }
            MySearchView().tabItem {
                Label("搜索",systemImage: "magnifyingglass")
            }
            MyProfileView().tabItem {
                Label("我的",systemImage: "person")
            }
        }
    }
}

struct MyHomeView: View {
    var body: some View {
        Text("首页内容").font(.largeTitle)
    }
}

struct MySearchView: View {
    var body: some View {
        Text("搜索内容").font(.largeTitle)
    }
}

struct MyProfileView: View {
    var body: some View {
        Text("我的内容").font(.largeTitle)
    }
}


/// 导航与数据流
/// NavigationView 和 NavigationLink
/// SwiftUI 提供了简单的导航系统,用于在视图之间导航
struct NavigationExample: View {
    let fruits = ["苹果","香蕉","橙子","葡萄","草莓"]
    var body: some View {
        NavigationView {
            List(fruits,id: \.self){ fruit in
                NavigationLink(destination: DetailView(fruit: fruit)) {
                    Text(fruit)
                }
            }.navigationTitle("水果列表")
        }
    }
}

struct DetailView: View {
    let fruit: String
    var body: some View {
        VStack{
            Text(fruit).font(.largeTitle).padding()
            Image(systemName: "leaf.fill").font(.system(size: 60)).foregroundStyle(.green)
        }.navigationTitle(fruit)
    }
}


/// 在 iOS 16 及以上版本, Apple 推荐使用新的导航API, NavigationStack 和 NavigationSplitView
struct ModernNavigationExample: View {
    let fruits = ["苹果","香蕉","橙子","西瓜"]
    var body: some View {
        NavigationStack{
            List(fruits,id: \.self){ fruit in
                NavigationLink(fruit){
                    DetailView(fruit: fruit)
                }
            }.navigationTitle("水果列表")
        }
    }
}



/// 状态管理
/// @State 用于视图内部简单状态管理,当状态改变时,视图会自动更新渲染
struct StateExample: View {
    // @State 属性包装器用于存储视图内部的状态
    @State private var count = 0
    @State private var name = ""
    var body: some View {
        VStack(spacing: 20) {
            Text("计数:\(count)").font(.headline)
            Button("增加") {
                count += 1
            }.buttonStyle(.bordered)
            TextField("请输入名称:", text: $name).textFieldStyle(.roundedBorder).padding(.horizontal)
            Text("你好,\(name.isEmpty ? "访客" : name)")
        }
    }
}

/// @Binding 用于在视图之间创建双向连接,使子视图可以修改父视图的状态
struct ParentView: View { //父视图
    @State private var isOn = false
    var body: some View {
        VStack{
            Text("开关的状态: \(isOn ? "开启" : "关闭")")
            SonView(isOn: $isOn)
        }
    }
}

struct SonView: View {//子视图
    // 使用 @Binding 接收父视图的状态
    @Binding var isOn: Bool
    var body: some View {
        Toggle("切换状态", isOn: $isOn).padding()
    }
}



/// ObservableObject 和 @ObservedObject
/// 用于管理更复杂的状态,适合跨多个视图共享的数据
// 定义一个可观察的对象
class UserSettings: ObservableObject {
    // @Published 属性包装器使属性变化时发布通知
    @Published var username = ""
    @Published var isSubscribed = false
}

struct ProfileView: View {
    // 使用 @ObservedObject 观察外部对象的变化
    @ObservedObject var settings: UserSettings
    var body: some View {
        Form{
            Section("个人信息"){
                TextField("用户名",text: $settings.username)
                Toggle("订阅通知", isOn: $settings.isSubscribed)
            }
            Section("摘要"){
                Text("用户名:\(settings.username)")
                Text("订阅状态:\(settings.isSubscribed ? "已订阅" : "未订阅")")
            }
        }
    }
}

struct MainView: View {
    // 创建 UserSettings 实例
    @StateObject private var settings = UserSettings()
    var body: some View {
        ProfileView(settings: settings)
    }
}

/// @EnvironmentObject
/// 用于在整个视图层次结构中共享数据,无需显示传递
class AppData: ObservableObject {
    @Published var theme = "light"
    @Published var loggedIn = false
}
// 根视图
struct AppRootView: View {
    // 创建 AppData 实例
    @StateObject private var appData = AppData()
    var body: some View {
        // 将 appData 注入环境
        MyContentView().environmentObject(appData)
    }
}

// 内容视图
struct MyContentView: View {
    var body: some View {
        SettingsView()
    }
}

// 设置视图,无需传递 appData
struct SettingsView: View {
    // 从环境中获取注入的 appData 对象
    @EnvironmentObject var appData: AppData
    var body: some View {
        Form{
            Picker("主题",selection: $appData.theme){
                Text("浅色").tag("light")
                Text("深色").tag("dark")
            }
            Toggle("登录状态:",isOn: $appData.loggedIn)
        }.navigationTitle("设置")
    }
}

// LazyVGrid 和 LazyHGrid
// 用于创建灵活的网络布局,适用于大量数据展示

/// LazyVGrid
struct LazyVGridExample: View {
    let items = 1 ... 20
    let columns = [GridItem(.adaptive(minimum: 80, maximum: 120), spacing: 16)]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(items, id: \.self) { item in
                    Text("\(item)").font(.system(.title3, design: .rounded)).frame(height: 70).frame(maxWidth: .infinity).background(Color.purple.opacity(0.1 + Double(item % 5) / 20)).cornerRadius(10)
                }
            }
        }.padding()
    }
}

/// LazyHGrid
struct LazyHGridExample: View {
    let rows = [GridItem(.fixed(30)), GridItem(.fixed(30))]

    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows) {
                ForEach(0x1f600 ... 0x1f679, id: \.self) { value in
                    Text(String(format: "%x", value))
                    Text(emoji(value))
                        .font(.largeTitle)
                }
            }
        }
    }

    private func emoji(_ value: Int) -> String {
        guard let scalar = UnicodeScalar(value) else { return "?" }
        return String(Character(scalar))
    }
}

/// 布局系统 HStack VStack ZStack
/// HStack 用于水平排列子视图
struct HStackExample: View {
    /// 实现body计算属性
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            ForEach(1 ..< 4) { index in
                RoundedRectangle(cornerRadius: 10).fill(Color.blue.opacity(0.2 *
                        Double(index))).frame(width: 70, height: 50)
                    .overlay(Text("\(index)"))
            }
        }.padding().border(Color.gray.opacity(0.5))
    }
}

/// VStack 用于垂直排列子视图
struct VStackExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("标题").font(.headline)
            Text("副标题").font(.subheadline).foregroundStyle(.gray)
            Text("正文内容").font(.body)
        }.padding().background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.1)))
    }
}

/// ZStack 深度堆栈 用于叠加子视图,后添加的视图在上层
struct ZStackExample: View {
    var body: some View {
        ZStack {
            // 底层: 背景
            Rectangle().fill(
                LinearGradient(
                    gradient: Gradient(colors: [.blue, .purple]), startPoint: .topLeading, endPoint: .bottomTrailing
                )
            ).frame(width: 200, height: 200).cornerRadius(20)

            // 中层: 图标
            Image(systemName: "star.fill").font(.system(size: 70)).foregroundStyle(.white.opacity(0.7))

            // 顶层: 文字
            Text("ZStack 示例").font(.headline).padding(8).background(Color.white.opacity(0.4)).cornerRadius(10).padding(.top, 100)
        }
    }
}

/// Button 响应用户交互的基本控件
struct ButtonExample: View {
    @State private var count = 0

    var body: some View {
        VStack(spacing: 20) {
            Button("点击我") {
                count += 1
            }.buttonStyle(.borderedProminent)

            // 自定义样式按钮
            Button {
                count -= 1
            } label: {
                Label("减少计数", systemImage: "minus.circle").padding().background(Color.red.opacity(0.2).cornerRadius(8))
            }

            Text("当前计数: \(count)")
        }
    }
}

/// Image
/// 用于显示图像的组件: 支持系统图标,资源图像和网络图像
struct ImageExample: View {
    var body: some View {
        VStack(alignment: .leading) {
            // 设置系统图标 可下载苹果官方的 sf symbols 软件 查找
            Image(systemName: "heart.fill").font(.system(size: 50)).foregroundStyle(.red)

            // 资源图像
            Image("test.png").resizable().aspectRatio(contentMode: .fit).frame(width: 100, height: 100).clipShape(Circle()).overlay(Circle().stroke(Color.blue, lineWidth: 2))

            // 网络图像: 需要结合 AsyncImage 或 第三方库
            AsyncImage(url: URL(string: "https://images.pexels.com/photos/28337239/pexels-photo-28337239.jpeg")) { image in
                image.resizable().aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }.frame(width: 100, height: 100)

        }.padding()
        // .background(Color.yellow)
    }
}

/// Text
struct TextExample: View {
    var body: some View {
        // SwiftUI 使用修饰符链式调用来设置视图的属性和行为,每个修饰符会返回一个新的视图
        // Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/).font(.largeTitle).foregroundStyle(.blue).padding()

        // Text文本 用于显示文本的基本组件
        VStack(alignment: .leading, spacing: 10) {
            // Text 基本文本
            Text("Hello,SwiftUI")

            // 自定义字体
            Text("自定义字体").font(.title).fontWeight(.bold)

            // 自定义颜色
            Text("自定义颜色").foregroundStyle(.blue)

            // 带下划线的文本
            Text("带下划线的文本").underline()

            // 多行文本
            Text("多行文本效果.这是一段较长的内容,可以展示文本换行效果可以展示文本换行效果可以展示文本换行效果可以展示文本换行效果").lineLimit(2).lineSpacing(5)
        }.padding().background(Color.yellow).cornerRadius(20)
    }
}

#Preview {
    Test()
}
