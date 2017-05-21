//
//  AIRSoundView.m
//  BuDeJie
//
//  Created by air on 17/5/17.
//  Copyright © 2017年 air. All rights reserved.
//

#import "AIRSoundView.h"
#import "AIRTopicsItem.h"
#import "UIImageView+AIRDownload.h"

@interface AIRSoundView()

/********************  背景图片 *******************/
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/****************** 播放次数和播放时间Label *******************/
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *voicetimeLabel;

@end

@implementation AIRSoundView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setTopic:(AIRTopicsItem *)topic{
    _topic = topic;
    [self.imageView AIR_setOriginImage:topic.image1 thumbnailImage:topic.image0 placeholder:nil];
    
    //播放数量
    if (topic.playcount >= 10000) {
        self.playcountLabel.text = [NSString stringWithFormat:@"%.2f万播放", topic.playcount / 10000.0];
    } else {
    self.playcountLabel.text = [NSString stringWithFormat:@"%zd播放", topic.playcount];
    }
    
    //播放时长
    //占位符号的用法 %02zd占用2位不足前面补0
    self.voicetimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", topic.voicetime / 60.0, topic.voicetime % 60];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
}

@end
