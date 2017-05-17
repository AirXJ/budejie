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

@end



@implementation AIRTopicCell

- (void)setTopic:(AIRTopicsItem *)topic
{
    _topic = topic;
    UIImage *placeholder = [UIImage AIR_circleImageNamed:@"defaultUserIcon"];
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:placeholder options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        // 图片下载失败，直接返回，按照它的默认做法
        if (!image) return;
        
        self.profileImageView.image = [image AIR_circleImage];
    }];
    
    
    // 顶部控件的数据
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
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
        self.hotCmtLabel.text = [[NSString alloc] initWithFormat:@"%@-%@", name, content];
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
