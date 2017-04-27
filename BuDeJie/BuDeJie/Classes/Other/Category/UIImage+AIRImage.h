//
//  UIImage+AIRImage.h
//  BuDeJie
//
//  Created by air on 17/1/13.
//  Copyright © 2017年 air. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (AIRImage)
/* 快速生成一个没有渲染的图片，如果加载bundle的图片，格式:bundle名/图片名 */
+ (instancetype)AIR_OriginalImageWithDefaultImageName:(NSString *)image;
@end
