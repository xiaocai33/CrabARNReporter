//
//  ViewController.m
//  CrabSample
//
//  Created by Crab on 16/9/18.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import "ViewController.h"
//#import <CrabARNReport/CrabARNReport.h>
#import "CrabARNReport.h"
#import "BSBacktraceLogger.h"
@interface ViewController () <CrabPagePathDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    NSLog(@"%@",NSHomeDirectory());
    [super viewDidLoad];
    
    self.title = @"CrabSampleDemo";
    self.view.backgroundColor = [UIColor whiteColor];
//    UIButton *crashTestBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [crashTestBtn setBackgroundColor:[UIColor orangeColor]];
//    [crashTestBtn setFrame:CGRectMake(50, 100, 300, 50)];
//    [crashTestBtn setTitle:@"点击我将崩溃" forState:UIControlStateNormal];
//    [crashTestBtn addTarget:self action:@selector(crashTestAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:crashTestBtn];
    
    UIButton *caughtExceptionTestBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [caughtExceptionTestBtn setBackgroundColor:[UIColor orangeColor]];
    [caughtExceptionTestBtn setFrame:CGRectMake(50, 100, 300, 50)];
    [caughtExceptionTestBtn setTitle:@"点击我将捕获异常" forState:UIControlStateNormal];
    [caughtExceptionTestBtn addTarget:self action:@selector(caughtExceptionTestBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:caughtExceptionTestBtn];
    
    UIButton *ANRTestBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [ANRTestBtn setBackgroundColor:[UIColor orangeColor]];
    [ANRTestBtn setFrame:CGRectMake(50, 170, 300, 50)];
    [ANRTestBtn setTitle:@"点击我将发生卡顿" forState:UIControlStateNormal];
    [ANRTestBtn addTarget:self action:@selector(ANRTestBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ANRTestBtn];
    
    UIButton *TestBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [TestBtn1 setBackgroundColor:[UIColor orangeColor]];
    [TestBtn1 setFrame:CGRectMake(50, 240, 300, 50)];
    [TestBtn1 setTitle:@"testNSArrayCrash" forState:UIControlStateNormal];
    [TestBtn1 addTarget:self action:@selector(testNSArrayCrash) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:TestBtn1];
    
    UIButton *TestBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [TestBtn2 setBackgroundColor:[UIColor orangeColor]];
    [TestBtn2 setFrame:CGRectMake(50, 310, 300, 50)];
    [TestBtn2 setTitle:@"testNSMutableArrayCrash" forState:UIControlStateNormal];
    [TestBtn2 addTarget:self action:@selector(testNSMutableArrayCrash) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:TestBtn2];
    
    UIButton *TestBtn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [TestBtn3 setBackgroundColor:[UIColor orangeColor]];
    [TestBtn3 setFrame:CGRectMake(50, 390, 300, 50)];
    [TestBtn3 setTitle:@"testNSStringCrash" forState:UIControlStateNormal];
    [TestBtn3 addTarget:self action:@selector(testNSStringCrash) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:TestBtn3];
    
    UIButton *TestBtn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [TestBtn4 setBackgroundColor:[UIColor orangeColor]];
    [TestBtn4 setFrame:CGRectMake(50, 460, 300, 50)];
    [TestBtn4 setTitle:@"testCrashKillerUnrecognizeSelector" forState:UIControlStateNormal];
    [TestBtn4 addTarget:self action:@selector(testCrashKillerUnrecognizeSelector) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:TestBtn4];
    
    UIButton *TestBtn5 = [UIButton buttonWithType:UIButtonTypeCustom];
    [TestBtn5 setBackgroundColor:[UIColor orangeColor]];
    [TestBtn5 setFrame:CGRectMake(50, 530, 300, 50)];
//    [TestBtn5 setTitle:@"" forState:UIControlStateNormal];
    [TestBtn5 addTarget:self action:@selector(testTitleNil) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:TestBtn5];
    
}

- (NSString *)pageID {
    return @"custom_page_id";
}

/**
 *  @method crashTestAction:
 *  @brief  crash按钮的响应函数，触发之后App会发生Crash
 *  @param  无
 *  @return void.
 */
- (void)crashTestAction{
    NSArray *arr = @[@1];
    NSLog(@"%@",arr[2]);
}

/**
 *  @method caughtExceptionTestBtn
 *  @bried  已捕获异常的响应函数，触发之后App会将异常进行捕获
 *  @param  无
 *  @return void.
 */
- (void) caughtExceptionTestBtn{
    @try {
        [self crashTestAction];
    }
    @catch (NSException *exception) {
        // 收集自定义信息。开关默认为关，打开时有效
//        [CrabCrashReport reportException:nil customInfo:nil];
//        [[CrabARNReport sharedInstance] generateCrashReportWithException:exception];
        
        [CrabARNReport reportException:exception customInfo:@"just--test"];
        
    }
    @finally {
        
    }
}

- (void) ANRTestBtn{
    NSLog(@"开始卡顿测试-----");
    sleep(3);
    NSLog(@"结束卡顿测试+++++");
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//        BSLOG_MAIN  // 打印主线程调用栈， BSLOG 打印当前线程，BSLOG_ALL 打印所有线程
//        BSLOG_ALL
        // 调用 [BSBacktraceLogger bs_backtraceOfCurrentThread] 这一系列的方法可以获取字符串，然后选择上传服务器或者其他处理。
//        BSLOG
//    });
    
    UIViewController *nextViewController = [[UIViewController alloc] init];
    nextViewController.view.backgroundColor = [UIColor grayColor];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(30, 100, 100, 40)];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setBackgroundColor:[UIColor blueColor]];
    [backButton addTarget:self action:@selector(clickBackButton:) forControlEvents:UIControlEventTouchUpInside];
    [nextViewController.view addSubview:backButton];
    [self presentViewController:nextViewController animated:YES completion:^{}];
}

