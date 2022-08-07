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
