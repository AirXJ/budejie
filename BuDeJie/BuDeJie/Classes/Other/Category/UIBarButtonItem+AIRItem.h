//
//  UIBarButtonItem+AIRItem.h
//  BuDeJie
//
//  Created by air on 佛历2560-1-18.
//  Copyright © 佛历2560年 air. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (AIRItem)
//快速创建UIBarButtonItem
/*把自定义控件包装成UIBarButtonItem,可能需要在block中重写这句[btn sizeToFit]用于调整位置*/
+ (instancetype)itemWithImage:(UIImage *)image HighlightedImage:(UIImage *)image isSelectedOrHighlighted:(BOOL)selected target:(id)target action:(SEL)action subViewsHandle:(void(^)( UIButton *btn))subView;
@end
