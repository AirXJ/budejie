//
//  AIRTabBarModel.m
//  BuDeJie
//
//  Created by air on 佛历2560-3-31.
//  Copyright © 佛历2560年 air. All rights reserved.
//

#import "AIRTabBarModel.h"
#import "AIRNavigationController.h"
#import "AIREssenceController.h"
#import "AIRNewController.h"
#import "AIRPublishController.h"
#import "AIRFriendTrendController.h"
#import "AIRMeController.h"
#import <objc/message.h>

@implementation AIRTabBarModel
#pragma mark - 控制器数据
@synthesize classArray = _classArray,controllerArray = _controllerArray,naviArray = _naviArray;
//控制器类对象数组
-(NSArray *)classArray{
    if (_classArray == nil) {
        NSMutableArray *arr = [NSMutableArray array];
        [arr addObject:[AIREssenceController class]];
        [arr addObject:[AIRNewController class]];
        [arr addObject:[AIRPublishController class]];
        [arr addObject:[AIRFriendTrendController class]];
        [arr addObject:[AIRMeController class]];
        _classArray = [arr copy];
    }
    
    return _classArray;
}

//控制器数组
- (NSArray *)controllerArray{
    if (_controllerArray == nil) {
        NSMutableArray *array = [NSMutableArray array];
        for (id classObj in self.classArray) {
            id p = objc_msgSend(classObj  ,sel_registerName("alloc"));
            p = objc_msgSend(p,sel_registerName("init"));
            [array addObject:p];
        }
        _controllerArray = [array copy];
    }
    return _controllerArray;
}

//导航控制器数组
- (NSArray *)naviArray{
    if (!_naviArray) {
        NSMutableArray *array = [NSMutableArray array];
        for (id classObj in self.controllerArray) {
            if (classObj != self.controllerArray[2]) {
                id p = objc_msgSend(objc_getClass("AIRNavigationController")  ,sel_registerName("alloc"));
                p = objc_msgSend(p,sel_registerName("initWithRootViewController:"),classObj);
                [array addObject:p];
            }
            
        }
        // [array removeObjectAtIndex:2];
        // [array replaceObjectAtIndex:2 withObject:self.controllerArray[2]];
        _naviArray = [array copy];
    }
    return _naviArray;
}


@synthesize stringItemArr = _stringItemArr,picItemArray = _picItemArray,selectedPicItemArr = _selectedPicItemArr;

#pragma mark - tabBar模型数据
- (instancetype)init{
    if (self = [super init]) {
        _stringItemArr = @[@"精华",@"新帖",@"关注",@"我"];
    }
    return self;
}

//避免 KVC 修改属性值，kvc一修改直接报错
+ (BOOL)accessInstanceVariablesDirectly{
    return NO;
}
- (NSArray *)stringItemArr{
    return _stringItemArr;
}

- (NSArray *)picItemArray{
        _picItemArray = @[@"tabBar_essence_icon",@"tabBar_new_icon",@"tabBar_friendTrends_icon",@"tabBar_me_icon"];
    return _picItemArray;
}

- (NSArray *)selectedPicItemArr{
        _selectedPicItemArr = @[@"tabBar_essence_click_icon",@"tabBar_new_click_icon",@"tabBar_friendTrends_click_icon",@"tabBar_me_click_icon"];
        return _selectedPicItemArr;
}

@end
