//
//  AIRSquareCell.m
//  BuDeJie
//
//  Created by air on 17/4/15.
//  Copyright © 2017年 air. All rights reserved.
//

#import "AIRSquareCell.h"
#import "AIRSquareItem.h"


@interface AIRSquareCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *label;
@end

@implementation AIRSquareCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setItem:(AIRSquareItem *)item{
    _item = item;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:item.icon]];
    self.label.text = item.name;
}

@end
