//
//  AIRWhileTextField.m
//  BuDeJie
//
//  Created by air on 佛历2560-4-10.
//  Copyright © 佛历2560年 air. All rights reserved.
//

#import "AIRWhileTextField.h"
#import "UITextField+AIRPlaceholder.h"


@implementation AIRWhileTextField

/*****
 1.文本框光标变成白色
 2.文本框开始编辑的时候, 占位文字颜色变成白色
 ****/

- (void)awakeFromNib{
     [super awakeFromNib];
    //设置光标的颜色为白色
    self.tintColor = [UIColor whiteColor];
    //监听文本框开始和编辑: 1.代理 2.通知 3.target
    [self addTarget:self action:@selector(textBegin) forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(textEnd) forControlEvents:UIControlEventEditingDidEnd];
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    self.attributedPlaceholder = [[NSAttributedString alloc]initWithString:self.placeholder attributes:attrs];
    
    //快速设置占位文字颜色 => 文本框占位文字可能是label => 验证占位文字是label
    //获取占位文字空间，通过runtime或者断点调试，查看label属性名
    //方法2kvc
    UILabel *placeholderLabel = [self valueForKey:@"placeholderLabel"];
    
    placeholderLabel.textColor = [UIColor lightGrayColor];
    
}

#pragma mark - @selector()
//文本框开始编辑调用
- (void)textBegin{
    //设置占位文字颜色变成白色:方法1富文本
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    self.attributedPlaceholder = [[NSAttributedString alloc]initWithString:self.placeholder attributes:attrs];
   
}

- (void)textEnd{
    //设置占位文字颜色变成黑色:方法3分类
    self.Air_PlaceholderColor = [UIColor lightGrayColor];
    
    
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
