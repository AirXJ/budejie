//
//  UIImageView+AIRDownload.m
//  BuDeJie
//
//  Created by air on 17/5/20.
//  Copyright © 2017年 air. All rights reserved.
//

#import "UIImageView+AIRDownload.h"
//#import <AFNetworking.h>
//#import <SDWebImage/UIImageView+WebCache.h>
//可能以后用到其它地方还要加其它头文件进去

@implementation UIImageView (AIRDownload)

- (void)AIR_circleImageView:(NSString *)headerUrl placeholderImage:(NSString *)placeholder
{
    UIImage *placeholderImage = [UIImage AIR_circleImageNamed:placeholder];
    [self sd_setImageWithURL:[NSURL URLWithString:headerUrl] placeholderImage:placeholderImage options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        // 图片下载失败，直接返回，按照它的默认做法
        if (!image) return;
        
        self.image = [image AIR_circleImage];
    }];
    
    //    [self sd_setImageWithURL:[NSURL URLWithString:headerUrl] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}

- (void)AIR_setOriginImage:(NSString *)originImageURl thumbnailImage:(NSString *)thumbnailImageURL placeholder:(UIImage *)placeholer complete:(SDWebImageCompletionBlock)completedBlock{
    
    //占位图片
    UIImage *placeholder = nil;
    //根据网络状态来加载图片
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    
    //再从硬盘(先会查缓存有没有)获取原图(SDWebImage的图片缓存是用URL字符穿作为key的)
    UIImage *originImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:originImageURl];
    if (originImage) {
        self.image = originImage;
        completedBlock(originImage, nil, SDImageCacheTypeNone, [NSURL URLWithString:originImageURl]);
    }else {
        if (mgr.isReachableViaWiFi) {
            
            [self sd_setImageWithURL:[NSURL URLWithString:originImageURl] placeholderImage:placeholder completed:completedBlock];
        }else if (mgr.isReachableViaWWAN){
            BOOL downloadOriginImageWhen3GOr4G = YES;
            if (downloadOriginImageWhen3GOr4G) {
                [self sd_setImageWithURL:[NSURL URLWithString:originImageURl] placeholderImage:placeholder completed:completedBlock];
            } else {
                //有就从缓存里取，没有救下载
                [self sd_setImageWithURL:[NSURL URLWithString:thumbnailImageURL] placeholderImage:placeholder completed:completedBlock];
                
            }
        } else {//没有网络
            UIImage *thumbnailImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:thumbnailImageURL];
            if (thumbnailImage) {
                self.image = thumbnailImage;
                completedBlock(thumbnailImage, nil, SDImageCacheTypeNone, [NSURL URLWithString:thumbnailImageURL]);
                
            } else {
                self.image = placeholder;
            }
        }
    }
    
    
}

@end
