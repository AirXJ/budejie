//
//  AIRLoginRegisterView.m
//  BuDeJie
//
//  Created by air on 佛历2560-4-9.
//  Copyright © 佛历2560年 air. All rights reserved.
//

#import "AIRLoginRegisterView.h"

@interface AIRLoginRegisterView()
@property (weak, nonatomic) IBOutlet UIButton *loginRegisterBtn;

@end

@implementation AIRLoginRegisterView
+ (instancetype)loginView{
    return [[NSBundle mainBundle]loadNibNamed:@"AIRLoginRegisterView" owner:nil options:nil].firstObject;
}

+ (instancetype)registerView{
    return [[NSBundle mainBundle]loadNibNamed:@"AIRLoginRegisterView" owner:nil options:nil].lastObject;
}

//加载故事版xib会被调用
- (void)awakeFromNib{
    [super awakeFromNib];
//    AIRLog(@"%@~~~%@",self.loginRegisterBtn.currentTitle,self.loginRegisterBtn.titleLabel.text);
    UIImage *img = self.loginRegisterBtn.currentBackgroundImage;
    //按钮背景图片不要被拉伸
    img = [img stretchableImageWithLeftCapWidth:img.size.width*0.5 topCapHeight:img.size.height*0.5];
    
    [self.loginRegisterBtn setBackgroundImage:img forState:UIControlStateNormal];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
