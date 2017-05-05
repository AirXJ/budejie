//
//  NSTimer+AIRDealloc.m
//  BuDeJie
//
//  Created by air on 17/5/4.
//  Copyright © 2017年 air. All rights reserved.
//

#import "NSTimer+AIRDealloc.h"

@implementation NSTimer (AIRDealloc)
static const void * weakKey = @"weakKey";

+ (void)load{
    self.timerTarget = [NSObject new];
    objc_setAssociatedObject(self.timerTarget, weakKey, self, OBJC_ASSOCIATION_ASSIGN);
    class_addMethod([_timerTarget class], @selector(timerEvent), (IMP)timerMethod, "v@:");
    
}

void timerMethod(id self,SEL _cmd) {
    //如果用self.timerTarget timMethod函数需要再加一个参数，但是self继承自NSObject的，直接继承不需要加参数了
    UIViewController *weakController = objc_getAssociatedObject(self, weakKey);
    if (_cmd == NSSelectorFromString(@"timerEvent")) {
        IMP imp = [weakController methodForSelector:_cmd];
        void (*myFunc)(id, SEL) = (void *)imp;
        myFunc(weakController, _cmd);
    }
}

@end
