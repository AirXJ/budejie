//
//  AIRNewController.m
//  BuDeJie
//
//  Created by air on 佛历2560-1-26.
//  Copyright © 佛历2560年 air. All rights reserved.
//

#import "AIRNewController.h"
#import "AIRSubTagTableViewController.h"
@interface AIRNewController ()

@end

@implementation AIRNewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setStackControllerBar];
    
    
    // AIRFUNCLog;添加通知监听,不添加监听就不会收到通知, 收到通知马上刷新, 控制器的view被dealloc一定要移除通知监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarBtnDidRepeatClick:) name:AIRTabBarBtnDidRepeatClickNotification object:nil];
    
}



- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AIRTabBarBtnDidRepeatClickNotification object:nil];

    
}

#pragma mark - 监听 通知模式

- (void)tabBarBtnDidRepeatClick:(NSNotification *)notification{
    
    //没有点击精华按钮退出方法
    if (self.view.window == nil) return;
    //显示在正中间的不是AIRAllTableController, 不显示的view必须移除
    if (self.view.superview == nil) return;
    AIRFUNCLog;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 设置导航条内容
- (void)setStackControllerBar{
    //栈顶控制器决定导航条内容,把自定义控件包装成UIBarButtonItem
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem Air_itemWithImage:[UIImage imageNamed:@"MainTagSubIcon"] HighlightedImage:[UIImage imageNamed:@"MainTagSubIconClick"] isSelectedOrHighlighted:NO target:self action:@selector(tagClick) subViewsHandle:^(UIButton *btn) {
    }];
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage AIR_OriginalImageWithDefaultImageName:@"MainTitle"]];
    
    
    
}

#pragma mark - @selector()
- (void)tagClick{
    AIRSubTagTableViewController *subTag = [[AIRSubTagTableViewController alloc] init] ;
    //进入到推荐标签界面
    [self.navigationController pushViewController:subTag animated:YES];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
