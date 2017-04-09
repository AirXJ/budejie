//
//  AIRLoginRegisterViewController.m
//  BuDeJie
//
//  Created by air on 佛历2560-4-9.
//  Copyright © 佛历2560年 air. All rights reserved.
//

#import "AIRLoginRegisterViewController.h"
#import "AIRLoginRegisterView.h"


@interface AIRLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIView *MiddleView;

@end

@implementation AIRLoginRegisterViewController


//越复杂的界面也要复用(封装)，划分结构去布局
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    /*************
     屏幕适配:
     1.一个view从xib加载，需不需要再重新固定尺寸 一定要再确定
     2.
     3.
     
     
     **************/
    
    AIRLoginRegisterView *loginView = [AIRLoginRegisterView loginView];
    loginView.frame = CGRectMake(0, 0, self.MiddleView.AIR_width, self.MiddleView.AIR_height);
    [self.MiddleView addSubview:loginView];
    
    
    AIRLoginRegisterView *registView = [AIRLoginRegisterView registerView];
    registView.frame = CGRectMake(self.MiddleView.AIR_width, 0, self.MiddleView.AIR_width, self.MiddleView.AIR_height);
    [self.MiddleView addSubview:registView];

    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - @selector()
- (IBAction)close:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)clickRegister:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    
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
