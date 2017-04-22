//
//  AIRLoginRegisterViewController.m
//  BuDeJie
//
//  Created by air on 佛历2560-4-9.
//  Copyright © 佛历2560年 air. All rights reserved.
//

#import "AIRLoginRegisterViewController.h"
#import "AIRLoginRegisterView.h"
#import "AIRFastLoginView.h"

@interface AIRLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *midLdCons;

@end

@implementation AIRLoginRegisterViewController


/************
 1.越复杂的界面也要复用(封装)，划分结构去布局
 2.有特殊效果界面,也要封装
 ************/
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    /*************
     屏幕适配:
     1.一个view从xib加载，需不需要再重新固定尺寸 一定要再确定
     2.在viewDidLoad好不好, 开发中一般在viewDidLayoutSubviews布局子控件
     **************/
    AIRLoginRegisterView *loginView = [AIRLoginRegisterView loginView];
    [self.middleView addSubview:loginView];
    
    AIRLoginRegisterView *registView = [AIRLoginRegisterView registerView];
    [self.middleView addSubview:registView];
    
    AIRFastLoginView *fastLoginView = [AIRFastLoginView fastLoginView];
    [self.bottomView addSubview:fastLoginView];
    
    
}


//才会根据你的布局才会调整控件的尺寸, 不管xib宽度多宽
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    AIRLoginRegisterView *registView = self.middleView.subviews[1];
    AIRLoginRegisterView *loginView = self.middleView.subviews[0];
    AIRFastLoginView *fastLoginView = self.bottomView.subviews[0];
    fastLoginView.frame = CGRectMake(0, 0, self.bottomView.AIR_width, self.bottomView.AIR_height);
    loginView.frame = CGRectMake(0, 0, self.middleView.AIR_width*0.5, self.middleView.AIR_height);
   
    registView.frame = CGRectMake(self.middleView.AIR_width*0.5, 0, self.middleView.AIR_width*0.5, self.middleView.AIR_height);
    

    
    
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
    self.midLdCons.constant = self.midLdCons.constant == 0 ? -self.middleView.AIR_width*0.5 : 0;
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
    
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
