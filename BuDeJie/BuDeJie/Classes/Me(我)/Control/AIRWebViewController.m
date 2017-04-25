//
//  AIRWebViewController.m
//  BuDeJie
//
//  Created by air on 17/4/23.
//  Copyright © 2017年 air. All rights reserved.
//

#import "AIRWebViewController.h"
#import <WebKit/WebKit.h>

//⚠️Assets.xcassets中的图片渲染要关闭，采用原始模式;或者采用分类中的方法
@interface AIRWebViewController ()
@property (weak, nonatomic) IBOutlet UIView *contentView;
/********************  按钮*******************/
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goForwardItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *reloadItem;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (nonatomic,weak)WKWebView *webView;
@end

@implementation AIRWebViewController
#pragma mark - webView
- (IBAction)goBack:(UIBarButtonItem *)sender {
    [self.webView goBack];
}
- (IBAction)goForward:(UIBarButtonItem *)sender {
    [self.webView goForward];
}
- (IBAction)reload:(UIBarButtonItem *)sender {
    [self.webView reload];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.webView.frame = self.contentView.bounds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加WKWebView
    WKWebView *webView = [[WKWebView alloc] init];
    self.webView = webView;
    [self.contentView addSubview:webView];
    //展示网页
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:self.url];
    [webView loadRequest:request];
    
    //添加功能: 前进 后退 刷新 -> KVO监听属性改变，一定要记得移除
    [self.webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:@"canGoForward" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
}

//只要观察对象属性有新值就会调用
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    AIRLog(@"%d %d",self.webView.canGoBack, self.webView.canGoForward);
    self.backItem.enabled = self.webView.canGoBack;
    self.goForwardItem.enabled = self.webView.canGoForward;
    self.navigationItem.title = self.webView.title;
    self.progressView.progress = self.webView.estimatedProgress;
    self.progressView.hidden = self.webView.estimatedProgress >= 1;
}


- (void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"canGoBack"];
    [self.webView removeObserver:self forKeyPath:@"canGoForward"];
    [self.webView removeObserver:self forKeyPath:@"title"];
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    
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
