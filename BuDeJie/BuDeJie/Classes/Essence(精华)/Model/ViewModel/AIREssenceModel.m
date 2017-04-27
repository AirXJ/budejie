//
//  AIREssenceModel.m
//  BuDeJie
//
//  Created by air on 17/4/27.
//  Copyright © 2017年 air. All rights reserved.
//

#import "AIREssenceModel.h"


@implementation AIREssenceModel
#pragma mark - 必须要写
//⚠️避免 KVC 修改属性值，kvc一修改直接报错
+ (BOOL)accessInstanceVariablesDirectly{
    return NO;
}


@synthesize titles = _titles;
- (NSArray *)titles{
    
    return @[@"全部", @"视频", @"声音", @"图片", @"段子"];
}
@end
