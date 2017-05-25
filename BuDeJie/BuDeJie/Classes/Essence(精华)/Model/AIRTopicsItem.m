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
        _cellHeight += ([self.text AIR_sizeWithFont:[UIFont systemFontOfSize:15] maxSize:textMaxSize onlyOneLine:NO].height + 2 * AIRMargin);
        
        //中间内容
        if (self.type != AIRTopicTypeJoke) {//中间有内容图片声音视频
            CGFloat middleW = textMaxSize.width;
            CGFloat middleH = middleW * self.height / self.width;
            
            if (middleH>=AIRScreenH) { // 显示的图片高度超过一个屏幕，就是超长图片
                self.bigPicture = YES;
                middleH = 200;

            }else{
                self.bigPicture = NO;
                middleH = middleW * self.height / self.width;
            }
            CGFloat middleY = _cellHeight - AIRMargin;
            CGFloat middleX = AIRMargin;
            _middleFrame = CGRectMake(middleX, middleY, middleW, middleH);
            
            _cellHeight += (middleH + AIRMargin);
        }
        
        //最热评论
        if (self.top_cmt.count) {//有最热评论
            NSString *name = self.top_cmt[0][@"user"][@"username"];
            NSString *content = self.top_cmt[0][@"content"];
            if (content.length == 0) {
                content = @"[语音评论]";
            }
            //对象方法也用用,init前面必须要alloc，不能用［对象 init];否则会报错cannot be sent to an abstract object of class
           NSString *newContent = [[NSString alloc] initWithFormat:@"%@-%@", name, content];
            // 标题
            _cellHeight += 18;
            _cellHeight += ([newContent AIR_sizeWithFont:[UIFont systemFontOfSize:12] maxSize:textMaxSize onlyOneLine:NO].height + 2 * AIRMargin);
            
            // 内容
            
        }
        
        //工具条
        _cellHeight += 35;
    }
    return _cellHeight;
}
@end
