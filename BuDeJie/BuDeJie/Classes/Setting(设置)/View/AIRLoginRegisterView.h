//
//  AIRLoginRegisterView.h
//  BuDeJie
//
//  Created by air on 佛历2560-4-9.
//  Copyright © 佛历2560年 air. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AIRLoginRegisterView : UIView
//如何通过xib来创建UIView,不要联线绑定控制器，但需要绑定view不需要联线
+ (instancetype)loginView;
+ (instancetype)registerView;
@end
