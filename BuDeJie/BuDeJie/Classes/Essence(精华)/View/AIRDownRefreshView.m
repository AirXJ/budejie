//
//  AIRDownRefreshView.m
//  BuDeJie
//
//  Created by air on 17/5/6.
//  Copyright © 2017年 air. All rights reserved.
//

#import "AIRDownRefreshView.h"

@implementation AIRDownRefreshView

+ (instancetype)downRefreshViewWithState:(AIRDownRefreshType)viewType{
    AIRDownRefreshView *downRefreshView = (AIRDownRefreshView *)AIRLoadViewFromXib.firstObject;
    downRefreshView.refreshType = viewType;
    
    if (downRefreshView.refreshType == AIRDownRefreshTypeDown) {
        downRefreshView.refreshLabel.text = @"下拉可以刷新";
        downRefreshView.headerRefreshing = NO;
    }
    if (downRefreshView.refreshType == AIRDownRefreshTypeUp) {
        downRefreshView.refreshLabel.text = @"松开立即刷新";
        downRefreshView.headerRefreshing = NO;
    }
    if (downRefreshView.refreshType == AIRDownRefreshTypeRefreshIng) {
        downRefreshView.refreshLabel.text = @"正在刷新...";
        downRefreshView.headerRefreshing = YES;
    }
    return downRefreshView;
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
