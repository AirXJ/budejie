//  经典静态tableview的配置
//  AIRSubTagTableViewController.m
//  BuDeJie
//
//  Created by air on 佛历2560-4-5.
//  音乐分类列表
//http://mobile.ximalaya.com/mobile/discovery/v1/rankingList/album?device=iPhone&key=ranking:album:played:1:2&pageId=1&pageSize=20&position=0&title=排行榜

//http://mobile.ximalaya.com/mobile/discovery/v1/rankingList/album?device=iPhone&key=ranking:album:played:1:2&pageId=2&pageSize=20&position=0&title=排行榜


#import "AIRSubTagTableViewController.h"
#import <AFNetworking.h>
#import "AIRSubTagItem.h"
#import <MJExtension/MJExtension.h>
#import "AIRSubTagCell.h"



@interface AIRSubTagTableViewController ()
@property (nonatomic,strong) NSArray *subTags;
/********************  *******************/
@property (nonatomic,strong) AFHTTPSessionManager *mgr;
@end
static NSString *const cellID = @"cell";
@implementation AIRSubTagTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"AIRSubTagCell" bundle:nil]  forCellReuseIdentifier:cellID];
    //展示标签界面数据=> 接口文档 请求的url(基本url＋请求参数) 请求方式 ->解析数据(写成plist) title albumCoverUrl290 tracks -> 设计模型 -> 字典转模型 -> 展示数据
    [self loadData];
    //不能在根控制器里使用
    self.title = @"推荐标签";
    //提示用户当前正在加载数据SVProgreesHUD
    [SVProgressHUD showWithStatus:@"正在加载ing....."];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //销毁指示器
    [SVProgressHUD dismiss];
    //取消之前的请求
    [self.mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
    
}

#pragma mark - RequestData
//接口文档 请求的url(基本url＋请求参数) 请求方式
- (void)loadData{
    //创建请求会话管理者
    self.mgr = [AFHTTPSessionManager manager];
   
    
    //拼接参数
     NSDictionary *parameters = @{@"device":@"iPhone", @"key":@"ranking:album:played:1:2", @"pageId":@2, @"pageSize": @20, @"position": @0, @"title": @"排行榜"};

   
    [self.mgr GET:@"http://mobile.ximalaya.com/mobile/discovery/v1/rankingList/album" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
            
            
            
        } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
            //AIRLog(@"%@",responseObject);
            
            //[responseObject[@"list"] writeToFile:@"/Users/air/Desktop/budejie/sub.plist" atomically:YES];
            //字典数组转换模型数组
            [SVProgressHUD dismiss];
            self.subTags = [AIRSubTagItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            [self.tableView reloadData];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [SVProgressHUD showErrorWithStatus:@"网络错误！"];
        }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
//处理cell分割线
kRemoveCellSeparator

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.subTags.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //自定义cell
    AIRSubTagCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
   // AIRLog(@"%p",cell);
    AIRSubTagItem *item = (AIRSubTagItem *)self.subTags[indexPath.row];
    cell.item = item;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
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
