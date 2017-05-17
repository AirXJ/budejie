//
//  AIRTopicsItem.m
//  BuDeJie
//
//  Created by air on 17/5/8.
//  Copyright © 2017年 air. All rights reserved.
//

#import "AIRTopicsItem.h"
#import "NSString+AIRString.h"

@implementation AIRTopicsItem
- (CGFloat)cellHeight{
    if (_cellHeight == 0) {
        _cellHeight = 0;
        //文字控件的Y值
        _cellHeight += 55;
        
        //文字的高度
        CGSize textMaxSize = CGSizeMake(AIRScreenW - 2 * AIRMargin, MAXFLOAT);
        _cellHeight += [self.text sizeWithFont:[UIFont systemFontOfSize:15] maxSize:textMaxSize onlyOneLine:NO].height + 2 * AIRMargin;
        //中间内容的高度
        _cellHeight += 100;
        //工具条
        _cellHeight += 35;
    }
    return _cellHeight;
}
@end
