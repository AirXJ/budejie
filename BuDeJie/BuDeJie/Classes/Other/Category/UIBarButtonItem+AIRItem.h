//
//  UIBarButtonItem+AIRItem.h
//  BuDeJie
//
//  Created by air on 佛历2560-1-18.
//  Copyright © 佛历2560年 air. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (AIRItem)

//快速包装创建自定义UIBarButtonItem，放到UIView中使点击区域正常
/*把自定义控件包装成UIBarButtonItem,就导致按钮点击区域扩大,可能需要在block中重写这句[btn sizeToFit]用于调整位置*/
+ (instancetype)Air_itemWithImage:(UIImage *)image HighlightedImage:(UIImage *)image isSelectedOrHighlighted:(BOOL)selected target:(id)target action:(SEL)action subViewsHandle:(void(^)( UIButton *btn))subView;
@end
