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
