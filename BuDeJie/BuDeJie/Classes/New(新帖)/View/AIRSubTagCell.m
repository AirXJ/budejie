//
//  AIRSubTagCell.m
//  BuDeJie
//
//  Created by air on 佛历2560-4-8.
//  Copyright © 佛历2560年 air. All rights reserved.
//

#import "AIRSubTagCell.h"
#import "AIRSubTagItem.h"

@interface AIRSubTagCell()
@property (weak, nonatomic) IBOutlet UILabel *numView;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;

@end


@implementation AIRSubTagCell
/****
 照片变成圆角
 处理数字
 ***/
- (void)setItem:(AIRSubTagItem *)item{
    _item = item;
    //设置内容
    [self resolveNum];
    self.nameView.text = item.title;
    //[self.iconView sd_setImageWithURL:[NSURL URLWithString:item.albumCoverUrl290] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    [self.iconView AIR_circleImageView:item.albumCoverUrl290 placeholderImage:@"defaultUserIcon"];
    
    
}

- (void)resolveNum{
    NSInteger num = _item.tracks.integerValue;
    _item.tracks = [NSString stringWithFormat:@"%zd人订阅",num];
    if(num > 10000){
        _item.tracks = [NSString stringWithFormat:@"%.1f万人订阅",num*1.0/10000];
        _item.tracks = [_item.tracks stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    self.numView.text = _item.tracks;
}

//从xib加载就会调用
- (void)awakeFromNib {
    [super awakeFromNib];
    // 设置头像圆角
//    self.iconView.layer.cornerRadius = 30;
//    self.iconView.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
