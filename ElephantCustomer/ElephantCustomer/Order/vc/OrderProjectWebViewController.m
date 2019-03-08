//
//  OrderProjectWebViewController.m
//  ElephantCustomer
//
//  Created by zj on 2019/3/6.
//  Copyright © 2019 zj. All rights reserved.
//

#import "OrderProjectWebViewController.h"
#import "UserModel.h"
#import <WebKit/WebKit.h>
#import <Masonry/Masonry.h>
#import <WebKit/WebKit.h>
#import "YBIBUtilities.h"
#import "YBImageBrowserTipView.h"
#import "YBImageBrowser.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ImageCollectionViewCell.h"
@interface OrderProjectWebViewController ()<WKNavigationDelegate,WKScriptMessageHandler, WKUIDelegate>
@property (nonatomic, strong) UIProgressView *myProgressView;

@property (nonatomic, strong) WKWebView *myWebView;
@property (nonatomic, strong) NSDictionary *model;
@end

@implementation OrderProjectWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"项目报告";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.myWebView];
    [self.myWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];;
    [self.view addSubview:self.myProgressView];
    [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/order/report?token=%@&ordno=%@",HostUrl,[UserModel sharedInstance].token,self.urlID]]]];
}
- (void)showBrowserForSimpleCaseWithIndex:(NSInteger)index {
    NSArray *pic = self.model[@"data"][@"pics"];
    NSMutableArray *browserDataArr = [NSMutableArray array];
    for (int i = 0; i<pic.count; i++) {
        YBImageBrowseCellData *data = [YBImageBrowseCellData new];
        data.url = [NSURL URLWithString:pic[i]];
        [browserDataArr addObject:data];
    }
    YBImageBrowser *browser = [YBImageBrowser new];
    browser.dataSourceArray = browserDataArr;
    browser.currentIndex = index;
    [browser show];
}

// 记得取消监听
- (void)dealloc
{
    [self.myWebView removeObserver:self forKeyPath:@"estimatedProgress"];
}

#pragma mark - WKNavigationDelegate method
// 如果不添加这个，那么wkwebview跳转不了AppStore
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    if ([webView.URL.absoluteString hasPrefix:@"https://itunes.apple.com"]) {
        [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
        decisionHandler(WKNavigationActionPolicyCancel);
    }else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}
-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSLog(@"%@",message.body);
//  NSDictionary *dic = [NSDictiona]
    if ([message.name isEqualToString:@"senderModel"]) {
        self.model = [self convertjsonStringToDict:message.body];
        [self showBrowserForSimpleCaseWithIndex:[self.model[@"data"][@"index"] integerValue]];
    }
    
    
}
- (NSDictionary *)convertjsonStringToDict:(NSString *)jsonString{
    
    NSDictionary *retDict = nil;
    if ([jsonString isKindOfClass:[NSString class]]) {
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        retDict = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:NULL];
        return  retDict;
    }else{
        return retDict;
    }
    
}

#pragma mark - event response
// 计算wkWebView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == self.myWebView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        self.myProgressView.alpha = 1.0f;
        [self.myProgressView setProgress:newprogress animated:YES];
        if (newprogress >= 1.0f) {
            [UIView animateWithDuration:0.3f
                                  delay:0.3f
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 self.myProgressView.alpha = 0.0f;
                             }
                             completion:^(BOOL finished) {
                                 [self.myProgressView setProgress:0 animated:NO];
                             }];
        }
        
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - getter and setter
- (UIProgressView *)myProgressView
{
    if (_myProgressView == nil) {
        _myProgressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width, 0)];
        _myProgressView.tintColor = mainColor;
        _myProgressView.trackTintColor = [UIColor whiteColor];
    }
    
    return _myProgressView;
}

- (WKWebView *)myWebView
{
    if(_myWebView == nil)
    {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        config.preferences=[[WKPreferences alloc] init];
        config.preferences.minimumFontSize = 10;
        config.preferences.javaScriptEnabled = YES;
        config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
        config.userContentController = [[WKUserContentController alloc] init];
        config.processPool = [[WKProcessPool alloc] init];
        _myWebView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];
        _myWebView.navigationDelegate = self;
        _myWebView.UIDelegate = self;
        _myWebView.opaque = NO;
        _myWebView.multipleTouchEnabled = YES;
        [_myWebView.configuration.userContentController addScriptMessageHandler:self name:@"senderModel"];
        [_myWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];

    }
    
    return _myWebView;
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
