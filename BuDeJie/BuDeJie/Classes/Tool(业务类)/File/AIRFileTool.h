//  处理文件缓存
//  AIRFileTool.h
//  BuDeJie
//
//  Created by air on 15/4/25.
//  Copyright © 2015年 air. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AIRFileTool : NSObject
/******************************************************
*     计算文件夹大小
*     @param directoryPath 文件夹路径
******************************************************/
+ (void)getFileSize:(NSString *)directoryPath completion:(void (^)(NSInteger sumSize))completion;

/******************************************************
 *      清空缓存, 删除文件夹所有文件夹
 *     @param directoryPath 文件夹路径
******************************************************/
+ (void)removeDirectory:(NSString *)directoryPath;
@end
