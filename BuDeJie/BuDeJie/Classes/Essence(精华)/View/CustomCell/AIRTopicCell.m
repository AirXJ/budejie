//
//  AIRTopicCell.m
//  BuDeJie
//
//  Created by air on 17/5/10.
//  Copyright © 2017年 air. All rights reserved.
//

#import "AIRTopicCell.h"
#import "AIRTopicsItem.h"
#import "UIImage+AIRImage.h"
#import "AIRPhotoView.h"
#import "AIRSoundView.h"
#import "AIRVideoView.h"

@interface AIRTopicCell()
// 控件的命名 -> 功能 + 控件类型
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *passtimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@property (weak, nonatomic) IBOutlet UIView *hotCmtView;

@property (weak, nonatomic) IBOutlet UILabel *hotCmtLabel;

/* 中间控件 */
/** 图片控件 */
@property (nonatomic, weak) AIRPhotoView *photoView;
/** 声音控件 */
@property (nonatomic, weak) AIRSoundView *soundView;
/** 视频控件 */
@property (nonatomic, weak) AIRVideoView *videoView;

@end



@implementation AIRTopicCell
#pragma mark - 懒加载
- (AIRPhotoView *)photoView
{
    if (!_photoView) {
        AIRPhotoView *photoView = [AIRPhotoView AIR_LoadViewFromXib];
        [self.contentView addSubview:photoView];
        _photoView = photoView;
    }
    return _photoView;
}

- (AIRSoundView *)soundView
{
    if (!_soundView) {
        AIRSoundView *soundView = [AIRSoundView AIR_LoadViewFromXib];
        [self.contentView addSubview:soundView];
        _soundView = soundView;
    }
    return _soundView;
}

- (AIRVideoView *)videoView
{
    if (!_videoView) {
        AIRVideoView *videoView = [AIRVideoView AIR_LoadViewFromXib];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}


#pragma mark - 初始化
- (void)setTopic:(AIRTopicsItem *)topic
{
    _topic = topic;
    
    // 顶部控件的数据
    [self.profileImageView AIR_circleImageView:topic.profile_image placeholderImage:@"defaultUserIcon"];
    
    //中间内容
    if (topic.type == AIRTopicTypePhoto){
        //解决循环运用和重复添加
        self.photoView.topic = self.topic;
        self.photoView.hidden = NO;
        self.soundView.hidden = YES;
        self.videoView.hidden = YES;
    } else if (topic.type == AIRTopicTypeVideo){
        self.videoView.hidden = NO;
        self.videoView.topic = self.topic;
        self.photoView.hidden = YES;
        self.soundView.hidden = YES;
    } else if (topic.type == AIRTopicTypeSound){
        self.soundView.hidden = NO;
        self.soundView.topic = self.topic;
        self.photoView.hidden = YES;
        self.videoView.hidden = YES;
    } else if (topic.type == AIRTopicTypeJoke){
        self.photoView.hidden = YES;
        self.soundView.hidden = YES;
        self.videoView.hidden = YES;
    }
    
    // 顶部控件的数据
    self.nameLabel.text = topic.name;
    self.passtimeLabel.text = topic.passtime;
    self.text_label.text = topic.text;
    
    // 底部按钮的文字
    [self setupButtonTitle:self.dingButton number:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton number:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.repostButton number:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentButton number:topic.comment placeholder:@"评论"];
    
    //最热评论
    if (topic.top_cmt.count) {
        self.hotCmtView.hidden = NO;
        NSString *name = topic.top_cmt[0][@"user"][@"username"];
        NSString *content = topic.top_cmt[0][@"content"];
        
        if (content.length == 0) {
            content = @"[语音评论]";
        }
        //对象方法也用用,init前面必须要alloc，不能用［对象 init];否则会报错cannot be sent to an abstract object of class
        //self.hotCmtLabel.text = [[NSString alloc] initWithFormat:@"%@-%@", name, content];
        self.hotCmtLabel.text = [NSString stringWithFormat:@"%@-%@", name, content];
    } else {
        self.hotCmtView.hidden = YES;
    }
}

/**
 *  设置按钮文字
 *  @param number      按钮的数字
 *  @param placeholder 数字为0时显示的文字
 */
- (void)setupButtonTitle:(UIButton *)button number:(NSInteger)number placeholder:(NSString *)placeholder
{
    if (number >= 10000) {
        [button setTitle:[NSString stringWithFormat:@"%.1f万", number / 10000.0] forState:UIControlStateNormal];
    } else if (number > 0) {
        [button setTitle:[NSString stringWithFormat:@"%zd", number] forState:UIControlStateNormal];
    } else {
        [button setTitle:placeholder forState:UIControlStateNormal];
    }
}

- (void)setFrame:(CGRect)frame
{
    //    frame.origin.x += XMGMarin;
    //    frame.size.width -= 2 * XMGMarin;
    frame.size.height -= AIRMargin;
    
    [super setFrame:frame];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //给contentview的中间控件设置frame
    if (_topic.type == AIRTopicTypePhoto){
        self.photoView.frame = _topic.middleFrame;
    } else if (_topic.type == AIRTopicTypeVideo){
        self.videoView.frame = _topic.middleFrame;
    } else if (_topic.type == AIRTopicTypeSound){
        self.soundView.frame = _topic.middleFrame;
    } else if (_topic.type == AIRTopicTypeJoke){
        self.photoView.frame = _topic.middleFrame;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