- (void)clickBackButton:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)testNSArrayCrash {
    @try {
        NSArray *array = [NSArray array];
        NSLog(@"CrashKiller = %@",[array objectAtIndex:0]);
    } @catch (NSException *exception) {
//        [[CrabCrashReport sharedInstance] setCustomExceptionEnanle:YES];
        [CrabARNReport reportException:exception customInfo:@"test"];
    }
    
    @try {
        NSArray *array1 = @[@(1)];
        NSLog(@"CrashKiller1 = %@",[array1 objectAtIndex:2]);
    }
    @catch (NSException *exception) {
        [CrabARNReport reportException:exception customInfo:@"just test--arraycrash"];

    }
    
    
    @try {
        NSArray *array2 = @[@(1),@(1),@(1)];
        NSLog(@"CrashKiller2 = %@",[array2 objectAtIndex:10]);
    }
    @catch (NSException *exception) {
        [CrabARNReport reportException:exception customInfo:@"aaaa"];
    }
    
    
}

- (void)testNSMutableArrayCrash {
    @try {
        NSMutableArray *array = [NSMutableArray array];
        [array addObject:nil];
        NSLog(@"testNSMutableArrayCrash = %@",[array objectAtIndex:5]);
    } @catch (NSException *exception) {
//        [[CrabARNReport sharedInstance] setCustomExceptionEnanle:YES];
        [CrabARNReport reportException:exception customInfo:@"just test--mutableArrayCrash"];
    }
    
}

- (void)testNSStringCrash {
    @try {
        NSString *testString = @"testString";
        NSLog(@"testNSStringCrash = %@",[testString substringFromIndex:100]);
        [testString containsString:@"test"];
        NSString *testString2 = @"";
        [testString2 containsString:@"test"];
    } @catch (NSException *exception) {
        //[[CrabCrashReport sharedInstance] setCustomExceptionEnanle:YES];
        [CrabARNReport reportException:exception customInfo:@"just test--NSStringCrash"];
    }
    
}

- (void)testCrashKillerUnrecognizeSelector {
    @try {
        [self performSelector:@selector(testCrash) withObject:nil];
        NSString *number = @(1);
        NSLog(@"testCrashKillerUnrecognizeSelector = %lu",(unsigned long)number.length);
    } @catch (NSException *exception) {
        //[[CrabCrashReport sharedInstance] setCustomExceptionEnanle:YES];
        [CrabARNReport reportException:exception customInfo:@"just test--UnrecognizeSelector"];
    }
    
}

- (void)testTitleNil{
    NSLog(@"title=nil");
}

@end
