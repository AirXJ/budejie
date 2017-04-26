//
//  NSString+AIRString.h
//  BuDeJie
//
//  Created by air on 17/4/25.
//  Copyright © 2017年 air. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AIRString)
/*****
*     拼接(缓存)文件大小字符串
*     @param directoryPath 文件夹路径

*****/
+ (NSString *)getPathStringsize:(NSString *)directoryPath completion:(void (^)(NSString *sizeStr))completion;
@end
