//
//  AIREssenceController.m
//  BuDeJie
//
//  Created by air on 佛历2560-1-26.
//  Copyright © 佛历2560年 air. All rights reserved.
//

#import "AIREssenceController.h"

@interface AIREssenceController ()

@end

@implementation AIREssenceController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self setStackControllerBar];
//    if(self.isViewLoaded){
//        //TODO:待会补上
//        NSLog(@"******");
//    }
    
    
    
    // Do any additional setup after loading the view.
}

#pragma mark - 设置导航条内容
- (void)setStackControllerBar{
    //栈顶控制器决定导航条内容
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem Air_itemWithImage:[UIImage imageNamed:@"nav_item_game_icon"] HighlightedImage:[UIImage imageNamed:@"nav_item_game_click_icon"] isSelectedOrHighlighted:NO target:self action:@selector(game) subViewsHandle:^(UIButton *btn) {
        
    }];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem Air_itemWithImage:[UIImage imageNamed:@"navigationButtonRandom"] HighlightedImage:[UIImage imageNamed:@"navigationButtonRandomClick"] isSelectedOrHighlighted:NO target:self action:@selector(game) subViewsHandle:^(UIButton *btn) {
    }];
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage AIR_OriginalImageWithDefaultImageName:@"MainTitle"]];
    
  
    
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
