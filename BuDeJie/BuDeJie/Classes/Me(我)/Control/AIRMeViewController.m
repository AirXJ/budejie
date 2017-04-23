//  静态单元格只能用故事版加载
//  AIRMeViewController.m
//  BuDeJie
//
//  Created by air on 17/4/15.
//  Copyright © 2017年 air. All rights reserved.
//

#import "AIRMeViewController.h"
#import "AIRSquareCell.h"
#import "AIRSquareItem.h"
#import <SafariServices/SafariServices.h>
#import "AIRWebViewController.h"

//⚠️检查代理3步，少一步就不能调用方法
@interface AIRMeViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

/******************** square模型数组 *******************/
@property (nonatomic, strong) NSMutableArray *modelArr;
/******************** 控件 *******************/
@property (nonatomic, weak) UICollectionView *collectionView;
@end

//静态常量区，static只可以本文件内使用
static NSString * const identify = @"squareCell";


//设置cell尺寸
static NSInteger const cols = 4;
static CGFloat const margin = 1;
static CGFloat const AIRCommonMargin = 10;
#define count self.modelArr.count
#define itemWH (AIRScreenW - (cols - 1)*margin)/cols


@implementation AIRMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
    [self setTableViewForFooter];
    //展示方块内容 -> 获取数据(查看接口文档)
    [self loadData];
    
    /*******跳转细节
     1.collectionView高度需要重新计算 => collectionView的高度需要根据内容去计算 => 又数据了 需要计算其高度
     2.collectionView不需要滚动
     ******/
    
    
}

#pragma mark - 请求数据
#define baseUrl @"http://api.budejie.com/api/api_open.php"
- (void)loadData{
    //1.创建请求会话管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    //2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{
         @"a":@"square",
         @"c":@"topic"
        }];
    //3.发送请求  icon  name url
    [mgr GET:baseUrl parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //[responseObject writeToFile:@"/Users/air/Desktop/budejie/sub.plist" atomically:YES];
        //AIRLog(@"%@",responseObject);
        //字典数组转模型数组
        NSArray *dicArr = responseObject[@"square_list"];
        self.modelArr = [AIRSquareItem mj_objectArrayWithKeyValuesArray:dicArr];
        //处理数据,补collectionView空缺额外格子
        [self resloveData];
        
        
        //设置collectionView的高度＋10,不能省略，会有点小bug测试下来
        NSInteger rows = (count - 1)/cols + 1;
        self.collectionView.AIR_height = rows * itemWH + 10.0;
/******************************************************
    设置collectionView的高度 rows * itemWH ->万能公式 : Rows = (count - 1)/cols + 1
        NSInteger count = self.modelArr.count;
        NSInteger rows = (count - 1)/cols + 1;
        self.collectionView.AIR_height = rows * itemWH;
 
   重新设置tableview滚动范围:自己计算\
   self.tableView.contentSize这个属性是tableview不存在，是自己计算的。下面这句没作用
       self.tableView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.collectionView.frame));
****************************************************/
        self.tableView.tableFooterView = self.collectionView;
        
        //有了数据, 刷新表格
        [self.collectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark - Table view footerView
- (void)setTableViewForFooter{
    /***
     1.初始化要设置流水布局
     2.cell必须注册
     3.cell必须自定义
     ***/
        //创建布局
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
       
        layout.itemSize = CGSizeMake(itemWH, itemWH);
        layout.minimumLineSpacing = margin;
        layout.minimumInteritemSpacing = margin;
        
        //创建UICollectionView
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
        self.collectionView = collectionView;
        //禁止collectionView滚动
        self.collectionView.scrollEnabled = NO;
        collectionView.dataSource = self;
        collectionView.delegate = self;
        //注册cell
        [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([AIRSquareCell class]) bundle:nil] forCellWithReuseIdentifier:identify];
        collectionView.backgroundColor = self.tableView.backgroundColor;
        
        self.tableView.tableFooterView = collectionView;
    
    /*********⚠️重要
     用.更不容易出现bug，建议多使用.语法
     处理cell间距,默认tableView分组样式,有额外头部和尾部间距
     以及调整内边距(-25代表：所有内容往上移动25)
     *******/
       self.tableView.sectionHeaderHeight = 0;
       self.tableView.sectionFooterHeight = AIRCommonMargin;
       self.tableView.contentInset = UIEdgeInsetsMake(AIRCommonMargin - 35, 0, 0, 0);
    
    

}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AIRSquareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.item = self.modelArr[indexPath.item];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    AIRLog(@"点击了小格子");
    //跳转界面 push 展示一个网页 3中方法 1.应用代理的openURL 自带功能(进度条，刷新，前进等)，必须跳出当前应用 2.UIWebView (没有功能)，在当前应用打开网页, 功能要自己实现，而且不提供进度条\
    3.SFSafariViewController: iOS9之后,新推出一个框架，集齐了1和2所有的优点 \
     首先要导入#import <SafariServices/SafariServices.h>\
    4.WKWebView: iOS8之后, UIWebView的升级版(添加功能:监听任务 缓存) 。\
     首先要导入#import <WebKit/WebKit.h>
    
    AIRSquareItem *item = self.modelArr[indexPath.item];
    if (![item.url containsString:@"http"]) {
        return;
    }
    NSURL *itemUrl = [NSURL URLWithString:item.url];
/******************************************************

    SFSafariViewController *safariVc = [[SFSafariViewController alloc]initWithURL:itemUrl];
    //用modal会自动返回，自动显示隐藏self.navigationController.navigationBarHidden,不需要再设置代理再实现代理方法了
    [self presentViewController:safariVc animated:YES completion:nil];
 
******************************************************/
   //创建网页控制器
    AIRWebViewController *webVc = [[AIRWebViewController alloc] init];
    [self.navigationController pushViewController:webVc animated:YES];




}

