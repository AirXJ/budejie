//
//  AIRVideoView.m
//  BuDeJie
//
//  Created by air on 17/5/17.
//  Copyright © 2017年 air. All rights reserved.
//

#import "AIRVideoView.h"
#import "AIRTopicsItem.h"
#import "UIImageView+AIRDownload.h"

@interface AIRVideoView()
@property (weak, nonatomic) IBOutlet UIImageView *placeholderView;

/********************  背景图片 *******************/
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/****************** 播放次数和播放时间Label *******************/
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videotimeLabel;

@end
@implementation AIRVideoView

- (void)setTopic:(AIRTopicsItem *)topic{
    _topic = topic;
    self.placeholderView.hidden = NO;
    [self.imageView AIR_setOriginImage:topic.image1 thumbnailImage:topic.image0 placeholder:nil andModelItem:topic complete:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!image) {
            return ;
        }
        self.placeholderView.hidden = YES;
    }];
    
    //播放数量
    if (topic.playcount >= 10000) {
        self.playcountLabel.text = [NSString stringWithFormat:@"%.2f万播放", topic.playcount / 10000.0];
    } else {
        self.playcountLabel.text = [NSString stringWithFormat:@"%zd播放", topic.playcount];
    }
    
    //播放时长
    //占位符号的用法 %02zd占用2位不足前面补0
    self.videotimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", topic.videotime / 60.0, topic.videotime % 60];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
}

@end
