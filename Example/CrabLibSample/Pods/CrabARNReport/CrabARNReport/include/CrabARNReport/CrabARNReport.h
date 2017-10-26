//
//  CrabARNReport.h
//  CrabARNReport
//
//  Created by Cai,Tengyuan on 2017/9/26.
//  Copyright © 2017年 baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 @brief 自定义页面名称
 */
@protocol CrabPagePathDelegate <NSObject>
@optional
/**
 @newAPI v_3.5.5
 @brief 未实现此函数时，Crab默认统计类名；实现此函数时，Crab统计传递的自定义页面ID
 */
- (NSString *)crabPageID;
@end

@interface CrabARNReport : NSObject

/**
 @brief  获取CrabCrashReport单例
 @return id 返回CrabCrashReport单例
 */
+ (instancetype)sharedInstance;

#pragma mark required - init
/**
 *  @brief   初始化crash收集环境,在配置完所有参数(set开头的函数)后调用。SDK最少只需要这一行代码即可收集Crash信息，其它配置信息可选择使用或者不用
 *  @param   appKey 在Crab平台（http://crab.baidu.com）注册产品线后自动生成的用于唯一标识产品线的ID
 *  @param   channel 发布App的渠道号，默认为'AppStore'
 */
- (void)initCrashReporterWithAppKey:(NSString *)appKey AndVersion:(NSString *)version AndChannel:(NSString *)channel ;

#pragma mark optional - Configure

/**
 *  @method setDebugEnabled:
 *  @brief  设置SDK的调试日志的开关,默认关闭
 *  @param  value   默认为:NO
 */
- (void)setDebugEnabled:(BOOL)value;

/**
 *  @method setStackSymbolsEnabled:
 *  @brief  设置SDK堆栈信息符号化的开关，默认关闭,在initCrashReporterWithAppKey之前调用
 *          不上传dsym文件也能够把Crash信息符号化，但是不能定位到代码具体行
 *  @param  value   默认为:NO
 */
- (void)setStackSymbolsEnabled:(BOOL)value;

/**
 *  @method setColloctCaughtExceptionEnable
 *  @brief 设置SDK是否收集已捕获异常，默认开启，在initCrashReporterWithAppKey之前调用
 *  @param value 默认为:YES
 */
- (void)setColloctCaughtExceptionEnable:(BOOL)value;


/**
 *  @method setCatchANREnable
 *  @brief 设置SDK是否收集卡顿信息，默认开启，在initCrashReporterWithAppKey之前调用
 *  @param value 默认为:YES
 */
- (void)setCatchANREnable:(BOOL)value;

/**
 *  @newApi v3.3.2
 *  @method setEventMonitorEnabled:
 *  @brief  设置SDK收集触摸事件信息的开关,默认关闭
 *  @param  value   默认为:NO
 */
- (void)setEventMonitorEnabled:(BOOL)value;

/**
 *    @method setANRTimeoutInterval
 *    @brief  设置判断卡顿的超时时长
 *
 *    @param value 卡顿阀值，单位毫秒(ms)，默认值 3000 ms，在 1000 ms < X < 15000 ms 之间设置
 */
- (void)setANRTimeoutInterval:(NSTimeInterval) value;

/**
 *    @newAPI v_3.5.0
 *    @method setCustomExceptionEnanle
 *    @brief  设置收集自定义异常信息开关
 *    @param value 默认为NO
 */
- (void)setCustomExceptionEnanle:(BOOL)value;

/**
 *  @method setAppUsername:
 *  @brief  设置app的用户名,可以在任何地方调用，一般在用户登录之后调用
 *          用于确定是哪个用户产生了Crash
 *  @param  appUsername App的用户名，例如设置成`xxxx@gmail.com`.
 */
- (void)setAppUsername:(NSString *)appUsername;

/**
 *  @method setBuildnumber:
 *  @brief  设置App的构建号 ,在initCrashReporterWithAppKey之前调用
 *          并不是Version、Build，默认为0(必须为整数，后续会取消这个限制)
 *  @param  buildnumber : Crab平台提出的用于区别同一个版本存在多次构建发版的情况，同jenkins构建号一致
 *          必须为整数，默认为:0，如果同一个版本不存在多次构建发版，可以忽略该项设置
 */
- (void)setBuildnumber:(NSString *)buildnumber;

#pragma mark optional - strategy config

/**
 *  @newApi  v_3.2.0
 *  @method setUploadCrashOnlyWifi
 *  @brief 设置是否只在WIFI环境下上传Crash|ANR|Exception(启动次数除外)，默认只在WIFI下上传，在initCrashReporterWithAppKey之前调用
 *  @param value 默认为:YES
 */
- (void)setUploadCrashOnlyWifi:(BOOL)value;

/**
 *  @newApi  v_3.2.0
 *  @brief 设置SDK debug log最多收集的行数，在initCrashReporterWithAppKey之前调用
 *  @param lines : 行数 默认100
 */
- (void)setLogcatMaxLines:(NSUInteger) lines;
/**
 *  @newApi  v_3.2.0
 *  @brief 设置SDK 页面跳转路径 最多收集的行数，在initCrashReporterWithAppKey之前调用
 *  @param lines : 行数 默认20
 */
- (void)setPagePathMaxLines:(NSUInteger) lines;


/**
 *  @newApi  v_3.3.1 在收集异常开关打开之后有效
 *  @brief 设置当App收集一次异常后，下次允许收集异常的间隔时间，在initCrashReporterWithAppKey之前调用
 *  @param value : 异常数量，单位毫秒(ms)，默认值 10000 ms，在 3000 ms < X < 100000 ms 之间设置
 */

- (void)setExceptionMonitorTimeoutInterval:(NSTimeInterval) value;

#pragma mark optional - other operate
/**
 *  @newApi  v_3.5.0
 *  @method  reportException: customInfo:
 *  @brief   设置收集自定义异常信息，一般在try-catch逻辑中上传catch到的异常
 *  @param exception 异常信息
 *  @param info      自定义信息
 */
+ (void)reportException:(NSException *)exception customInfo:(NSString *)info;


/**
 * @newApi  v_3.5.4
 * @brief 设置CUID
 * @param cuid CUID
 */
- (void)setCUID:(NSString *)cuid;

/**
 * @newApi  v_3.5.4
 * @brief 设置启动次数以冷启动计算，默认NO（热启动）
 */
- (void)setColdLaunchEnable:(BOOL)value;

/**
 * @newApi  v_3.5.4
 * @brief 设置冷启动间隔，默认30s
 * @param value 单位秒
 */
- (void)setColdLaunchInterval:(NSInteger)value;



@end
