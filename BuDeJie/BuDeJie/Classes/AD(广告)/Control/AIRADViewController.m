//
//  AIRADViewController.m
//  BuDeJie
//
//  Created by air on 佛历2560-4-5.
//  Copyright © 佛历2560年 air. All rights reserved.
//

#import "AIRADViewController.h"
#import "AIRADItem.h"
#import "AIRTabBarController.h"

#define code2 @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"
@interface AIRADViewController ()
@property (weak, nonatomic) IBOutlet UIButton *jumpButton;
@property (weak, nonatomic) IBOutlet UIImageView *launchImageView;
@property (weak, nonatomic) IBOutlet UIView *adContainView;
/******************** 广告界面 *******************/
@property (nonatomic,weak) UIImageView *adImageView;

/******************** 广告模型 *******************/
@property (nonatomic,strong) AIRADItem *item;

/******************** 定时器 *******************/
@property (nonatomic,strong)NSTimer *timer;


@end

@implementation AIRADViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    //设置启动图片
    [self setupLaunchImageView];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    //加载广告数据 => 拿到活的数据 => 服务器 => 查看接口文档\
    判断接口对不对,解析数据\
    w h ori_curl w_picurl =>请求数据AFN
    [self loadAdData];
    //cocoapods:管理第三方库，导入第三方框架和其依赖的框架\

}

#pragma mark - 加载广告数据
- (void)loadAdData{
    //1.创建请求会话管理者,配置解析器
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    //一般不改这步，但是如果响应头的返回的contenttype类型无法处理，只能添加类型了
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    //2.拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"code2"] = code2;
    //2.发送请求
    [mgr GET:@"http://mobads.baidu.com/cpro/ui/mads.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary  *_Nullable responseObject) {
        //请求数据->解析数据(写成plist文件，方便查看）->设计模型->字典转模型->展示数据
       // [responseObject writeToFile:@"/Users/air/Desktop/c语言飞起/ad.plist" atomically:YES];
        NSDictionary *adDict = [responseObject[@"ad"] firstObject];
        //字典转模型
       AIRADItem *item = [AIRADItem mj_objectWithKeyValues:adDict];
        self.item = item;
//        AIRLog(@"%@",item);
//        AIRLog(@"%@",responseObject);
        //创建UIImageView展示广告界面
        //w传nil会死机
        if (!item.w&&!item.h){
        CGFloat h = AIRScreenW/item.w*item.h;
        self.adImageView.frame = CGRectMake(0, 0, AIRScreenW, h);
        }
        //加载广告网页
        [self.adImageView sd_setImageWithURL:[NSURL URLWithString:item.w_picurl]];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

//设置启动图片,Assets.xcassets里的启动图片必须设置不然无法使用
- (void)setupLaunchImageView{
        //320 × 480 pixels iPhone4(淘汰了)
    if (AIRiphone4S) {
        //640 × 960 pixels LaunchImage-700@2x.png
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-4S"];
    }
    if (AIRiphoneSE) {
        //640 × 1136 pixels LaunchImage-568h@2x.png
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-SE"];
    }
    if(AIRiphoneDefault){
        //750 × 1334 pixels LaunchImage-800-667h@2x.png
         self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-667"];
    }
    if (AIRiphonePLUS) {
        //1242 × 2208 pixels LaunchImage-800-Portrait-736h@3x.png
         self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-PLUS"];
    }
    
   
    
}

#pragma mark - @selector
- (void)timeChange{
    //倒计时
   // AIRFUNCLog;
//    UIControlStateHighlighted
    
    static int i = 2;
    //在xib中设置按钮样式为custom不再闪
    [self.jumpButton setTitle:[NSString stringWithFormat:@"跳过 (%zd)",i] forState:UIControlStateNormal];
    if (i == 0) {
        //销毁广告界面,进入主框架界面，添加到主窗口
        [UIApplication sharedApplication].keyWindow.rootViewController = [[AIRTabBarController alloc]init];
        //干掉定时器
        [self.timer invalidate];
    }
    i--;
    
}


//点击跳转界面，command option enter 故事版联线的时候打开右边窗口，command option ＝自动对齐约束
- (IBAction)clickJump:(UIButton *)sender {
    //销毁广告界面,进入主框架界面，添加到主窗口
    [UIApplication sharedApplication].keyWindow.rootViewController = [[AIRTabBarController alloc]init];
    //干掉定时器
    [self.timer invalidate];
}


//点击广告界面调用
- (void)tap:(UITapGestureRecognizer *)tap{
    //跳转界面=>safari
    NSURL *url = [NSURL URLWithString:self.item.ori_curl];
   // NSURL *url = [NSURL URLWithString:@"https://twitter.com/kharrison"];
    if ([[UIApplication sharedApplication]canOpenURL:url]) {
        /**iOS10新增方法：
         UIApplication 的头文件中列了一个可用在 options字典中的key:
         * UIApplicationOpenURLOptionUniversalLinksOnly:可以设置布尔值，如果设置为true(YES),则只能打开应用里配置好的有效通用链接。如果应用程序没有配置，或者用于禁止打开这个链接，则 completion handler 回调里的success为false(NO)。
         默认这个key的值是NO
         举个例子，我把这个值设置为 true 并尝试打开https://twitter.com/kharrison, 如果我的应用没有配置这个 Twitter 链接,它将会执行失败，而不是在Safari中打开这个链接。**/
        NSDictionary *dict = @{
                UIApplicationOpenURLOptionUniversalLinksOnly:@YES
                               };
        [[UIApplication sharedApplication]openURL:url options:dict completionHandler:^(BOOL success) {
        
    }];
    }
}

#pragma mark - 懒加载
- (UIImageView *)adImageView{
    if (!_adImageView) {
        UIImageView *imageView = [[UIImageView alloc]init];
        [self.adContainView addSubview:imageView];
        _adImageView = imageView;
        _adImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [_adImageView addGestureRecognizer:tap];
    }
    return _adImageView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
