//
//  AIRSettingController.m
//  BuDeJie
//
//  Created by air on 佛历2560-1-28.
//  Copyright © 佛历2560年 air. All rights reserved.
//

#import "AIRSettingController.h"
#import <SDWebImage/SDImageCache.h>
#import "NSString+AIRString.h"
#import "AIRFileTool.h"
#import "NSObject+Common.h"

@interface AIRSettingController ()

@end

@implementation AIRSettingController

static NSString * const identify = @"cell";

// 获取Caches文件夹路径
#define CachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setStackControllerBar];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identify];
    
}

#pragma mark - 设置导航条内容
- (void)setStackControllerBar{
    self.navigationItem.title = @"设置";
    //栈顶控制器决定导航条内容
    // 设置右边
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"jump" style:0 target:self action:@selector(jump)];
}


- (void)jump
{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor redColor];
    vc.navigationItem.title = @"红色";
    
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    [tableView showProgress];
    // 获取缓存尺寸字符串
    cell.textLabel.text = [NSString AIR_getPathStringsize:CachePath completion:^(NSString *sizeStr) {
        cell.textLabel.text =  sizeStr;
        [cell hideProgress];
    }];
    
    return cell;
    
}

// 点击cell就会调用
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //清除缓存, 删除文件夹里所有文件
    [AIRFileTool removeDirectory:CachePath];
    [self.tableView reloadData];
}



/**********
   业务类:以后开发中用来专门处理某件事情 -> 网络处理, 缓存处理
 
 
 ***********/



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
