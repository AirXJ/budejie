//  按钮设置成自定义的，不要设置成系统样式
//  AIRFriendTrendController.m
//  BuDeJie
//
//  Created by air on 佛历2560-1-26.
//  Copyright © 佛历2560年 air. All rights reserved.
//

#import "AIRFriendTrendController.h"
#import "AIRLoginRegisterViewController.h"
#import "UITextField+AIRPlaceholder.h"

@interface AIRFriendTrendController ()

@property (weak, nonatomic) IBOutlet UITextField *testField;

@end

@implementation AIRFriendTrendController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setStackControllerBar];
    // Do any additional setup after loading the view.
  
    //⚠️先设置颜色没有效果. => oc是懒加载机制，没有文字就没必要设置颜色，所以先设置颜色没效果
    self.testField.Air_PlaceholderColor = [UIColor redColor];
    self.testField.placeholder = @"有颜色?";
    
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

//点击了组册就会调用
- (IBAction)clickLoginRegister:(UIButton *)sender {
   
    [self presentViewController: [[AIRLoginRegisterViewController alloc]init] animated:YES completion:^{
        
    }];
    
    
}

#pragma mark - 设置导航条内容
- (void)setStackControllerBar{
    //栈顶控制器决定导航条内容
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem Air_itemWithImage:[UIImage imageNamed:@"friendsRecommentIcon"] HighlightedImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] isSelectedOrHighlighted:NO target:self action:@selector(game) subViewsHandle:^(UIButton *btn) {
    }];
    
    self.navigationItem.title = @"我的关注";
    
    
    
}

- (void)game{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
