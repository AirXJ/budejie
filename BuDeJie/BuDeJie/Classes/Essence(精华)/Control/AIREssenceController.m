//
//  AIREssenceController.m
//  BuDeJie
//
//  Created by air on 佛历2560-1-26.
//  Copyright © 佛历2560年 air. All rights reserved.
//

#import "AIREssenceController.h"
#import "AIREssenceModel.h"
#import "AIRTitleBtn.h"

@interface AIREssenceController ()
/******************** 标题栏控件 *******************/
@property (nonatomic, weak) UIScrollView *titlesView;

/******************** 记录上一次点击标题按钮 *******************/
@property (nonatomic, strong) AIRTitleBtn *previousClickedTitleButton;

/******************** viewModel *******************/
@property (nonatomic, strong) AIREssenceModel *viewModel;
@end

@implementation AIREssenceController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.viewModel = [[AIREssenceModel alloc] init];
    
    self.view.backgroundColor = [UIColor grayColor];
    //设置导航条
    [self setUpStackControllerBar];
    
    //添加UIScrollView
    [self setUpScrollView];

    //设置标题栏
    [self setUpTitlesView];
    
    
    // Do any additional setup after loading the view.
}

#pragma mark - 初始化设置

- (void)setUpScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor greenColor];
    scrollView.frame = self.view.bounds;
    [self.view addSubview:scrollView];
    
}

- (void)setUpTitlesView
{
    UIScrollView *titlesView = [[UIScrollView alloc] init];
    /*********
     [[UIColor whiteColor] colorWithAlphaComponent:0.5]; 设置颜色透明, 直接设置父控件的透明度子控件也受印象
    *********/
    titlesView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    
    /*********
     35,需求文档里会有具体多高\
     ; 如果添加到UIScrollView里内边距就会自动向下挪动64
     *********/
    titlesView.frame = CGRectMake(0, 64, self.view.AIR_width, 35);
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    
    //添加标题栏按钮
    [self setUpTitlesBtns];
    
    //标题下划线
    [self setUpTitlesUnderLine];

}

- (void)setUpTitlesBtns
{
   
    //按钮尺寸
    CGFloat btnWidth = self.titlesView.AIR_width / 5;
    CGFloat btnHeight = self.titlesView.AIR_height;
    
    for (NSInteger i = 0; i<5; i++) {
        AIRTitleBtn *titleBtn = [AIRTitleBtn buttonWithType:UIButtonTypeCustom];
        titleBtn.frame = CGRectMake(i * btnWidth, 0, btnWidth, btnHeight );
        //titleBtn.backgroundColor = AIRRandomColor;
        [self.titlesView addSubview:titleBtn];
        
        /******
         设置文字 titleBtn.enabled = NO,UIControlStateDisabled按钮无法点击(userInteractionEnabled是UIControlStateNormal, 也是无法点击),UIControlStateHighlighted  推测有highlighted属性, 但是松开之后会恢复到UIControlStateNormal, 重写- (void)setHighlighted:(BOOL)highlighted方法，永远不会进入高亮状态
         为什么这句不起效果，必须要重写- (void)setHighlighted:(BOOL)highlighted方法呢？
         因为UIControlStateSelected跟一些状态[UIControlStateHighlighted,UIControlStateDisabled]会有颜色矛盾，最后只能显示UIControlStateNormal下的颜色, 我们只能通过UIControlStateHighlighted实现原理去处理这样一个问题, 重写setHighlighted方法 (不实现它)，让它永远返回YES
         ******/
        [titleBtn setTitle:self.viewModel.titles[i] forState:UIControlStateNormal];
        [titleBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        
        [titleBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        
        
        //添加事件监听
        [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)setUpTitlesUnderLine
{
    
}


#pragma mark - 设置导航条内容
- (void)setUpStackControllerBar{
    //栈顶控制器决定导航条内容
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem Air_itemWithImage:[UIImage imageNamed:@"nav_item_game_icon"] HighlightedImage:[UIImage imageNamed:@"nav_item_game_click_icon"] isSelectedOrHighlighted:NO target:self action:@selector(game) subViewsHandle:^(UIButton *btn) {
        
    }];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem Air_itemWithImage:[UIImage imageNamed:@"navigationButtonRandom"] HighlightedImage:[UIImage imageNamed:@"navigationButtonRandomClick"] isSelectedOrHighlighted:NO target:self action:@selector(game) subViewsHandle:^(UIButton *btn) {
    }];
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage AIR_OriginalImageWithDefaultImageName:@"MainTitle"]];
    
  
    
}

#pragma mark - 监听
- (void)titleBtnClick:(AIRTitleBtn *)titleBtn{
    //AIRFUNCLog;
    self.previousClickedTitleButton.selected = NO;
    titleBtn.selected = YES;
    self.previousClickedTitleButton = titleBtn;
    
    
}

- (void)game{
    //AIRFUNCLog;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - lazy


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
