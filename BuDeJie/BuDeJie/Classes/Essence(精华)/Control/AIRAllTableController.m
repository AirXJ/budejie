// ⚠️有个bug，偏移量导致＝》正在刷新出不来
//  AIRAllTableController.m
//  BuDeJie
//
//  Created by air on 17/4/29.
//  Copyright © 2017年 air. All rights reserved.
//

#import "AIRAllTableController.h"
#import "AIREssenceController.h"
#import "AIREssenceModel.h"
#import "AIRFooterView.h"
#import "AIRHeaderRefreshView.h"
#import "AIRTopicsItem.h"
#import "NSObject+Common.h"
#import "AIRTopicCell.h"
#import "NSString+AIRString.h"

@interface AIRAllTableController ()

/******************** 上拉控件 *******************/
@property (nonatomic, weak) AIRFooterView *tableViewFooter;

/*************** 下拉控件下拉可以刷新 *******************/
@property (nonatomic, weak) AIRHeaderRefreshView *headerRefreshView;

/******************** 所有帖子数据 *******************/
@property (nonatomic, strong) NSMutableArray<AIRTopicsItem *> *topics;

/******************** 用来加载下一页数据, 最后一个数据的描述信息 *******************/
@property (nonatomic, strong) NSString *maxtime;

/******************** 网络管理者 *******************/
@property (nonatomic, strong) AFHTTPSessionManager *manger;

@end

#define kAllIndex AIREssenceModel *model = [[AIREssenceModel alloc] init];\
NSUInteger index = [model.titles indexOfObject:@"全部"];\
AIREssenceController *parentVc = (AIREssenceController *)self.parentViewController;

@implementation AIRAllTableController
//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    AIRLog(@"~~~~");
//}
/* cell的重用标识 */
static NSString * const AIRTopicCellId = @"AIRTopicCellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    // 注册cell
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([AIRTopicCell class]) bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:AIRTopicCellId];
    
    
    self.view.backgroundColor = AIRGrayColor(206);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.estimatedRowHeight = 100;
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleBtnDidRepeatClick:) name:AIRTitleBtnDidRepeatClickNotification object:nil];
    
    // AIRFUNCLog;添加通知监听,不添加监听就不会收到通知, 收到通知马上刷新, 控制器的view被dealloc一定要移除通知监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarBtnDidRepeatClick:) name:AIRTabBarBtnDidRepeatClickNotification object:nil];
    
    // 让header自动进入刷新
    [self headerBeginRefreshing];
    
}



- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 监听 目标操作(通知模式)

/**监听tabBarBtn重复点击**/
- (void)tabBarBtnDidRepeatClick:(NSNotification *)notification{
    
    //没有点击精华按钮退出方法
    if (self.view.window == nil) return;
    //显示在正中间的不是AIRAllTableController, 不显示的view必须移除
    if (self.tableView.superview == nil) return;
    
    //进入下拉刷新
    [self headerBeginRefreshing];
    
}

/**监听titleBtn重复点击**/
- (void)titleBtnDidRepeatClick:(NSNotification *)notification{
    
    [self tabBarBtnDidRepeatClick:notification];
}

#pragma mark - 监听UIScrollViewDelegate

/*********一加载就会调用一次，然后除非滚动的时候会再次调用*********/
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //处理上拉刷新
    [self dealFooterRefreshing];
    //处理下拉刷新
    [self dealHeaderRefreshing];
    
    //清除缓存
    //[[SDImageCache sharedImageCache]clearMemory];
}

/*********手一松开*********/
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    CGFloat offsetY = - (self.tableView.contentInset.top + self.headerRefreshView.AIR_height);
    
    // header已经完全出现
    if (self.tableView.contentOffset.y <= offsetY) {
        //自动刷新
        [self headerBeginRefreshing];
    }
   
}

#pragma mark - header
- (AIRHeaderRefreshView *)headerRefreshView{
    if (_headerRefreshView == nil) {
        kAllIndex
        AIRHeaderRefreshView *headerRefreshView = (AIRHeaderRefreshView *)parentVc.downRefreshersArr[index];
        _headerRefreshView = headerRefreshView;
    }
    
    return _headerRefreshView;
}

/**
 *  处理header
 */
- (void)dealHeaderRefreshing{
    // 如果正在下拉刷新，直接返回
    if (self.headerRefreshView.isHeaderRefreshing) return;
    
    // 当scrollView的偏移量y值 <= offsetY时，代表header已经完全出现
    CGFloat offsetY = - (self.tableView.contentInset.top + self.headerRefreshView.AIR_height);
    if (self.tableView.contentOffset.y <= offsetY) { // header已经完全出现
        self.headerRefreshView.refreshLabel.text = @"松开立即刷新";
        self.headerRefreshView.backgroudView.backgroundColor = [UIColor grayColor];
       
        
    } else {
        self.headerRefreshView.refreshLabel.text = @"下拉可以刷新";
        self.headerRefreshView.backgroudView.backgroundColor = [UIColor redColor];
        
    }
    
}

/**
 *  自动刷新
 */
