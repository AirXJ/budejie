//
//  AIRFileTool.m
//  BuDeJie
//
//  Created by air on 17/4/25.
//  Copyright © 2017年 air. All rights reserved.
//   

#import "AIRFileTool.h"

@interface AIRFileTool()


@end

@implementation AIRFileTool


#pragma mark - 获取文件夹大小, 清空缓存
/*********计算文件夹大小
 计算整个应用程序的缓存数据 => 沙盒(获取Cache文件夹大小)
 SDWebImage框架SDImageCache已经帮我们做了缓存 => 模仿功能自己实现 => 抽到分类中
 NSInteger size = [SDImageCache sharedImageCache].getSize;
 *********/
+ (void)getFileSize:(NSString *)directoryPath completion:(void (^)(NSInteger sumSize))completion
{
    [self isExistOrDirectory:directoryPath];
   
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 获取文件夹下所有的子路径,包含子路径的子路径
        NSArray *subPaths = [[NSFileManager defaultManager] subpathsAtPath:directoryPath];
        NSInteger totalSize = 0;
        for (NSString *subPath in subPaths) {
            // 获取文件全路径
            NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
            
            // 判断隐藏文件
            if ([filePath containsString:@".DS"]) continue;
            
            // 判断是否文件夹
            BOOL isDirectory;
            // 判断文件是否存在,并且判断是否是文件夹
            BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
            if (!isExist || isDirectory) continue;
            
            // 获取文件属性
            // attributesOfItemAtPath:只能获取文件尺寸,获取文件夹不对
            
            NSDictionary *attr = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
            
            // 获取文件尺寸
            NSInteger fileSize = [attr fileSize];
            
            totalSize += fileSize;
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (completion) {
                //计算完成之后回调
                completion(totalSize);
            }
            
        });
        
    });
}

/**********
 清空缓存, 删除文件夹所有文件夹
 **************/
+ (void)removeDirectory:(NSString *)directoryPath
{
    [self isExistOrDirectory:directoryPath];
    // 获取cache文件夹下所有文件,不包括子路径的子路径
    NSArray *subPaths = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:directoryPath error:nil];
    
    for (NSString *subPath in subPaths) {
        // 拼接完成全路径
        NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
        
        // 删除路径
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    }
}
#pragma mark -  判断是不是文件夹
/**********
 判断是不是文件夹
 **************/
+ (void)isExistOrDirectory:(NSString *)directoryPath{
    BOOL isDirectory;
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    //路径不存在或者路径不是文件夹
    if (!isExist || !isDirectory) {
        //抛异常 异常名和原因
        [[NSException exceptionWithName:@"pathError" reason:@"need exitsted path or not isDirectory" userInfo:nil] raise];
    }
}

@end