//#pragma mark - SFSafariViewControllerDelegate
//- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller{
////    [self.navigationController popViewControllerAnimated:YES];
//}
#pragma mark - 处理请求完成数据
- (void)resloveData
{
    //判断下缺几个
    //3 % 4 = 3 cols - 3 = 1
    //5 % 4 = 1 cols - 1 = 3
    NSInteger exter = count % cols;
    if (exter) {
        exter = cols - exter;
        for (int i = 0; i<exter; i++) {
            AIRSquareItem *item = [[AIRSquareItem alloc]init];
            [self.modelArr addObject:item];
        }
    }
}

#pragma mark - setupNavBar
- (void)setupNavBar
{
    // 左边按钮
    // 把UIButton包装成UIBarButtonItem.就导致按钮点击区域扩大
    
    // 设置
     UIBarButtonItem *settingItem =  [UIBarButtonItem Air_itemWithImage:[UIImage imageNamed:@"mine-setting-icon"] HighlightedImage:[UIImage imageNamed:@"mine-setting-icon-click"] isSelectedOrHighlighted:NO target:self action:@selector(setting) subViewsHandle:^(UIButton *btn) {
         
     }];
    
    // 夜间模型
    UIBarButtonItem *nightItem =  [UIBarButtonItem Air_itemWithImage:[UIImage imageNamed:@"mine-moon-icon"] HighlightedImage:[UIImage imageNamed:@"mine-moon-icon-click"] isSelectedOrHighlighted:YES target:self action:@selector(night:) subViewsHandle:^(UIButton *btn) {
        
    }];
    
    self.navigationItem.rightBarButtonItems = @[settingItem,nightItem];
    
    // titleView
    self.navigationItem.title = @"我的";
    
}

- (void)night:(UIButton *)button
{
    button.selected = !button.selected;
    
}

#pragma mark - 设置就会调用
- (void)setting
{
    // 跳转到设置界面
    AIRMeViewController *settingVc = [[AIRMeViewController alloc] init];
    // 必须要在跳转之前设置
    settingVc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:settingVc animated:YES];
    
    /*
     1.底部条没有隐藏
     2.处理返回按钮样式 : 1.去设置控制器里
     */
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
