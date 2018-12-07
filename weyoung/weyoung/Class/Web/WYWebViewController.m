//
//  WYWebViewController.m
//  weyoung
//
//  Created by gongxin on 2018/12/7.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYWebViewController.h"
#import <NJKWebViewProgress.h>
#import <NJKWebViewProgressView.h>
@interface WYWebViewController ()
<UIWebViewDelegate, NJKWebViewProgressDelegate>

@property(nonatomic,strong)NJKWebViewProgressView *webViewProgressView;
@property(nonatomic,strong)NJKWebViewProgress *webViewProgress;
@property(nonatomic,strong)UIWebView * webView;


@end

@implementation WYWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.webViewProgressView];
    [self.view addSubview:self.webView];
}

-(NJKWebViewProgressView*)webViewProgressView
{
    if (!_webViewProgressView) {
        _webViewProgressView = [[NJKWebViewProgressView alloc] initWithFrame:CGRectMake(0, KNaviBarHeight, KScreenWidth, 2)];
        _webViewProgressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        [_webViewProgressView setProgress:0 animated:YES];
    }
    return _webViewProgressView;
}

-(NJKWebViewProgress*)webViewProgress
{
    if (!_webViewProgress) {
        _webViewProgress = [[NJKWebViewProgress alloc] init];
        _webView.delegate = _webViewProgress;
        _webViewProgress.webViewProxyDelegate = self;
        _webViewProgress.progressDelegate = self;
    }
    return _webViewProgress;
}


-(UIWebView*)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, KNaviBarHeight, KScreenWidth, KScreenHeight-KNaviBarHeight)];
        _webView.backgroundColor = [UIColor binaryColor:@"FAFAFA"];
        _webView.delegate = self;
        _webView.opaque  = NO;
        _webView.tag = 1;
        _webView.scalesPageToFit = YES;
        _webView.autoresizesSubviews = YES;
        
    }
    return _webView;
}



-(void)setUrl:(NSString *)url
{
    _url = url;
    [self loadWeb];
}

-(void)loadWeb
{
 
    NSString *urlstr  = self.url;

    if (urlstr && [urlstr length]) {
        NSURL *url;
        if ([urlstr hasPrefix:@"http://"] || [urlstr hasPrefix:@"https://"] ) {
            url = [NSURL URLWithString:[urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        }
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        [_webView loadRequest:request];
    }

    
}

#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    
    NSLog(@"网络加载进度 %f",progress);
    [_webViewProgressView setProgress:progress animated:YES];
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView;
{
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView;
{
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;
{
    
}


@end
