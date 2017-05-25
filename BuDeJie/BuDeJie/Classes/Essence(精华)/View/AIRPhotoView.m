//
//  AIRPhotoView.m
//  BuDeJie
//
//  Created by air on 17/5/17.
//  Copyright © 2017年 air. All rights reserved.
//

#import "AIRPhotoView.h"
#import "AIRTopicsItem.h"
#import "UIImageView+AIRDownload.h"
#import "AIRSeeBigPictureViewController.h"

@interface AIRPhotoView()
@property (weak, nonatomic) IBOutlet UIImageView *placeholderView;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIButton *seebigpictureBtn;

/********************  背景图片 *******************/
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end

@implementation AIRPhotoView

- (void)setTopic:(AIRTopicsItem *)topic{
    _topic = topic;
    
    self.placeholderView.hidden = NO;
    [self.imageView AIR_setOriginImage:topic.image1 thumbnailImage:topic.image0 placeholder:nil complete:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!image) {
            return ;
        }
        self.placeholderView.hidden = YES;
        // 处理超长图片的大小
        if (topic.isBigPicture) {
            CGFloat imageW = topic.middleFrame.size.width;
            CGFloat imageH = imageW * topic.height / topic.width;
            
            // 开启上下文
            UIGraphicsBeginImageContext(CGSizeMake(imageW, imageH));
            // 绘制图片到上下文中
            [self.imageView.image drawInRect:CGRectMake(0, 0, imageW, imageH)];
            self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
            // 关闭上下文
            UIGraphicsEndImageContext();
        }
    }];
    
    //gif
    self.gifView.hidden = !topic.isBigPicture;
    // http://ww2.sinaimg.cn/bmiddle/005yUFpDjw1f297c6vgzig306y04rnpd.GIF
    //    if ([topic.image1.lowercaseString hasSuffix:@"gif"]) {
    //    if ([topic.image1.pathExtension.lowercaseString isEqualToString:@"gif"]) {
    //        self.gifView.hidden = NO;
    //    } else {
    //        self.gifView.hidden = YES;
    //    }
    //btn
    // 点击查看大图
    if (topic.isBigPicture) { // 超长图
        self.seebigpictureBtn.hidden = NO;
        self.imageView.contentMode = UIViewContentModeTop;
        self.imageView.clipsToBounds = YES;
        
    } else {
        self.seebigpictureBtn.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.imageView.clipsToBounds = NO;
        
    }
    
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    UITapGestureRecognizer *tapGtr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(modalVcController)];
    self.imageView.userInteractionEnabled = YES;
    [self addGestureRecognizer:tapGtr];
    //控制按钮内部的子控件对齐，不是用contentMode，是用以下2个属性,或者xib中
    //    self.seebigpictureBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    //    self.seebigpictureBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    // 控件按钮内部子控件之间的间距，xib中也有属性
    //    self.seebigpictureBtn.contentEdgeInsets = UIEdgeInsetsMake(10, 0, 0, 0);
    //    self.seebigpictureBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    //    self.seebigpictureBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
}

- (void)modalVcController{
    UIViewController *vc = [[AIRSeeBigPictureViewController alloc] init];
    [self.window.rootViewController presentViewController:vc animated:YES completion:^{
        
    }];
}

@end
