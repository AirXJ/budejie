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
@end

@implementation AIRTabBar

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

+(void)load{
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat x = 0;
    CGFloat btnW = self.bounds.size.width/(self.items.count+1);
    CGFloat btnH = self.bounds.size.height;
    NSInteger i = 0;
    for (UIView *tabBarBtn in self.subviews) {
        if ([tabBarBtn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            if (i == 2) {
                i++;
                self.plusButton.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
            }
            x = i*btnW;
            tabBarBtn.frame = CGRectMake(x, 0, btnW, btnH);
            i++;
        }
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
