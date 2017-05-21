//
//  UIImageView+AIRDownload.h
//  BuDeJie
//
//  Created by air on 17/5/20.
//  Copyright © 2017年 air. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (AIRDownload)

/***圆形的头像图片***/
- (void)AIR_circleImageView:(NSString *)headerUrl placeholderImage:(NSString *)placeholder;

/**分情况加下载图片**/
- (void)AIR_setOriginImage:(NSString *)originImageURl thumbnailImage:(NSString *)thumbnailImageURL placeholder:(UIImage *)placeholer;
@end
