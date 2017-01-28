//
//  AIRMeController.m
//  BuDeJie
//
//  Created by air on 佛历2560-1-26.
//  Copyright © 佛历2560年 air. All rights reserved.
//

#import "AIRMeController.h"

@interface AIRMeController ()

@end

@implementation AIRMeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setStackControllerBar];
    // Do any additional setup after loading the view.
}

#pragma mark - 设置导航条内容
- (void)setStackControllerBar{
    //栈顶控制器决定导航条内容
    UIBarButtonItem *rightBtnItem1 = [UIBarButtonItem Air_itemWithImage:[UIImage imageNamed:@"mine-setting-icon"] HighlightedImage:[UIImage imageNamed:@"mine-setting-icon-click"] isSelectedOrHighlighted:NO target:self action:@selector(game) subViewsHandle:^(UIButton *btn) {
    }];

    UIBarButtonItem *rightBtnItem2 = [UIBarButtonItem Air_itemWithImage:[UIImage imageNamed:@"mine-sun-icon"] HighlightedImage:[UIImage imageNamed:@"mine-sun-icon-click"] isSelectedOrHighlighted:YES target:self action:@selector(game) subViewsHandle:^(UIButton *btn) {
    }];
    
    self.navigationItem.rightBarButtonItems = @[rightBtnItem1,rightBtnItem2];
    self.navigationItem.title = @"我的";
    
    
    
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
