//
//  AIRTitleBtn.m
//  BuDeJie
//
//  Created by air on 17/4/27.
//  Copyright © 2017年 air. All rights reserved.
//

#import "AIRTitleBtn.h"

@implementation AIRTitleBtn

- (void)setHighlighted:(BOOL)highlighted{
    //只要重写这个方法，按钮就无法进入UIControlStateHighlighted状态, 永远不会返回NO
}

//- (BOOL)isHighlighted{
//模拟代码    return default == yes;
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
