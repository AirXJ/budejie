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

/******************** 标题下划线 *******************/
@property (nonatomic, weak) UIView *titleUnderLine;

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
    
    //设置背景色透明度的3种方法3⃣️
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
        
        
        //注释1⃣️
        [titleBtn setTitle:self.viewModel.titles[i] forState:UIControlStateNormal];
        
       // 挪动过的代码2⃣️
        
        
        //添加事件监听
        [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)setUpTitlesUnderLine
{
    //标题按钮
    AIRTitleBtn *firstTitleBtn = self.titlesView.subviews.firstObject;
    UIView *titleUnderLine = [[UIView alloc] init];
    titleUnderLine.AIR_height = 2;
    titleUnderLine.AIR_y = self.titlesView.AIR_height - titleUnderLine.AIR_height;
    //viewdidload按钮中的label里的字体是懒加载还没显示(willdisplay才会显示字), 所以必须计算字体宽度不能用titleBtn.titleLabel.AIR_width;去赋值;或者调用sizeToFit方法主动去调用
    //titleUnderLine.AIR_width = [firstTitleBtn.currentTitle sizeWithAttributes:@{NSFontAttributeName : firstTitleBtn.titleLabel.font}].width;
    [firstTitleBtn.titleLabel sizeToFit];
    titleUnderLine.AIR_width = firstTitleBtn.titleLabel.AIR_width + 10;
    titleUnderLine.AIR_centerX = firstTitleBtn.AIR_centerX;
    // 切换按钮状态
    firstTitleBtn.selected = YES;
    self.previousClickedTitleButton = firstTitleBtn;
    
    
    titleUnderLine.backgroundColor = [firstTitleBtn titleColorForState:UIControlStateSelected];
    [self.titlesView addSubview:titleUnderLine];
    self.titleUnderLine = titleUnderLine;
    
    
   
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
    
    // 切换按钮状态
    self.previousClickedTitleButton.selected = NO;
    titleBtn.selected = YES;
    self.previousClickedTitleButton = titleBtn;
    
    //处理下划线, 要与标题文字同宽
    [UIView animateWithDuration:0.25 animations:^{
        /****************
      titleBtn.titleLabel.text, 获取文字这种方法不建议使用可能为空;建议使用后面2种
        [titleBtn titleForState:UIControlStateNormal];
        [titleBtn currentTitle];
        **************/
        //先设置宽度, 再设置中心点, 按钮可以不用计算文字大小
        //self.titleUnderLine.AIR_width = [titleBtn.currentTitle sizeWithAttributes:@{NSFontAttributeName : titleBtn.titleLabel.font}].width;
        self.titleUnderLine.AIR_width =  titleBtn.titleLabel.AIR_width + 10;
        self.titleUnderLine.AIR_centerX = titleBtn.AIR_centerX;
    }];
    
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
#pragma mark - 注释
/**************************注释1⃣️*****************************
 设置文字 titleBtn.enabled = NO,UIControlStateDisabled按钮无法点击(userInteractionEnabled是UIControlStateNormal, 也是无法点击),UIControlStateHighlighted  推测有highlighted属性, 但是松开之后会恢复到UIControlStateNormal, 重写- (void)setHighlighted:(BOOL)highlighted方法，永远不会进入高亮状态
 为什么这句不起效果，必须要重写- (void)setHighlighted:(BOOL)highlighted方法呢？
 因为UIControlStateSelected跟一些状态[UIControlStateHighlighted,UIControlStateDisabled]会有颜色矛盾，最后只能显示UIControlStateNormal下的颜色, 我们只能通过UIControlStateHighlighted实现原理去处理这样一个问题, 重写setHighlighted方法 (不实现它)，让它永远返回YES
 ************************************************************/

/***********************挪动过的代码2⃣️**************************
              放在AIRTitleBtn自定义按钮内部实现
        [titleBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
       [titleBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:15];
************************************************************/

/*****************设置背景色透明度的3种方法3⃣️*********************
 [[UIColor whiteColor] colorWithAlphaComponent:0.5]; 设置颜色透明, 直接设置父控件的透明度子控件也受印象
 titlesView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];这个方法是设置黑白灰透明度的
 [UIColor colorWithRed:<#(CGFloat)#> green:<#(CGFloat)#> blue:<#(CGFloat)#> alpha:<#(CGFloat)#>]
 *********/
@end
