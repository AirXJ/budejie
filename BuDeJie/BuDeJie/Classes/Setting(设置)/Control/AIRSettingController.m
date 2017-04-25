//
//  AIRSettingController.m
//  BuDeJie
//
//  Created by air on 佛历2560-1-28.
//  Copyright © 佛历2560年 air. All rights reserved.
//

#import "AIRSettingController.h"
#import <SDWebImage/SDImageCache.h>
#import "NSObject+Common.h"

@interface AIRSettingController ()

@end

@implementation AIRSettingController

static NSString * const identify = @"cell";

// 获取Caches文件夹路径
#define CachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

- (void)viewDidLoad {
    [super viewDidLoad];
    AIRLog(@"%@",CachePath);
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
    cell.textLabel.text = @"清除缓存";
    //计算整个应用程序的缓存数据 => 沙盒(获取Cache文件夹大小)
/******************************************************
     SDWebImage框架SDImageCache已经帮我们做了缓存 => 模仿功能自己实现 => 抽到分类中
     NSInteger size = [SDImageCache sharedImageCache].getSize;
******************************************************/
   
    // 获取缓存尺寸字符串
    cell.textLabel.text = [self sizeStr];
    
    return cell;
    
}

// 点击cell就会调用
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 清空缓存
    // 获取文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 获取cache文件夹下所有文件,不包括子路径的子路径
    NSArray *subPaths = [mgr contentsOfDirectoryAtPath:CachePath error:nil];
    
    for (NSString *subPath in subPaths) {
        // 拼接完成全路径
        NSString *filePath = [CachePath stringByAppendingPathComponent:subPath];
        
        // 删除路径
        [mgr removeItemAtPath:filePath error:nil];
    }
    
    [self.tableView reloadData];
}

// 获取缓存尺寸字符串
- (NSString *)sizeStr
{
    NSInteger totalSize = [self getFileSize:CachePath];
    
    NSString *sizeStr = @"清除缓存";
    // MB KB B
    if (totalSize > 1000 * 1000) {
        // MB
        CGFloat sizeF = totalSize / 1000.0 / 1000.0;
        sizeStr = [NSString stringWithFormat:@"%@(%.1fMB)",sizeStr,sizeF];
    } else if (totalSize > 1000) {
        // KB
        CGFloat sizeF = totalSize / 1000.0;
        sizeStr = [NSString stringWithFormat:@"%@(%.1fKB)",sizeStr,sizeF];
    } else if (totalSize > 0) {
        // B
        sizeStr = [NSString stringWithFormat:@"%@(%.ldB)",sizeStr,totalSize];
    }
    
    return sizeStr;
}

/**********
   业务类:以后开发中用来专门处理某件事情 -> 网络处理, 缓存处理
 
 
 ***********/

// 自己去计算SDWebImage做的缓存
- (NSInteger)getFileSize:(NSString *)directoryPath
{
    // NSFileManager
    // attributesOfItemAtPath:指定文件路径,就能获取文件属性
    // 把所有文件尺寸加起来
    
    // 获取文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 获取文件夹下所有的子路径,包含子路径的子路径
    NSArray *subPaths = [mgr subpathsAtPath:directoryPath];
    
    NSInteger totalSize = 0;
    
    for (NSString *subPath in subPaths) {
        // 获取文件全路径
        NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
        
        // 判断隐藏文件
        if ([filePath containsString:@".DS"]) continue;
        
        // 判断是否文件夹
        BOOL isDirectory;
        // 判断文件是否存在,并且判断是否是文件夹
        BOOL isExist = [mgr fileExistsAtPath:filePath isDirectory:&isDirectory];
        if (!isExist || isDirectory) continue;
        
        // 获取文件属性
        // attributesOfItemAtPath:只能获取文件尺寸,获取文件夹不对,
        NSDictionary *attr = [mgr attributesOfItemAtPath:filePath error:nil];
        
        // 获取文件尺寸
        NSInteger fileSize = [attr fileSize];
        
        totalSize += fileSize;
    }
    
    return totalSize;
    
}

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
