//
//  AIRDownRefreshView.h
//  BuDeJie
//
//  Created by air on 17/5/6.
//  Copyright © 2017年 air. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, AIRDownRefreshType) {
    //下拉刷新
    AIRDownRefreshTypeDown,
    //释放立即刷新
    AIRDownRefreshTypeUp,
    //正在刷新...
    AIRDownRefreshTypeRefreshIng,
    //刷新成功
    //AIRDownRefreshTypeRefreshed,
};

@interface AIRDownRefreshView : UIView
/******************** 是否在刷新 *******************/
@property (nonatomic, assign, getter=isHeaderRefreshing)BOOL headerRefreshing;
@property (weak, nonatomic) IBOutlet UIView *backgroudView;
@property (weak, nonatomic) IBOutlet UILabel *refreshLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *netActivityIndicator;
/******************** 文字状态 *******************/
@property (nonatomic, assign, getter=isDownerRefreshing)AIRDownRefreshType refreshType;
+ (instancetype)downRefreshViewWithState:(AIRDownRefreshType)viewType;
@end
