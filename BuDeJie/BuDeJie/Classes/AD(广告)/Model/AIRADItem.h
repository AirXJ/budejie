//
//  AIRADItem.h
//  BuDeJie
//
//  Created by air on 佛历2560-4-5.
//  Copyright © 佛历2560年 air. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AIRADItem : NSObject
/******w h ori_curl w_picurl*****/
/****************** 点击广告跳转界面 *********************/
@property (nonatomic,strong)NSString *ori_curl;
/******************* 广告地址 ***************************/
@property (nonatomic,strong)NSString *w_picurl;
/********************  图片宽度   ***********************/
@property (nonatomic,assign)CGFloat w;
/********************  图片高度   ***********************/
@property (nonatomic,assign)CGFloat h;
@end
