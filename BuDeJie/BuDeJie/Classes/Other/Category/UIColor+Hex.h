//
//  UIColor+Hex.h
//  颜色常识
//
//  Created by yz on 15/12/15.
//  Copyright © 2015年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)
/*RGB大于1获取颜色 */
+ (UIColor *) colorWith255Red:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(CGFloat)alpha;
/*从十六进制字符串获取颜色,默认alpha位1*/
+ (UIColor *)colorWithHexString:(NSString *)color;

/*从十六进制字符串获取颜色*/
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end
