//
//  AIRTopicsItem.h
//  BuDeJie
//
//  Created by air on 17/5/8.
//  Copyright © 2017年 air. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,AIRTopicType) {
    /** 全部 */
    AIRTopicTypeAll = 1,
    /** 图片 */
    AIRTopicTypePicture = 10,
    /** 段子 */
    AIRTopicTypeWord = 29,
    /** 声音 */
    AIRTopicTypeVoice = 31,
    /** 视频 */
    AIRTopicTypeVideo = 41
};

@interface AIRTopicsItem : NSObject
/** 用户的名字 */
@property (nonatomic, copy) NSString *name;
/** 用户的头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 帖子的文字内容 */
@property (nonatomic, copy) NSString *text;
/** 帖子审核通过的时间 */
@property (nonatomic, copy) NSString *passtime;

/** 顶数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发\分享数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论数量 */
@property (nonatomic, assign) NSInteger comment;

/******************** 帖子类型 10图片 29段子 31音频 41视频 *******************/
@property (nonatomic, assign) AIRTopicType type;

/******************** 最热评论 *******************/
@property (nonatomic, strong) NSArray *top_cmt;



/******************** cell高度(额外增加的属性不是服务器返回的属性，为了提高程序运行效率) *******************/
@property (nonatomic, assign) CGFloat cellHeight;
@end
