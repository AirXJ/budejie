//
//  AIRVideoTableController.m
//  BuDeJie
//
//  Created by air on 17/4/29.
//  Copyright © 2017年 air. All rights reserved.
//

#import "AIRVideoTableController.h"
#import "AIREssenceModel.h"
#import "AIRFooterView.h"
#import "AIREssenceController.h"

@interface AIRVideoTableController ()
/******************** 上拉控件 *******************/
@property (nonatomic, weak) AIRFooterView *tableViewFooter;
@end

@implementation AIRVideoTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    // AIRFUNCLog;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarBtnDidRepeatClick:) name:AIRTitleBtnDidRepeatClickNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarBtnDidRepeatClick:) name:AIRTabBarBtnDidRepeatClickNotification object:nil];
    
    AIREssenceModel *model = [[AIREssenceModel alloc] init];
    NSUInteger index = [model.titles indexOfObject:@"全部"];
    AIREssenceController *parentVc = (AIREssenceController *)self.parentViewController;
    AIRFooterView *footer = (AIRFooterView *)parentVc.footersArr[index];
    self.tableViewFooter = footer;
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 监听 通知模式

/**监听tabBarBtn重复点击**/
- (void)tabBarBtnDidRepeatClick:(NSNotification *)notification{
    
    //没有点击精华按钮退出方法
    if (self.view.window == nil) return;
    //显示在正中间的不是AIRAllTableController, 不显示的view必须移除
    if (self.tableView.superview == nil) return;
    //AIRFUNCLog;
}

/**监听titleBtn重复点击**/
- (void)titleBtnDidRepeatClick:(NSNotification *)notification{
    [self tabBarBtnDidRepeatClick:notification];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

AIRTestCodeTableDataSource(30)


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
