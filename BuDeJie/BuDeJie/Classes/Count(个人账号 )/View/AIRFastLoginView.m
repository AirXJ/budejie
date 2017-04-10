//
//  AIRFastLoginView.m
//  BuDeJie
//
//  Created by air on 佛历2560-4-9.
//  Copyright © 佛历2560年 air. All rights reserved.
//

#import "AIRFastLoginView.h"

@implementation AIRFastLoginView
+ (instancetype)fastLoginView{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
