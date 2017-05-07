//
//  AIRFooterView.h
//  BuDeJie
//
//  Created by air on 17/5/5.
//  Copyright © 2017年 air. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AIRFooterView : UIView
@property (weak, nonatomic) IBOutlet UIView *backgroudView;
@property (weak, nonatomic) IBOutlet UILabel *refreshLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *netActivityIndicator;
/******************** 是否在刷新 *******************/
@property (nonatomic, assign, getter=isFooterRefreshing)BOOL footerRefreshing;
+ (instancetype)footerView;
@end
