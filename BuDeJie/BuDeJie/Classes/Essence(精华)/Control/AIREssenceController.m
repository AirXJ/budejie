//åß©Ω≈ç√∫
//  AIREssenceController.m
//  BuDeJie
//
//  Created by air on 佛历2560-1-26.
//  Copyright © 佛历2560年 air. All rights reserved.
//

#import "AIREssenceController.h"
#import "AIRTitleBtn.h"
#import "AIREssence.h"
#import "AppDelegate.h"

#define childCount self.childViewControllers.count
@interface AIREssenceController ()<UIScrollViewDelegate>//,AIRAppTouchDelegate>
/***************** 控制器view上的scrollView, 存放所有子控制器的view *******************/
@property (nonatomic,weak) UIScrollView *scrollView;
/***************** 控制器view上的标题栏    ****************************************/
@property (nonatomic, weak) UIScrollView *titlesView;

/***************** 记录上一次点击标题按钮(标题栏) *********************************/
@property (nonatomic, strong) AIRTitleBtn *previousClickedTitleButton;

/***************** 标题下划线(标题栏) ****************************************/
@property (nonatomic, weak) UIView *titleUnderLine;

/***************** viewModel ********************************************/
@property (nonatomic, strong) AIREssenceModel *viewModel;
@end

@implementation AIREssenceController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.viewModel = [[AIREssenceModel alloc] init];
//    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    appDelegate.delegate = self;
    self.view.backgroundColor = [UIColor grayColor];
    
    //3.2初始化子控制器
    [self setUpChildVCs];
    
    //1.设置导航条
    [self setUpStackControllerBar];
    
    //2.添加UIScrollView
    [self setUpScrollView];

    //2.设置标题栏
    [self setUpTitlesView];
    
    //3.1设置子控制器视图
    //[self setUpChildViews];
    
    
    // Do any additional setup after loading the view.
}

#pragma mark - 初始化设置
//初始化子控制器
- (void)setUpChildVCs{
    [self addChildViewController:
        [[AIRAllTableController alloc] init]];
    [self addChildViewController:[[AIRVideoTableController alloc] init]];
    [self addChildViewController:[[AIRSoundTableController alloc] init]];
    [self addChildViewController:[[AIRPhotoTableController alloc] init]];
    [self addChildViewController:[[AIRJokeTableController alloc] init]];
}

- (void)setUpScrollView
{
    //不允许自动修改UIScrollView的内边距
    AIRIsContentInset
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor greenColor];
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    scrollView.scrollsToTop = NO;
    scrollView.pagingEnabled = YES;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    

    CGFloat scrollViewW = self.scrollView.AIR_width;
    //🆗†默认加载子控制器的view到self.scrollView中
    [self addChildViewIntoScrollView:0];

    self.scrollView.contentSize = CGSizeMake(childCount * scrollViewW, 0);

}

/**************************🆗†设置子控制器视图, 其他的view需要懒加载所以移除这个方法
- (void)setUpChildViews
{
    NSUInteger count = self.childViewControllers.count;
    CGFloat scrollViewW = self.scrollView.AIR_width;
    CGFloat scrollViewH = self.scrollView.AIR_height;
    for (NSUInteger i = 0; i < count; i++) {
        //取出i位置子控制器的view
        UITableView *childView = (UITableView *)self.childViewControllers[i].view;
        childView.backgroundColor = AIRRandomColor;
        
        //ios6历史遗留问题tableview的frame跟普通的UIView不同, 要高20
        //设置childView的全穿透效果4⃣️
        childView.frame = CGRectMake(i * scrollViewW, 0, scrollViewW, scrollViewH);
        childView.contentInset = UIEdgeInsetsMake(AIRNavMaxY + AIRTitlesViewH, 0, AIRTabBarH, 0);
        
        
        [self.scrollView addSubview:childView];
    }
    self.scrollView.contentSize = CGSizeMake(count * scrollViewW, 0);
}
****************************************/

