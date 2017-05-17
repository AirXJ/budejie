//  storyboard、xib不能继承
//  AIRTopicCell.h
//  BuDeJie
//
//  Created by air on 17/5/10.
//  Copyright © 2017年 air. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AIRTopicsItem;
@interface AIRTopicCell : UITableViewCell


/** 模型数据 */
@property (nonatomic, strong) AIRTopicsItem *topic;


@end
