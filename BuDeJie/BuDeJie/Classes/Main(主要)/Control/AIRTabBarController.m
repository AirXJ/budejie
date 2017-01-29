//
//  AIRTabBarController.m
//  BuDeJie
//
//  Created by air on 佛历2560-1-22.
//  Copyright © 佛历2560年 air. All rights reserved.
//

#import "AIRTabBarController.h"
#import "AIRNavigationController.h"
#import "AIREssenceController.h"
#import "AIRNewController.h"
#import "AIRPublishController.h"
#import "AIRFriendTrendController.h"
#import "AIRMeController.h"
#import "AIRTabBar.h"
#import <objc/message.h>

@interface AIRTabBarController ()
/********************** 控制器对象数组 *********************/

/** 类对象数组 */
@property (nonatomic,strong)NSArray *classArray;
/** 控制器数组 */
@property (nonatomic,strong)NSArray *controllerArray;
/** 导航控制器数组 */
@property (nonatomic,strong)NSArray *naviArray;


/********************* tabBar模型数据 ********************/
/** tabBarItem名称数组 */
@property (nonatomic,strong)NSArray <NSString *>*stringArray;
/** tabBarItem图片名数组 */
@property (nonatomic,strong)NSArray  <NSString *>*picArray;
/** tabBarItem选中图片名数组 */
@property (nonatomic,strong)NSArray  <NSString *>*selectedPicArray;

@end

@implementation AIRTabBarController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self deauftMyLoad];
    // Do any additional setup after loading the view.

}




-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //tabBar是懒加载在didload里打印可能是空
    //AIRLog(@">>>>%@",self.tabBar.subviews);
    
}

#pragma mark - 自己的方法
- (void)deauftMyLoad{
    [self addChilds];
    [self addTabBarAppearance];
    [self addTabBarBtn];
}

#pragma mark - 自定义UITabBar控件,添加tabBar按钮
- (void)addTabBarBtn{
    AIRTabBar *bar = [[AIRTabBar alloc]init];
    [self setValue:bar forKey:@"tabBar"];
}

#pragma mark - 添加子控制器
- (void)addChilds{
    //[self setViewControllers:self.naviArray animated:YES];
    for (id childVc in self.naviArray) {
        [self addChildViewController:childVc];
    }
    
}

#pragma mark - 设置标签栏的统一样式和不同按钮的内容
- (void)addTabBarAppearance{
    NSInteger i = 0;
    for (id naviObj in self.naviArray) {
     //   if (i != 2) {
             [self tabBarItemWithController:naviObj title:self.stringArray[i] image:self.picArray[i] selectedImage:self.selectedPicArray[i]];
     //   }
        i++;
    }
}

//看到 [vcObj setTabBarItem:item];这句我觉得也可以按照mvc思想，单独放在initWithNibName方法里实现，但是代码就太分散了没有这样书写流畅。
- (void)tabBarItemWithController:(UIViewController *)vcObj title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    UITabBarItem *item = [[UITabBarItem alloc]initWithTitle:title image:[UIImage AIR_OriginalImageWithDefaultImageName:image] selectedImage:[UIImage AIR_OriginalImageWithDefaultImageName:selectedImage]];
    [vcObj setTabBarItem:item];
    /***这种在willappear方法里才会懒加载数据,viewdidload方法里打印self.tabBar.subviews是空
      vcObj.tabBarItem.title = title;
      vcObj.tabBarItem.image = [UIImage AIR_OriginalImageWithDefaultImageName:image];
      vcObj.tabBarItem.selectedImage = [UIImage AIR_OriginalImageWithDefaultImageName:selectedImage];
    ***/
   
}

+ (void)load{
    AIRTabBar *bar = [AIRTabBar appearanceWhenContainedIn:self, nil];
    [bar setBackgroundImage:[UIImage AIR_OriginalImageWithDefaultImageName:@"tabbar-light"]];
    //父类里有设置字体富文本的方法
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    dict[NSForegroundColorAttributeName] = [UIColor blackColor];
    [item setTitleTextAttributes:dict forState:UIControlStateSelected ];
    
    NSMutableDictionary *attri =[NSMutableDictionary dictionary];
    attri[NSFontAttributeName] = [UIFont boldSystemFontOfSize:12];
    [item setTitleTextAttributes:attri forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 控制器数据
//控制器类对象数组
-(NSArray *)classArray{
    if (_classArray == nil) {
        NSMutableArray *arr = [NSMutableArray array];
        [arr addObject:[AIREssenceController class]];
        [arr addObject:[AIRNewController class]];
        [arr addObject:[AIRPublishController class]];
        [arr addObject:[AIRFriendTrendController class]];
        [arr addObject:[AIRMeController class]];
        _classArray = [arr copy];
    }
    
    return _classArray;
}

//控制器数组
- (NSArray *)controllerArray{
    if (_controllerArray == nil) {
        NSMutableArray *array = [NSMutableArray array];
        for (id classObj in self.classArray) {
            id p = objc_msgSend(classObj  ,sel_registerName("alloc"));
            p = objc_msgSend(p,sel_registerName("init"));
            [array addObject:p];
        }
        _controllerArray = [array copy];
    }
    return _controllerArray;
}

//导航控制器数组
- (NSArray *)naviArray{
    if (!_naviArray) {
        NSMutableArray *array = [NSMutableArray array];
        for (id classObj in self.controllerArray) {
            if (classObj != self.controllerArray[2]) {
                id p = objc_msgSend(objc_getClass("AIRNavigationController")  ,sel_registerName("alloc"));
                p = objc_msgSend(p,sel_registerName("initWithRootViewController:"),classObj);
                [array addObject:p];
            }
          
        }
       // [array removeObjectAtIndex:2];
       // [array replaceObjectAtIndex:2 withObject:self.controllerArray[2]];
        _naviArray = [array copy];
    }
    return _naviArray;
}

#pragma mark - tabBar模型数据
- (NSArray *)stringArray{
    if (!_stringArray) {
        _stringArray = @[@"精华",@"新帖",@"关注",@"我"];
    }
    return _stringArray;
}

- (NSArray *)picArray{
    if (!_picArray) {
        _picArray = @[@"tabBar_essence_icon",@"tabBar_new_icon",@"tabBar_friendTrends_icon",@"tabBar_me_icon"];
    }
    return _picArray;
}

- (NSArray *)selectedPicArray{
    if (!_selectedPicArray) {
        _selectedPicArray = @[@"tabBar_essence_click_icon",@"tabBar_new_click_icon",@"tabBar_friendTrends_click_icon",@"tabBar_me_click_icon"];
    }
    return _selectedPicArray;
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
