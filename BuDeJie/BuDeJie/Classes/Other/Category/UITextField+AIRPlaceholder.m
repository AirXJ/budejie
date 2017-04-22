//
//  UITextField+AIRPlaceholder.m
//  BuDeJie
//
//  Created by air on 佛历2560-4-10.
//  Copyright © 佛历2560年 air. All rights reserved.
//

#import "UITextField+AIRPlaceholder.h"
#import <objc/message.h>

@implementation UITextField (AIRPlaceholder)
+ (void)load{
    Method setAir_Placeholder = class_getInstanceMethod(self, @selector(Air_SetPlaceholder:));
    Method setPlaceholder = class_getInstanceMethod(self, @selector(setPlaceholder:));
    method_exchangeImplementations(setPlaceholder, setAir_Placeholder);
}


- (void)setAir_PlaceholderColor:(UIColor *)Air_PlaceholderColor{
    //给成员属性赋值，runtime给系统的类添加成员属性
    //添加成员属性
    objc_setAssociatedObject(self, @"Air_PlaceholderColor", Air_PlaceholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    UILabel *placeholderLabel = [self valueForKey:@"placeholderLabel"];
    placeholderLabel.textColor = Air_PlaceholderColor;
}

- (UIColor *)Air_PlaceholderColor{
    return objc_getAssociatedObject(self, @"Air_PlaceholderColor");
}

//设置占位文字，和颜色
- (void)Air_SetPlaceholder:(NSString *)holderStr{
    [self Air_SetPlaceholder:holderStr];
    [self setAir_PlaceholderColor:self.Air_PlaceholderColor];
    
}

@end
