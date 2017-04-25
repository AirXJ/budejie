//
//  AIRNavigationController.m
//  BuDeJie
//
//  Created by air on 佛历2560-1-26.
//  Copyright © 佛历2560年 air. All rights reserved.
//

#import "AIRNavigationController.h"

@interface AIRNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation AIRNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //现在我又需要全屏滑动了，必须加功能，加功能的话就是修改手势，那最好打印一下看下手势
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
#pragma clang diagnostic pop
    [self.view addGestureRecognizer:pan];
    //控制手势什么时候触发，只有非根控制器才能触发手势
    pan.delegate = self;
    
    //禁止之前的手势
    self.interactivePopGestureRecognizer.enabled = NO;
    
  
    // Do any additional setup after loading the view.
}

/*********************************************************这行代码在新版本中可以不写了，但是写也没什么*****************************************************/
#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    return self.childViewControllers.count > 1;
}
/*********************************************************这行代码在新版本中可以不写了，但是写也没什么*****************************************************/

#pragma mark - 设置导航条样式,统一背景图片和字体
+ (void)load{
    UINavigationBar *bar = nil;
    if (IOS9_OR_LATER) {
    bar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[self]];
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        
        //"-Warc-performSelector-leaks"
        //#pragma clang diagnostic ignored "-Wunused-variable"
        // [weakController performSelector:_cmd withObject:nil];
        bar = [UINavigationBar appearanceWhenContainedIn:self, nil];
#pragma clang diagnostic pop
    }
   
    [bar setBackgroundImage:[UIImage AIR_OriginalImageWithDefaultImageName:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
    NSMutableDictionary *attri = [NSMutableDictionary dictionary];
    attri[NSForegroundColorAttributeName] = [UIColor blackColor];
    attri[NSFontAttributeName] = [UIFont boldSystemFontOfSize:21];
    [bar setTitleTextAttributes:attri];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //这个判断和super push有先后顺序，tabbar切换之后push会再次调用，数据可能不会改变。
    if (self.viewControllers.count>=1) {
         viewController.hidesBottomBarWhenPushed = YES;
        //item没法设置frame，但是可以加一个弹簧样式的UIBarButtonItem，弹簧宽度系数设为负数就能改变位置
        UIBarButtonItem *item = [UIBarButtonItem Air_itemWithImage:[UIImage AIR_OriginalImageWithDefaultImageName:@"navigationButtonReturn"] HighlightedImage:[UIImage AIR_OriginalImageWithDefaultImageName:@"navigationButtonReturnClick"] isSelectedOrHighlighted:NO target:self action:@selector(back) subViewsHandle:^(UIButton *btn) {
            [btn setTitle:@"返回" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
            [btn setTitle:@"返回" forState:UIControlStateHighlighted];
            //这么玩就像移动了clayer，如果太大会点上去事件没响应
           // btn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
        }];
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        /**
         *  width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-5时，间距正好调整
         *  为0；width为正数时，正好相反，相当于往左移动width数值个像素
         */
        negativeSpacer.width = -15;
        viewController.navigationItem.leftBarButtonItems = @[negativeSpacer,item];
        
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back{
    [self popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
