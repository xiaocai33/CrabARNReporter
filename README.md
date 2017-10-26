# CrabARNReporter
集成方式:
(1) 在Podfile文件中添加以下代码：(推荐)
pod 'CrabARNReport'

(2) 下载SDK, 拖动到项目

初始化SDK

在application:didFinishLaunchingWithOptions:方法中加入如下代码初始化SDK：
[[CrabCrashReport sharedInstance] initCrashReporterWithAppKey:@"YourAppKey"
                                                   AndVersion:@"VersionCode"
                                                   AndChannel:@"ChannelName"];
YourAppKey为在Crab(crab.baidu.com)平台申请的AppKey

VersionCode为该App的版本号

ChannelName默认为AppStore

Clean Project 后编译并运行你的工程，即可拥有Crab的ARN收集上报功能。
注：如果你的项目中引用了其它同类产品，我们强烈建议你把它们的错误收集功能关闭，并且将Crab的初始代码放在同类产品后面
