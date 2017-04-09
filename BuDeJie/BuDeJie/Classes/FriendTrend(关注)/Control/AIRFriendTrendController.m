//  按钮设置成自定义的，不要设置成系统样式
//  AIRFriendTrendController.m
//  BuDeJie
//
//  Created by air on 佛历2560-1-26.
//  Copyright © 佛历2560年 air. All rights reserved.
//

#import "AIRFriendTrendController.h"
#import "AIRLoginRegisterViewController.h"


@interface AIRFriendTrendController ()


@end

@implementation AIRFriendTrendController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setStackControllerBar];
    // Do any additional setup after loading the view.
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
