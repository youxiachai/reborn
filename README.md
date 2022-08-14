# reborn

flutter 例子练习


## i10n 使用
app_localizations i10n 是怎么工作的

使用 flutter gen-l10n 来生成文件

## infinite_list

无限列表关键知识点

Provider 的库的使用

1. 创建一个ChangeNotifier
2. 对应的widget包一层ChangeNotifierProvider
3. 在用Selector 消费Provider 内容 包一层listview 

flutter 2.5 以后滑动和手势行为需要自行设置

https://docs.flutter.dev/release/breaking-changes/default-scroll-behavior-drag

## 桌面开发初始化窗口位置问题

1. windows 修改

用windows_manager 可以不用该太多代码 具体参考如下
https://github.com/leanflutter/window_manager/blob/main/README-ZH.md#%E5%9C%A8%E5%90%AF%E5%8A%A8%E6%97%B6%E9%9A%90%E8%97%8F

不过这样需要才 windows 拿到foucs 在初始化界面 ，好处是，可以在显示界面前，先用dart 预加载点内容

2. 或者直接修改`win32_window.cpp`

```cpp
  HWND window = CreateWindow(
     window_class, title.c_str(), WS_OVERLAPPEDWINDOW | WS_VISIBLE,
      Scale(origin.x, scale_factor), Scale(origin.y, scale_factor),
      Scale(size.width, scale_factor), Scale(size.height, scale_factor),
      nullptr, nullptr, GetModuleHandle(nullptr), this);

//去掉WS_VISIBLE 这样在启动的时候，等flutter启动才会显示。 省事可以这么干，稍微让启动没那么快
//如果渲染的内容，比设置的大小要少的话， 第一次启动，大概率会白屏
  HWND window = CreateWindow(
     window_class, title.c_str(), WS_OVERLAPPEDWINDOW ,
      Scale(origin.x, scale_factor), Scale(origin.y, scale_factor),
      Scale(size.width, scale_factor), Scale(size.height, scale_factor),
      nullptr, nullptr, GetModuleHandle(nullptr), this);

```

关于启动白屏的问题

https://github.com/leanflutter/window_manager/issues/185


Awesome Flutter Snippets

## TextField 的简单使用笔记

初始化 `var controller = TextEditingController();`

使用 `controller.text` 可以获得当前输入的内容



添加啊平台支持
flutter create --platforms=windows .


## 常用控件练习

ROW的点击效果可以用GestureDetector(behavior) 来控制， 在Windows， 不知道为啥没有点击的水波纹效果。

## nav 2 练习

1. page 用来表示 Navigator 路由栈中各个页面的配置信息。
2. Router 用来制定要由 Navigator 展示的页面列表，通常，该页面列表会根据系统或应用程序的状态改变而改变。
3. RouteInformationParser 持有 RouteInformationProvider 提供的  RouteInformation  ，可以将其解析为我们定义的数据类型。
4. RouterDelegate 定义应用程序中的路由行为，例如 Router 如何知道应用程序状态的变化以及如何响应。主要的工作就是监听  RouteInformationParser 和应用状态并通过当前页面列表构建・。
5. BackButtonDispatcher  响应后退按钮，并通知 Router

大致流程如下：

1. 当系统打开新页面（如 “books / 2”）时，RouteInformationParser 会将其转换为应用中的具体数据类型 T（如 BooksRoutePath）。
2. 该数据类型会被传递给 RouterDelegate 的 setNewRoutePath 方法，我们可以在这里更新路由状态（如通过设置 selectedBookId）并调用 notifyListeners 响应该操作。
3. notifyListeners 会通知 Router 重建 RouterDelegate（通过 build() 方法）.
4. RouterDelegate.build() 返回一个新的 Navigator 实例，并最终展示出我们想要打开的页面（如 selectedBookId）。


## Navigator 2 真的痛

使用Navigator 2 进行导航的发现，二级页面一直没法处理后退事件，在手机上，按后退就会直接退出App，查了半天发现原来是Navigator.pages 的值，我一直用错了

我之前是这么写的
```dart
Navigator(
      pages: [
        if (homeManager.currentItem == '/') HomePageView.page(),
        if (homeManager.currentItem == '/settings') SettingsPageView.page()
      ],
  
    )

```

结果路由的时候，死活没有二级，我把教程看了一遍又一遍，实在搞不懂，哪里出错了。

后面，实在查不到，就用最笨的方法，找个别人的例子，一遍遍的改来看看。 花了大概几个小时，在试了无数次方法后，发现原来Navigator.pages 要留个值在里面，才能popUp。。。

最后的修复方案
```dart

Navigator(
      key: navigatorKey,
      pages: [
        HomePageView.page(),
        if (homeManager.currentItem == '/settings') SettingsPageView.page()
      ],
    )

```


处理物理的后退按钮 需要注意

```dart
  @override
  GlobalKey<NavigatorState>?  navigatorKey = GlobalKey<NavigatorState>();

  //不要用
  @override
  GlobalKey<NavigatorState>? get navigatorKey => GlobalKey<NavigatorState>();

```


## Flutter Provider 小记

https://juejin.cn/post/7067356022272163847

1. 创建一个继承ChangeNotifier类用来提供 给provider 
2. 提供者：常用 ChangeNotifierProvider 这是监听一个， MultiProvder 这个可以注册多个
3. 消费者： Consumber 监听整个provider 或者 Selector 监听provider的某个值。注意可以用(BuildContext context,Object object,Widget? child), 来优化刷新，其中child 为UI不更新的部分

还有 ProxyProvider 整个后面用到了在做笔记

消费者还可用Provider.of() 来获取 lister: false 不会触发更新 BuildContext.read BuildContext.watch BuildContext.select

vs code 快捷键速查

按ctrl+k,s 然后 在搜索框中输入 upper/lower,输入相应的快捷键设置，点击OK 生效。