- (void)setUpTitlesView
{
    //标题栏
    UIScrollView *titlesView = [[UIScrollView alloc] init];
    
    //设置背景色透明度的3种方法3⃣️
    titlesView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    titlesView.showsVerticalScrollIndicator = NO;
    titlesView.showsHorizontalScrollIndicator = NO;
    titlesView.scrollsToTop = NO;
    /*********
     35,需求文档里会有具体多高\
     ; 如果添加到UIScrollView里内边距就会自动向下挪动64
     *********/
    titlesView.frame = CGRectMake(0, AIRNavMaxY, self.view.AIR_width, AIRTitlesViewH);
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
        
       // 这里的代码被挪动了2⃣️, 在自定义按钮中
        
        
        //添加事件监听
        [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)setUpTitlesUnderLine
{
    //标题按钮
    AIRTitleBtn *firstTitleBtn = self.titlesView.subviews.firstObject;
    
    UIView *titleUnderLine = [[UIView alloc] init];
    
    //构造titleUnderLine, viewdidload按钮中的label里的字体是懒加载还没显示(willdisplay才会显示字), 所以计算字体宽度必须调用sizeToFit方法主动去调用
    titleUnderLine.AIR_height = 2;
    titleUnderLine.AIR_y = self.titlesView.AIR_height - titleUnderLine.AIR_height;
    [firstTitleBtn.titleLabel sizeToFit];
    titleUnderLine.AIR_width = firstTitleBtn.titleLabel.AIR_width + 10;
    titleUnderLine.AIR_centerX = firstTitleBtn.AIR_centerX;
    titleUnderLine.backgroundColor = [firstTitleBtn titleColorForState:UIControlStateSelected];
    
    // 切换按钮状态
    firstTitleBtn.selected = YES;
    self.previousClickedTitleButton = firstTitleBtn;
    
    
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
/****切换按钮状态,处理下划线, 修改self.scrollView偏移量, 加载对应的子控制器的view, 添加功能:点击状态栏修改子控制器view的偏移量****/
- (void)titleBtnClick:(AIRTitleBtn *)titleBtn{
    // 1.1切换按钮状态
    self.previousClickedTitleButton.selected = NO;
    titleBtn.selected = YES;
    self.previousClickedTitleButton = titleBtn;
    
    NSUInteger index = [self.viewModel.titles indexOfObject:[titleBtn titleForState:UIControlStateNormal]];
    [UIView animateWithDuration:0.25 animations:^{
        //1.2处理下划线, 要与标题文字同宽:采用按钮, titlUnderLine宽度的计算方法5⃣️
        self.titleUnderLine.AIR_width =  titleBtn.titleLabel.AIR_width + 10;
        self.titleUnderLine.AIR_centerX = titleBtn.AIR_centerX;//先设置宽度再中心点
        
        //🈳️1.3点击按钮, 修改scrollView的偏移量来滚动scrollView, (偏移量只有正数并且都是相对于scrollerView的frame的原点)
       CGFloat offsetX = self.scrollView.AIR_width * index;
       self.scrollView.contentOffset = CGPointMake(offsetX, self.scrollView.contentOffset.y);
    } completion:^(BOOL finished) {
        //🆗†加载子控制器的view到self.scrollView中
        [self addChildViewIntoScrollView:index];
    }];
    //8⃣️如果i位置对应的tableView.scrollsToTop = YES,所有scrollView及其子类对象都都设置为NO。 新的iOS在多控制器管理view中不需要再一个个设置 self.scrollView.scrollsToTop了,但是只要是viewdidappear的UIScrollView都需要单独设置。
    NSUInteger count = childCount;
    for (NSUInteger i = 0; i < count; i++) {
        if (!self.childViewControllers[i].isViewLoaded) continue;
        if (![self.childViewControllers[i] isKindOfClass:[UITableViewController class]]) { continue;
        } else {
            UITableView *scrollView = (UITableView *)self.childViewControllers[i].view;
            scrollView.scrollsToTop = (i == index);
        }
    }
}


- (void)game{
    //AIRFUNCLog;
}


#pragma mark - UIScrollViewDelegate

/**********🈳️1.4当用户松开scrollView, 并且完全停止滚动时, 切换按钮状态**********/
//de 降序 rate 速度 => 减速
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //偏移量除以宽度计算第几个按钮
    NSUInteger index = scrollView.contentOffset.x / scrollView.AIR_width;
    //不要用tag7⃣️去遍历控件
    AIRTitleBtn *titleBtn = self.titlesView.subviews[index];
    // 点击对应的按钮, 切换按钮状态, 加载对应view
    [self titleBtnClick:titleBtn];
}

//当用户松开scrollView时候调用6⃣️

#pragma mark - 其他
/*****添加第index个子控制器的view到scrollView中
 @:(NSUInteger)index 可以省略，但不推荐
 *******/
- (void)addChildViewIntoScrollView:(NSUInteger)index{
    //self.childViewControllers[index].view.superview和self.childViewControllers[index].view的区别, 一个是已经addSubview了, 所以不用担心view懒加载了, addSubview之后会调用viewDidAppear;.view会调用viewDidLoad.
    if (self.childViewControllers[index].view.superview) return;
    AIRFUNCLog;
    UITableView *childView = (UITableView *)self.childViewControllers[index].view;
    childView.backgroundColor = AIRRandomColor;
    CGFloat scrollViewW = self.scrollView.AIR_width;
    CGFloat scrollViewH = self.scrollView.AIR_height;

    //ios6历史遗留问题tableview的frame跟普通的UIView不同, 要高20
    //设置childView的全穿透效果4⃣️
    childView.frame = CGRectMake(index * scrollViewW, 0, scrollViewW, scrollViewH);
    
    childView.contentInset = UIEdgeInsetsMake(AIRNavMaxY + AIRTitlesViewH, 0, AIRTabBarH, 0);
    [self.scrollView addSubview:childView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - lazy

#pragma mark - AppDelegate
//- (void)appDelegate:(AppDelegate *)appDelegate resetOffset:(CGPoint)defaultPoint{
//    NSUInteger index = [self.titlesView.subviews indexOfObject:self.previousClickedTitleButton];
//    UIScrollView *scrollView = (UIScrollView *)self.childViewControllers[index].view;
//    scrollView.contentOffset = defaultPoint;
//}

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

/***********************挪动过的代码2⃣️, 自定义按钮中**************************
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


/**********************设置childView的全穿透效果4⃣️***********************************
 0.不允许根控制器自动修改UIScrollView的内边距 \
 1.frame必须占据整个屏幕\
 2.通过设置contentInset内边距防治被导航栏和TabBar挡住
 *********************************************************************************/

/*********titlUnderLine宽度的计算方法, 按钮更简单， UILabel必须要用字体大小来计算5⃣️********

      titleBtn.titleLabel.text, 获取文字这种方法不建议使用可能为空;建议使用后面2种
    [titleBtn titleForState:UIControlStateNormal];
    [titleBtn currentTitle];

    //按钮不用计算文字大小
    self.titleUnderLine.AIR_width = [titleBtn.currentTitle sizeWithAttributes:@{NSFontAttributeName : titleBtn.titleLabel.font}].width;
***********************************/


/***************************当用户松开scrollView时候调用6⃣️****************************
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{

    AIRFUNCLog;

}
***************************当用户松开scrollView时候调用****************************/


/*********永远不要用tag去遍历控件7⃣️, tag容易出错(所有控件默认都是0)而且效率低, 递归遍历子控件的子控件的子控件(遍历完最后一层的最后一个再返回上面一支); 所以说用一层tag还好，用多了就麻烦了。*********/

/***监听状态栏区域点击8⃣️:当一个view中有多个scrollView的时候，只要大于等于2个view的.scrollsToTop = YES,那么点击状态栏不会将显示在眼前的拉下来的scrollView跳回到初始位置**/
@end
