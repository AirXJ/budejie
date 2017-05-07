//
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
#import "AIRDownRefreshView.h"

@interface AIRAllTableController ()
/******************** 数据量 *******************/
@property (nonatomic, assign) NSUInteger dataCount;

/******************** 上拉控件 *******************/
@property (nonatomic, weak) AIRFooterView *tableViewFooter;

/******************** 下拉控件下拉可以刷新 *******************/
@property (nonatomic, weak) AIRDownRefreshView *downRefreshView;

/******************** 下拉控件2松开立即刷新 *******************/
@property (nonatomic,weak) AIRDownRefreshView *upRefreshView;

/******************** 下拉控件3正在刷新 *******************/
@property (nonatomic,weak) AIRDownRefreshView *ingRefreshView;

@end

#define kAllIndex AIREssenceModel *model = [[AIREssenceModel alloc] init];\
NSUInteger index = [model.titles indexOfObject:@"全部"];\
AIREssenceController *parentVc = (AIREssenceController *)self.parentViewController;

@implementation AIRAllTableController
//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    AIRLog(@"~~~~");
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        self.dataCount = 7;
    //        [self.tableView reloadData];
    //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //            self.dataCount = 0;
    //            [self.tableView reloadData];
    //        });
    //    });
    
    self.dataCount = 3;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleBtnDidRepeatClick:) name:AIRTitleBtnDidRepeatClickNotification object:nil];
    
    // AIRFUNCLog;添加通知监听,不添加监听就不会收到通知, 收到通知马上刷新, 控制器的view被dealloc一定要移除通知监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarBtnDidRepeatClick:) name:AIRTabBarBtnDidRepeatClickNotification object:nil];
    
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
    AIRFUNCLog;
}

/**监听titleBtn重复点击**/
- (void)titleBtnDidRepeatClick:(NSNotification *)notification{
    [self tabBarBtnDidRepeatClick:notification];
}

#pragma mark - 监听UIScrollViewDelegate

/*********一加载就会调用一次，然后除非滚动的时候会再次调用*********/
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //处理上拉刷新
    [self dealUpFooterRefreshing];
    //判断下拉状态
    [self judgeHeaderRefreshStateBetween:self.downRefreshView andCurrentView:self.upRefreshView useByOffsetY:- (self.tableView.contentInset.top + self.upRefreshView.AIR_height)];//处理下拉刷新
    
}

/*********手一松开*********/
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    CGFloat offsetY = - (self.tableView.contentInset.top + self.upRefreshView.AIR_height);
    if (self.tableView.contentOffset.y <= offsetY) {
        //开始处理下拉刷新
        [self dealHeaderRefreshing:offsetY];
        //结束下拉刷新
        [self finishedHeaderRefreshing];
    }
  
}

#pragma mark - header逻辑和UI变化
/*********判断下拉状态*********/
- (void)judgeHeaderRefreshStateBetween:(AIRDownRefreshView *)previousView andCurrentView:(AIRDownRefreshView *)currentView useByOffsetY:(CGFloat)offsetY{
    if (previousView.headerRefreshing == YES) return;
    //当偏移量小于－149，说明下拉控件完全出现 - [偏移量 0-坐标值(0上负数, 0下正数)]
    if (self.tableView.contentOffset.y <= offsetY) {
        [previousView removeFromSuperview];
        [self.tableView addSubview:currentView];
        previousView.headerRefreshing = YES;
    } else {
        [currentView removeFromSuperview];
        [self.tableView addSubview:previousView];
        previousView.headerRefreshing = NO;
    }
}

/*****************处理下拉刷新**********/
- (void)dealHeaderRefreshing:(CGFloat)offsetY{
    [self judgeHeaderRefreshStateBetween:self.upRefreshView andCurrentView:self.ingRefreshView useByOffsetY:offsetY];
    self.tableView.contentInset = UIEdgeInsetsMake(AIRNavMaxY + AIRTitlesViewH + self.downRefreshView.AIR_height, 0, AIRTabBarH, 0);
    
}

