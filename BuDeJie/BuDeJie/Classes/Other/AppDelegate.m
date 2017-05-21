//
//  AppDelegate.m
//  BuDeJie
//
//  Created by air on 17/1/12.
//  Copyright © 2017年 air. All rights reserved.
//

#import "AppDelegate.h"
#import "AIRADViewController.h"
#import "AIRTabBarController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate
#pragma mark - 监听点击 AIREssenceController
/**监听除了主窗口之外的点击事件, 比如状态栏，需要判断
 AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
 appDelegate.delegate = self;
 如何拿到这个类的代理, 需要类型转换，测试方法运行通过
 **/
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    AIRFUNCLog;
//    if ([touches.anyObject locationInView:nil].y<=20){
//        AIRFUNCLog;
//        //2. .m文件实现中调用委托方法, 这个委托方法其实没有实现效果
//        if ([self.delegate respondsToSelector:@selector(appDelegate:resetOffset:)]) {
//系统的覆盖了，320还是0，0点，已经帮你实现了
//            [self.delegate appDelegate:self resetOffset:CGPointMake(0, 320)];
//
//        }
//    }
//}

#pragma mark - <UIApplicationDelegate>
/**********
 每次程序启动的时候进入广告界面
 1.在启动的时候，去加个广告界面(行不通)
 2.启动完成的时候，加个广告界面（展示了启动图片）
 a.窗口的梗控制器设为广告控制器\
 b.直接窗口上再加上一个广告界面，几秒过去了，再广告界面移除(业务逻辑交给谁管理)
 **********/
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    //    AIRADViewController *adVc = [[AIRADViewController alloc]init];
    //完成项目之后, 把广告设为根入口
    AIRTabBarController *tabVc = [AIRTabBarController new];
    
    self.window.rootViewController = tabVc;
    [self.window makeKeyAndVisible];
    //开始监控网络状况
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

//警告窗口切换后台不会自动关闭UIAlertView UIActionsheet
- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
