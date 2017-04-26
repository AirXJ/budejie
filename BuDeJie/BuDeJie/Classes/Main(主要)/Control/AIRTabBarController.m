//
//  AIRTabBarController.m
//  BuDeJie
//
//  Created by air on 佛历2560-1-22.
//  Copyright © 佛历2560年 air. All rights reserved.
//

#import "AIRTabBarController.h"
#import "AIRTabBar.h"
#import "AIRTabBarModel.h"


@interface AIRTabBarController ()
/********************** 数据 ********************************/
@property (nonatomic,strong)AIRTabBarModel *model;


@end

@implementation AIRTabBarController
#pragma mark - lazy加载
- (AIRTabBarModel *)model{
    if (!_model) {
        AIRTabBarModel *model = [[AIRTabBarModel alloc]init];
        _model = model;
    }
    return _model;
}

#pragma mark - xcode自带方法
- (void)viewDidLoad{
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
//#pragma message "Warning 1"
//#warning "Warning 2"
//#error "laji"

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

#pragma mark - UITabBarController添加子控制器
- (void)addChilds{
    [self setViewControllers:self.model.naviArray animated:YES];
//    for (id childVc in self.model.naviArray) {
//        [self addChildViewController:childVc];
//    }
    
}

#pragma mark - 设置标签栏的统一样式和不同按钮的内容
- (void)addTabBarAppearance{
    NSInteger i = 0;
    for (id naviObj in self.model.naviArray) {
     //   if (i != 2) {
        [self tabBarItemWithController:naviObj title:self.model.stringItemArr[i] image:self.model.picItemArray[i] selectedImage:self.model.selectedPicItemArr[i]];
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
    AIRTabBar *bar = nil;
    UITabBarItem *item = nil;
    if (IOS9_OR_LATER) {
       bar = [AIRTabBar appearanceWhenContainedInInstancesOfClasses:@[self]];
        //父类里有设置字体富文本的方法
        item = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        //"-Warc-performSelector-leaks"
        //在印象 中可以搜索，警告类型。
        //#pragma clang diagnostic ignored "-Wunused-variable"
        // [weakController performSelector:_cmd withObject:nil];
        bar = [AIRTabBar appearanceWhenContainedIn:self, nil];
        //父类里有设置字体富文本的方法
        item = [UITabBarItem appearanceWhenContainedIn:self, nil];
#pragma clang diagnostic pop
    }
    
    [bar setBackgroundImage:[UIImage AIR_OriginalImageWithDefaultImageName:@"tabbar-light"]];
    
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




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
