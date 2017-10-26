//
//  AppDelegate.m
//  CrabSample
//
//  Created by Crab on 16/9/18.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import "AppDelegate.h"
//#import "CrabCrashReport.h"
#import "ViewController.h"
//#import "CrabARNReport.h"
//#import <CrabARNReport/CrabARNReport.h>
#import "CrabARNReport.h"



@interface AppDelegate () //<CrashSignalCallBackDelegate>

@end

@implementation AppDelegate

/**
 *  @protocol crashCallBack:
 *  @brief   必须覆写此函数，Crash发生时候可以回调，开发者可以在此函数中完成一些自己的记录工作(保存现场数据等)
 *  @param  无
 *  @return void.
 */
//- (void)crashCallBack{
//    // 这些数据最终可以在平台看见
//    [[CrabARNReport sharedInstance] addCrashAttachLog:@"value1" forKey:@"key1"];
//    [[CrabARNReport sharedInstance] addCrashAttachLog:@"value2" forKey:@"key2"];
//    [[CrabARNReport sharedInstance] addCrashAttachLog:@"value3" forKey:@"Crab"];
//}

/**
 *  CrabSDk 的可选配置
 */
- (void)optionalConfig
{
    // CrabSDK log信息
    [[CrabARNReport sharedInstance] setDebugEnabled:YES];
////    [[CrabCrashReport sharedInstance] setBuildnumber:@"1"];
    [[CrabARNReport sharedInstance] setUploadCrashOnlyWifi:NO];
    [[CrabARNReport sharedInstance] setLogcatMaxLines:100];
    [[CrabARNReport sharedInstance] setPagePathMaxLines:20]; // 设置收集页面跳转路径容器大小
    [[CrabARNReport sharedInstance] setCatchANREnable:YES];
    [[CrabARNReport sharedInstance] setANRTimeoutInterval:1000]; // 设置重复卡顿信息收集间隔
    [[CrabARNReport sharedInstance] setEventMonitorEnabled:YES]; // 设置操作事件统计开关
    
    [[CrabARNReport sharedInstance] setCustomExceptionEnanle:YES];  // 收集自定义异常信息开关
    //登录之后可以设置App的用户名(如果有的话)
    [[CrabARNReport sharedInstance] setAppUsername:@"CrabARN"];
    [[CrabARNReport sharedInstance] setCUID:@"test-for-cuid-arn"];
    [[CrabARNReport sharedInstance] setColdLaunchEnable:YES];
    [[CrabARNReport sharedInstance] setColdLaunchInterval:10];
//    [[CrabCrashReport sharedInstance] setCrashCallBackDelegate:self];
}

void my_handler(NSException *e) {
    NSLog(@"my handler");
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 可选配置
    [self optionalConfig];
    
    // 必要配置
    // 设置Crash回调函数
//    [[CrabARNReport sharedInstance] setCrashCallBackDelegate:self];
    
    //Crab SDK初始化代码
#warning 此处替换平台申请的App Key
//    [[CrabCrashReport sharedInstance] initCrashReporterWithAppKey:@"Your App Key"
//                                                       AndVersion:@"Version Code"
//                                                       AndChannel:@"AppStore"];
    // Demo
    [[CrabARNReport sharedInstance] initCrashReporterWithAppKey:@"888ded4f1d0d48b1" AndVersion:@"3.6.0" AndChannel:@"AppStore-ARN"];
    
    NSSetUncaughtExceptionHandler(&my_handler);
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    ViewController *rootViewController = [[ViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
