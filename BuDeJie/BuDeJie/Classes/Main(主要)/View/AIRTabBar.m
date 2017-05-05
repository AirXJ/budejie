//
//  AIRTabBar.m
//  BuDeJie
//
//  Created by air on 佛历2560-1-27.
//  Copyright © 佛历2560年 air. All rights reserved.
//

#import "AIRTabBar.h"

@interface AIRTabBar ()
/** 按钮 */
@property (nonatomic,strong)UIButton *plusButton;

/************* 上一次点击的UIControl *****************/
@property (nonatomic,weak)UIControl *previousClickBtn;
@end

@implementation AIRTabBar

//1⃣️
- (UIButton *)plusButton
{
    if (_plusButton == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [btn sizeToFit];
        [self addSubview:btn];
        _plusButton = btn;
    }
    return _plusButton;
}

//1⃣️在自定义的view中重新布局, 顺路在里面设置一个按钮
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat x = 0;
    CGFloat btnW = self.bounds.size.width/(self.items.count+1);
    CGFloat btnH = self.bounds.size.height;
    NSInteger i = 0;
    for (UIView *tabBarBtn in self.subviews) {
        if ([tabBarBtn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            // 2⃣️设置previousClickBtn的默认值为最前面的按钮;     ->布局方法会进入多次，防止previousClickBtn出错
            if (i == 0 && self.previousClickBtn == nil) {
                self.previousClickBtn = (UIControl *)tabBarBtn;
            }
            
            if (i == 2) {
                i++;
                self.plusButton.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
            }
            x = i*btnW;
            tabBarBtn.frame = CGRectMake(x, 0, btnW, btnH);
            i++;
            
            //2⃣️监听点击, UIControlEventTouchDownRepeat短时间内连续点击
            [(UIControl *)tabBarBtn addTarget:self action:@selector(tabBarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
        }
    }
}

#pragma mark - 监听目标操作
//2⃣️
- (void)tabBarBtnClick:(UIControl *)tabBarBtn{
    
    if (self.previousClickBtn == tabBarBtn) {
        
        //一被点击tabBarBtn就发出通知, 告知外界马上刷新处理
        [[NSNotificationCenter defaultCenter] postNotificationName:AIRTabBarBtnDidRepeatClickNotification object:nil userInfo:@{}];
    }
    self.previousClickBtn = tabBarBtn;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
