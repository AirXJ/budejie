//
//  AIRSoundTableController.m
//  BuDeJie
//
//  Created by air on 17/4/29.
//  Copyright © 2017年 air. All rights reserved.
//

#import "AIRSoundTableController.h"


@interface AIRSoundTableController ()

@end

@implementation AIRSoundTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    //AIRFUNCLog;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarBtnDidRepeatClick:) name:AIRTitleBtnDidRepeatClickNotification object:nil];
    // AIRFUNCLog;添加通知监听,不添加监听就不会收到通知, 收到通知马上刷新, 控制器的view被dealloc一定要移除通知监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarBtnDidRepeatClick:) name:AIRTabBarBtnDidRepeatClickNotification object:nil];
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AIRTabBarBtnDidRepeatClickNotification object:nil];
}

#pragma mark - 监听 通知模式

- (void)tabBarBtnDidRepeatClick:(NSNotification *)notification{
    
    //没有点击精华按钮退出方法
    if (self.view.window == nil) return;
    //显示在正中间的不是AIRAllTableController, 不显示的view必须移除
    if (self.tableView.superview == nil) return;
    AIRFUNCLog;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
AIRTestCodeTableDataSource

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