- (void)headerBeginRefreshing{
    //if (self.tableViewFooter.isFooterRefreshing) return;
    
    // 如果正在下拉刷新，直接返回
    if (self.headerRefreshView.isHeaderRefreshing) return;
    // 进入下拉刷新状态
    self.headerRefreshView.refreshLabel.text = @"正在刷新数据...";
    self.headerRefreshView.backgroudView.backgroundColor = [UIColor blueColor];
    self.headerRefreshView.headerRefreshing = YES;
    // 增加内边距,在内容周围额外增加的间距（内边距），始终粘着内容
    [UIView animateWithDuration:0.5 animations:^{
        self.tableView.contentInset = UIEdgeInsetsMake(AIRNavMaxY + AIRTitlesViewH + self.headerRefreshView.AIR_height, 0, AIRTabBarH, 0);
        // 修改偏移量,内容距离frame矩形框，偏移了多少，frame原点减去内容的原点
        self.tableView.contentOffset = CGPointMake(0, -(AIRNavMaxY + AIRTitlesViewH + self.headerRefreshView.AIR_height));
    } completion:^(BOOL finished) {
       self.tableView.contentInset = UIEdgeInsetsMake(AIRNavMaxY + AIRTitlesViewH, 0, AIRTabBarH, 0);
    }];
   
    
    // 发送请求给服务器，下拉刷新数据
    [self loadNewTopics];
}



- (void)headerEndRefreshing{
    
    self.headerRefreshView.headerRefreshing = NO;
    [self dealHeaderRefreshing];
    
}




#pragma mark - footer
/**
 *  处理footer
 */
- (void)dealFooterRefreshing{
    //还没有内容的时候, 不需要判断
    if (self.tableView.contentSize.height == 0) return;
    
    
    //contentSize内容尺寸 contentInset内边距不算内容
    CGFloat offsetY = self.tableView.contentSize.height + self.tableView.contentInset.bottom - self.tableView.AIR_height;
    
    //frame以内容的原点为原点(内容不包括内边距contentinset)偏移量 0 － 坐标值(0上负数, 0下正数), footer完全出现，并且是往上拖拽
    if (self.tableView.contentOffset.y >= offsetY && self.tableView.contentOffset.y > - (self.tableView.contentInset.top)) {
        
        [self footerBeginRefreshing];
    }
}

- (void)footerBeginRefreshing{
    //防治同时下拉上拉刷新
   // if (self.headerRefreshView.isHeaderRefreshing) return;
    // 如果正在上拉刷新，直接返回
    if (self.tableViewFooter.isFooterRefreshing) return;
    
    self.tableViewFooter.footerRefreshing = YES;
    self.tableViewFooter.refreshLabel.text = @"正在加载更多数据";
    self.tableViewFooter.backgroudView.backgroundColor = [UIColor orangeColor];
    [self.tableViewFooter.netActivityIndicator startAnimating];
    
    // 发送请求给服务器，上拉加载更多数据
    [self loadMoreTopics];
}

- (void)footerEndRefreshing{
    self.tableViewFooter.footerRefreshing = NO;
    self.tableViewFooter.refreshLabel.text = @"上拉可以加载更多";
    self.tableViewFooter.backgroudView.backgroundColor = [UIColor lightGrayColor];
    self.tableViewFooter.netActivityIndicator.hidesWhenStopped = YES;
    [self.tableViewFooter.netActivityIndicator stopAnimating];
    
}

- (AIRFooterView *)tableViewFooter{
    if (!_tableViewFooter) {
        kAllIndex
        AIRFooterView *footer = (AIRFooterView *)parentVc.footersArr[index];
        _tableViewFooter = footer;
    }
    return _tableViewFooter;
}

#pragma mark - 数据处理
- (AIRTopicType)type{
    return AIRTopicTypePhoto;
}
- (AFHTTPSessionManager *)manger{
    if (!_manger) {
        AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
        
        _manger = mgr;
    }
    return _manger;
}

/**
 *  发送请求给服务器，下拉刷新数据
 */
- (void)loadNewTopics{
    //取消之前的请求
    [self.manger.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    
    [self.manger GET:AIRCommonUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        //AIRAFNResponseObjectWriteToPlistFile(nima);
        self.topics = [AIRTopicsItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        self.maxtime = responseObject[@"info"][@"maxtime"];
        //刷新表格
        [self.tableView reloadData];
        [self headerEndRefreshing];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //⚠️取消任务也会导致error所以提示信息必须分情况处理
        
        [error showErrorMsg:error.localizedDescription];
        [self headerEndRefreshing];
    }];
}

/**
 *  发送请求给服务器，上拉加载更多数据
 */
- (void)loadMoreTopics{
    //取消之前的请求
    [self.manger.tasks makeObjectsPerformSelector:@selector(cancel)];
  
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    parameters[@"maxtime"] = self.maxtime;
    
    [self.manger GET:AIRCommonUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        
        self.maxtime = responseObject[@"info"][@"maxtime"];
        NSMutableArray *moreTopics = [AIRTopicsItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:moreTopics];
        AIRAFNResponseObjectWriteToPlistFile(moreTopics);
       
        [self.tableView reloadData];
        [self footerEndRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //⚠️取消任务也会导致error所以提示信息必须分情况处理
        [error showErrorMsg:error.localizedDescription];
        [self footerEndRefreshing];
        
    }];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.tableViewFooter.hidden = (self.topics.count == 0);
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // control + command + 空格 -> 弹出emoji表情键盘
    //    cell.textLabel.text = @"⚠️哈哈";
     //register注册的cell会自动添加indentify不需要在xib里再写一次
    AIRTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:AIRTopicCellId];
    
    cell.topic = self.topics[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

/**
 *  这个方法的特点: 1.默认情况下，每次刷新表格reloadData，有多少数据就调用多少次行的数据。
 * 2.每当有cell静如屏幕范围，就会调用这个方法。
 *  作用:主要是精确算出contentsize的高度,(表现现象)获取滚动条高度,一般不推荐全部算出高度，建议估算出总高度estimated。
 **/

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{    
    return  self.topics[indexPath.row].cellHeight;
}


#pragma mark - lazy



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: forIndexPath:indexPath];
 
 // Configure the cell...
 
 return cell;
 }
 */

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
