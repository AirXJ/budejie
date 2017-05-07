//
//  AIRFooterView.m
//  BuDeJie
//
//  Created by air on 17/5/5.
//  Copyright © 2017年 air. All rights reserved.
//

#import "AIRFooterView.h"

@interface AIRFooterView()


@end

@implementation AIRFooterView

+ (instancetype)footerView{
    return AIRLoadViewFromXib.firstObject;
}

//从xib加载就会调用
- (void)awakeFromNib {
    [super awakeFromNib];
    self.footerRefreshing = NO;
    self.netActivityIndicator.hidesWhenStopped = YES;
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
