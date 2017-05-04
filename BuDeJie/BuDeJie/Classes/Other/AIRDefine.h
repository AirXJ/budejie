//  宏文件
//  AIRDefine.h
//  BuDeJie
//
//  Created by air on 佛历2560-2-3.
//  Copyright © 佛历2560年 air. All rights reserved.
//

#ifndef AIRDefine_h
#define AIRDefine_h

#pragma mark - 颜色
/********颜色********/
#define AIRColor(r,g,b) [UIColor colorWithRed:(r) / 256.0 green:(g) / 256.0 blue:(b) / 256.0 alpha:1]
#define AIRRandomColor AIRColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))
/********颜色********/

#pragma mark - 屏幕适配
/********屏幕适配********/
#define AIRScreenW [UIScreen mainScreen].bounds.size.width
#define AIRScreenH [UIScreen mainScreen].bounds.size.height
#define AIRiphonePLUS (AIRScreenH == 736)
#define AIRiphoneDefault (AIRScreenH == 667)
#define AIRiphoneSE (AIRScreenH == 568)
#define AIRiphone4S (AIRScreenH == 480)
/********屏幕适配********/

#pragma mark - 系统适配
/********系统适配********/
#define IOS10_OR_LATER ([[[UIDevice currentDevice] systemVersion] compare:@"10.0"] != NSOrderedAscending)
#define IOS9_OR_LATER ([[[UIDevice currentDevice] systemVersion] compare:@"9.0"] != NSOrderedAscending)
#define IOS8_OR_LATER ([[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending)
#define IOS7_OR_LATER ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)
#define IOS6_OR_LATER ([[[UIDevice currentDevice] systemVersion] compare:@"6.0"] != NSOrderedAscending)
#define IOS5_OR_LATER ([[[UIDevice currentDevice] systemVersion] compare:@"5.0"] != NSOrderedAscending)
#define IOS4_OR_LATER ([[[UIDevice currentDevice] systemVersion] compare:@"4.0"] != NSOrderedAscending)
#define IOS3_OR_LATER ([[[UIDevice currentDevice] systemVersion] compare:@"3.0"] != NSOrderedAscending)
/********系统适配********/


#pragma mark - UIView UIViewController
/********frameConsts********/
#define AIRNavMaxY 64
#define AIRTabBarH 49
#define AIRTitlesViewH 35
/********frameConsts********/

/**不允许自动修改UIScrollView的内边距contentInset
**/
#define AIRIsContentInset self.automaticallyAdjustsScrollViewInsets = NO;
/**不允许自动修改UIScrollView的内边距contentInset
 **/

/********移除iOS7之后，cell默认左侧的分割线边距********/
#define AIRRemoveCellSeparator \
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{\
cell.separatorInset = UIEdgeInsetsZero;\
cell.layoutMargins = UIEdgeInsetsZero; \
cell.preservesSuperviewLayoutMargins = NO; \
}
/********移除iOS7之后，cell默认左侧的分割线边距********/


#pragma mark - 忽略警告
/****************忽略警告:其他警告具体查印象笔记*****************/
//当你有很多警告的时候可以写个宏函数，不停的for循环。
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)
/*****************忽略警告:其他警告具体查印象笔记*****************/

#pragma mark - 单例模式
/********单例模式***********/
#define AIRSingleH(name) +(instancetype)share##name;

#if __has_feature(objc_arc)
//条件满足 ARC
#define AIRSingleM(name) static id _instance;\
+(instancetype)allocWithZone:(struct _NSZone *)zone\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [super allocWithZone:zone];\
});\
\
return _instance;\
}\
\
+(instancetype)share##name\
{\
return [[self alloc]init];\
}\
\
-(id)copyWithZone:(NSZone *)zone\
{\
return _instance;\
}\
\
-(id)mutableCopyWithZone:(NSZone *)zone\
{\
return _instance;\
}

#else
//MRC
#define AIRSingleM(name) static id _instance;\
+(instancetype)allocWithZone:(struct _NSZone *)zone\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [super allocWithZone:zone];\
});\
\
return _instance;\
}\
\
+(instancetype)share##name\
{\
return [[self alloc]init];\
}\
\
-(id)copyWithZone:(NSZone *)zone\
{\
return _instance;\
}\
\
-(id)mutableCopyWithZone:(NSZone *)zone\
{\
return _instance;\
}\
-(oneway void)release\
{\
}\
\
-(instancetype)retain\
{\
return _instance;\
}\
\
-(NSUInteger)retainCount\
{\
return MAXFLOAT;\
}
#endif


#pragma mark - 测试代码
#define AIRTestCodeTableDataSource - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section\
{\
    return 30;\
}\
\
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath\
{\
    static NSString *ID = @"cell";\
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];\
    if (cell == nil) {\
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];\
        cell.backgroundColor = [UIColor clearColor];\
    }\
    cell.textLabel.text = [NSString stringWithFormat:@"%@-%zd", self.class, indexPath.row];\
    return cell;\
}


#endif /* AIRdefine_h */
