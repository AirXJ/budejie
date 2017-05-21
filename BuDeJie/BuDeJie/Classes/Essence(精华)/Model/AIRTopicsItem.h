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
    AIRTopicTypePhoto = 10,
    /** 段子 */
    AIRTopicTypeJoke = 29,
    /** 声音 */
    AIRTopicTypeSound = 31,
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


//中间有关的属性
/******************** 宽度(像素) *******************/
@property (nonatomic, assign) NSInteger width;
/******************** 高度(像素) *******************/
@property (nonatomic, assign) NSInteger height;
/******************** 中间内容的Frame *******************/
@property (nonatomic, assign) CGRect middleFrame;
/******************** 小图 *******************/
@property (nonatomic, strong) NSString *image0;
/******************** 大图 *******************/
@property (nonatomic, strong) NSString *image1;
/******************** 中图 *******************/
@property (nonatomic, strong) NSString *image2;
/******************** 音频时长 *******************/
@property (nonatomic, assign) NSInteger voicetime;
/******************** 视频时长 *******************/
@property (nonatomic, assign) NSInteger videotime;
/******************** 音频｜视频播放次数 *******************/
@property (nonatomic, assign) NSInteger playcount;


/******************** 最热评论 *******************/
@property (nonatomic, strong) NSArray *top_cmt;



/******************** cell高度(额外增加的属性不是服务器返回的属性，为了提高程序运行效率) *******************/
@property (nonatomic, assign) CGFloat cellHeight;
@end
