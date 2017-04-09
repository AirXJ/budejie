//
//  UIView+AIRFrame.h
//  BuDeJie
//
//  Created by air on 17/1/14.
//  Copyright © 2017年 air. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AIRFrame)
/*
 分类定义属性，因避免重名，加前缀，set方法直接修改frame了
 */
/** 宽 */
@property (nonatomic,assign)CGFloat AIR_width;
/** 高 */
@property (nonatomic,assign)CGFloat AIR_height;
/** x */
@property (nonatomic,assign)CGFloat AIR_x;
/** y */
@property (nonatomic,assign)CGFloat AIR_y;


@end
