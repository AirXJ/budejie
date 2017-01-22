//
//  UIImage+AIRImage.m
//  BuDeJie
//
//  Created by air on 17/1/13.
//  Copyright © 2017年 air. All rights reserved.
//

#import "UIImage+AIRImage.h"

@implementation UIImage (AIRImage)
+ (instancetype)AIR_OriginalImageWithDefaultImageName:(NSString *)imageName{
    UIImage *image = [UIImage imageNamed:imageName];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    return image;
}
@end
