//
//  AIREssenceController.h
//  BuDeJie
//
//  Created by air on 佛历2560-1-26.
//  Copyright © 佛历2560年 air. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AIRFooterView, AIRDownRefreshView;
@interface AIREssenceController : UIViewController

/******** footersArr这几个控件必须懒加载,设置上拉控件数组************/
@property (nonatomic, strong) NSArray <AIRFooterView *> *footersArr;

/*************** downRefreshUI数组 *****************/
@property (nonatomic, strong) NSArray <AIRDownRefreshView *> *downRefreshersArr;

@end
