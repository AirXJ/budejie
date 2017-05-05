//
//  NSTimer+AIRDealloc.h
//  BuDeJie
//
//  Created by air on 17/5/4.
//  Copyright © 2017年 air. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (AIRDealloc)
/**************** 从新设置一个对象代替控制器自己 *******************/
@property (nonatomic,strong) NSObject *timerTarget;
@end
