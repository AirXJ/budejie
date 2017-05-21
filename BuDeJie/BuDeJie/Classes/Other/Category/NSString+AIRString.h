//
//  NSString+AIRString.h
//  BuDeJie
//
//  Created by air on 17/4/25.
//  Copyright © 2017年 air. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AIRString)

/****
 *  计算多行文字在某个CGSize内的size ,
 *  maxSize 的高度是MAXFLOAT,宽度看控件约束
 *  如果是算的是单行的size可以传 CGSizeZero
 *  isOne是否是单行来决定调用不同的方法
 *****/
- (CGSize)AIR_sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize onlyOneLine:(BOOL)isOne;

/*****
*     拼接(缓存)文件大小字符串
*     @param directoryPath 文件夹路径

*****/
+ (NSString *)AIR_getPathStringsize:(NSString *)directoryPath completion:(void (^)(NSString *sizeStr))completion;
@end
