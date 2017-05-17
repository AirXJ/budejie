//
//  NSString+AIRString.m
//  BuDeJie
//
//  Created by air on 17/4/25.
//  Copyright © 2017年 air. All rights reserved.
//

#import "NSString+AIRString.h"
#import "AIRFileTool.h"

@implementation NSString (AIRString)
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize onlyOneLine:(BOOL)isOne
{
    if (![font isKindOfClass:[UIFont class]]) {
        
        //抛异常 异常名和原因
        [[NSException exceptionWithName:@"typeError" reason:@"need UIFont type" userInfo:nil] raise];
    }
    NSDictionary *attrs = @{NSFontAttributeName:font};
    CGSize size = CGSizeZero;
    if (isOne == YES) {
        size = [self sizeWithAttributes:attrs];
    } else {
        
        
        size = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    }
    return size;
}

/*****
 *     拼接文件大小字符串
 *     @param directoryPath 文件夹路径
 
 *****/
+ (NSString *)getPathStringsize:(NSString *)directoryPath completion:(void (^)(NSString *sizeStr))completion 
{
    NSString *sizeStr = @"清除缓存";
    [AIRFileTool getFileSize:directoryPath completion:^(NSInteger sumSize) {
        NSInteger totalSize = sumSize;
        NSString *sizeStr = @"清除缓存";
        
        // MB KB B
        if (totalSize > 1000 * 1000) {
            // MB
            CGFloat sizeF = totalSize / 1000.0 / 1000.0;
            sizeStr = [NSString stringWithFormat:@"%@(%.1fMB)",sizeStr,sizeF];
        } else if (totalSize > 1000) {
            // KB
            CGFloat sizeF = totalSize / 1000.0;
            sizeStr = [NSString stringWithFormat:@"%@(%.1fKB)",sizeStr,sizeF];
        } else if (totalSize > 0) {
            // B
            sizeStr = [NSString stringWithFormat:@"%@(%.ldB)",sizeStr,totalSize];
        }
            if (completion) {
               completion(sizeStr);
            }
    }];
    return sizeStr;
    
}
@end
