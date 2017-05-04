//
//  AppDelegate.h
//  BuDeJie
//
//  Created by air on 17/1/12.
//  Copyright © 2017年 air. All rights reserved.
//

#import <UIKit/UIKit.h>


/*******
 优
 先级:LaunchScreen > LaunchImage 在xcode配置了,不起作用 1.清空xcode缓存 2.直接删掉程序 重新运行 如果是通过LaunchImage设置启动界面,那么屏幕的可视范围由图片决定 注意:如果使用LaunchImage,必须让你的美工提供各种尺寸的启动图片
 
 LaunchScreen:Xcode6开始才有
 LaunchScreen好处:1.自动识别当前真机或者模拟器的尺寸 2.只要让美工提供一个可拉伸图片
 3.展示更多东西
 
 LaunchScreen底层实现:把LaunchScreen截屏,生成一张图片.作为启动界面，然后这张图的大小决定了以后主窗口的可视范围。
 
 ********/
//@class AppDelegate;
//@protocol AIRAppTouchDelegate <NSObject>
//
//@optional
//// 1.设计方法:想要代理做什么事情
//- (void)appDelegate:(AppDelegate *)appDelegate resetOffset:(CGPoint)defaultPoint;
//
//@end


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

////2.保存委托对象地址
//@property (nonatomic, weak) id<AIRAppTouchDelegate> delegate;

@end

