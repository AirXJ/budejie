//
//  AIRFastLoginBtn.m
//  BuDeJie
//
//  Created by air on 佛历2560-4-9.
//  Copyright © 佛历2560年 air. All rights reserved.
//

#import "AIRFastLoginBtn.h"

@implementation AIRFastLoginBtn
- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.AIR_y = 0;
    
    self.imageView.AIR_centerX = self.AIR_width*0.5;
    self.titleLabel.AIR_y = self.AIR_height - self.titleLabel.AIR_height;
    //iOS10之前计算文字宽度
    //[self sizeToFit];
    self.titleLabel.AIR_centerX = self.AIR_width*0.5;
    
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
