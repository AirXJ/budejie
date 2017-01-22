//
//  UIBarButtonItem+AIRItem.m
//  BuDeJie
//
//  Created by air on 佛历2560-1-18.
//  Copyright © 佛历2560年 air. All rights reserved.
//

#import "UIBarButtonItem+AIRItem.h"

@implementation UIBarButtonItem (AIRItem)
+ (instancetype)itemWithImage:(UIImage *)image HighlightedImage:(UIImage *)hLimage isSelectedOrHighlighted:(BOOL)selected target:(id)target action:(SEL)action subViewsHandle:(void(^)( UIButton *btn))subViews{
    //设置导航条左右按钮、titleView
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    if (selected == NO) {
        [btn setImage:hLimage forState:UIControlStateHighlighted];
    }else{
         [btn setImage:hLimage forState:UIControlStateSelected];
    }
   
   
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    subViews(btn);
     [btn sizeToFit];
    //把UIButton包装成UIBarButtonItem，就导致按钮点击区域扩大
    UIView *containView = [[UIView alloc]initWithFrame:btn.frame];
    [containView addSubview:btn];
    return  [[UIBarButtonItem alloc]initWithCustomView:containView];
}
@end
