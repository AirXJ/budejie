//
//  AIRHeaderRefreshView.m
//  BuDeJie
//
//  Created by air on 17/5/6.
//  Copyright © 2017年 air. All rights reserved.
//

#import "AIRHeaderRefreshView.h"

@implementation AIRHeaderRefreshView

+ (instancetype)downRefreshView{
    AIRHeaderRefreshView *headerRefreshView = (AIRHeaderRefreshView *)AIRLoadViewFromXib.firstObject;
    return headerRefreshView;
    //AIRDownRefreshTypeRefreshed
    //return AIRLoadViewFromXib.lastObject;
}



- (void)awakeFromNib{
    [super awakeFromNib];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
