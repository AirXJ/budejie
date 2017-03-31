//
//  AIRTabBarModel.m
//  BuDeJie
//
//  Created by air on 佛历2560-3-31.
//  Copyright © 佛历2560年 air. All rights reserved.
//

#import "AIRTabBarModel.h"


@implementation AIRTabBarModel
@synthesize stringItemArr = _stringItemArr;
#pragma mark - tabBar模型数据
- (instancetype)init{
    if (self = [super init]) {
        _stringItemArr = @[@"精华",@"新帖",@"关注",@"我"];
    }
    return self;
}
//避免 KVC 修改属性值
+ (BOOL)accessInstanceVariablesDirectly{
    return NO;
}
- (NSArray *)stringItemArr{
    return _stringItemArr;
}

- (NSArray *)picItemArray{
       // _picItemArray = @[@"tabBar_essence_icon",@"tabBar_new_icon",@"tabBar_friendTrends_icon",@"tabBar_me_icon"];
    return @[@"tabBar_essence_icon",@"tabBar_new_icon",@"tabBar_friendTrends_icon",@"tabBar_me_icon"];
}

- (NSArray *)selectedPicItemArr{
        return @[@"tabBar_essence_click_icon",@"tabBar_new_click_icon",@"tabBar_friendTrends_click_icon",@"tabBar_me_click_icon"];
}

@end
