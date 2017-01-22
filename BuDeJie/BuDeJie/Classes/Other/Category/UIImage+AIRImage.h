//
//  UIImage+AIRImage.h
//  BuDeJie
//
//  Created by air on 17/1/13.
//  Copyright © 2017年 air. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (AIRImage)
/* 快速生成一个没有渲染的图片 */
+ (instancetype)AIR_OriginalImageWithDefaultImageName:(NSString *)image;
@end