/*****************结束下拉刷新**********/
-(void)finishedHeaderRefreshing{
    //处理服务器请求
    AIRLog(@"发送请求给服务器");
    dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, (int64_t)( 2 * NSEC_PER_SEC));
    dispatch_after(delay, dispatch_get_main_queue(), ^{
        //数据返回
        self.dataCount += 20;
        //结束刷新，减小内边距
        self.downRefreshView.headerRefreshing = NO;
        self.upRefreshView.headerRefreshing = NO;
        [self.ingRefreshView removeFromSuperview];
        [self.tableView addSubview:self.downRefreshView];
        [self.tableView reloadData];
        [UIView animateWithDuration:0.3 animations:^{
            self.tableView.contentInset = UIEdgeInsetsMake(AIRNavMaxY + AIRTitlesViewH, 0, AIRTabBarH, 0);
            
        }];
    });
}

#pragma mark - footer逻辑和UI变化
/*****************处理上拉刷新**********/
- (void)dealUpFooterRefreshing{
    //还没有内容的时候, 不需要判断
    if (self.tableView.contentSize.height == 0) return;
    //如果正在刷新, 直接返回
    if (self.tableViewFooter.isFooterRefreshing == YES) return;
    //contentSize内容尺寸 contentInset内边距
    CGFloat offsetY = self.tableView.contentSize.height + self.tableView.contentInset.bottom - self.tableView.AIR_height;// - self.tableView.tableFooterView.AIR_height * 0.5
    //frame以内容的原点为原点(内容不包括内边距contentinset)偏移量 0 － 坐标值(0上负数, 0下正数), footer完全出现，并且是往上拖拽
    if (self.tableView.contentOffset.y >= offsetY && self.tableView.contentOffset.y > - (self.tableView.contentInset.top)) {
        //进入刷新状体啊
        //self.tableView.tableFooterView
        
        self.tableViewFooter.footerRefreshing = YES;
        self.tableViewFooter.refreshLabel.text = @"正在加载更多数据";
        self.tableViewFooter.backgroudView.backgroundColor = [UIColor orangeColor];
        [self.tableViewFooter.netActivityIndicator startAnimating];
        [self finishedFooterRefreshing];
    }
}

/*****************结束上拉刷新**********/
- (void)finishedFooterRefreshing{
    //发送请求给服务器
    AIRLog(@"发送请求给服务器");
    dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, (int64_t)( 2.0 * NSEC_PER_SEC));
    dispatch_after(delay, dispatch_get_main_queue(), ^{
        //服务器请求回来了
        self.dataCount += 10;
        [self.tableView reloadData];
        
        //结束刷新
        self.tableViewFooter.footerRefreshing = NO;
        self.tableViewFooter.refreshLabel.text = @"上拉可以加载更多";
        self.tableViewFooter.backgroudView.backgroundColor = [UIColor lightGrayColor];
        self.tableViewFooter.netActivityIndicator.hidesWhenStopped = YES;
        [self.tableViewFooter.netActivityIndicator stopAnimating];
    });
}

#pragma mark - Header、FooterUI

- (AIRFooterView *)tableViewFooter{
    if (!_tableViewFooter) {
        kAllIndex
        AIRFooterView *footer = (AIRFooterView *)parentVc.footersArr[index];
        _tableViewFooter = footer;
    }
    return _tableViewFooter;
}

- (AIRDownRefreshView *)downRefreshView{
    if (_downRefreshView == nil) {
        kAllIndex
        AIRDownRefreshView *downRefreshView = (AIRDownRefreshView *)parentVc.downRefreshersArr[index];
        _downRefreshView = downRefreshView;
    }
    return _downRefreshView;
}

-(AIRDownRefreshView *)upRefreshView{
    if (!_upRefreshView) {
        AIRDownRefreshView *upRefreshView = [AIRDownRefreshView downRefreshViewWithState:AIRDownRefreshTypeUp];
        upRefreshView.frame = CGRectMake(0, -50, self.view.bounds.size.width, 50);
        _upRefreshView = upRefreshView;
    }
    return _upRefreshView;
}

- (AIRDownRefreshView *)ingRefreshView{
    if (!_ingRefreshView) {
        AIRDownRefreshView *ingRefreshView = [AIRDownRefreshView downRefreshViewWithState:AIRDownRefreshTypeRefreshIng];
        ingRefreshView.frame = CGRectMake(0, -50, self.view.bounds.size.width, 50);
        _ingRefreshView = ingRefreshView;
    }
    return _ingRefreshView;
}

#pragma mark - UI布局

//这里不需要
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
AIRTestCodeTableDataSource(self.dataCount)

/*
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
 
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
