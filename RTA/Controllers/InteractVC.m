//
//  InteractVC.m
//  RTA
//
//  Created by tangwei1 on 16/10/10.
//  Copyright © 2016年 tomwey. All rights reserved.
//

#import "InteractVC.h"
#import "Defines.h"
#import <WebKit/WebKit.h>

@interface InteractVC () <UIWebViewDelegate, WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, assign) BOOL loadFail;

@end
@implementation InteractVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ( self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil] ) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"广场"
                                                        image:[UIImage imageNamed:@"interact.png"]
                                                selectedImage:[UIImage imageNamed:@"interact_selected.png"]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navBar.title = @"广场";
    
    [self addLeftBarItemWithView:nil];
    
//    self.webView = [[UIWebView alloc] initWithFrame:self.contentView.bounds];
//    [self.contentView addSubview:self.webView];
//    
//    self.webView.scalesPageToFit = YES;
//    
//    self.webView.delegate = self;
//    
//    self.webView.scrollView.showsVerticalScrollIndicator = YES;
    
    self.webView = [[WKWebView alloc] initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:self.webView];
    self.webView.navigationDelegate = self;
    
    [self.webView addObserver:self
                   forKeyPath:@"loading"
                      options:NSKeyValueObservingOptionNew
                      context:NULL];
    
    [self startLoad];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ( self.webView.isLoading ) {
        
    } else {
        [MBProgressHUD hideAllHUDsForView:self.contentView animated:YES];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ( self.loadFail ) {
        [self startLoad];
    }
    
//    self.webView.scrollView.contentInset = UIEdgeInsetsZero;
}

- (void)startLoad
{
    [MBProgressHUD showHUDAddedTo:self.contentView animated:YES];
    
    NSURL *pageURL = [NSURL URLWithString:SQUARE_LIST_URL];
    [self.webView loadRequest:[NSURLRequest requestWithURL:pageURL]];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    if ( [[navigationAction.request.URL absoluteString] isEqualToString:SQUARE_LIST_URL] ) {
        decisionHandler(WKNavigationActionPolicyAllow);
    } else {
        decisionHandler(WKNavigationActionPolicyCancel);
        
        WebViewVC *vc = [[WebViewVC alloc] initWithURL:navigationAction.request.URL title:@"详情"];
        [self.tabBarController.navigationController pushViewController:vc animated:YES];
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"request: %@, type: %d", request, navigationType);
    if ( [[[request URL] absoluteString] isEqualToString:SQUARE_LIST_URL] ) {
        return YES;
    }
    
    WebViewVC *vc = [[WebViewVC alloc] initWithURL:request.URL title:@"详情"];
    [self.tabBarController.navigationController pushViewController:vc animated:YES];
    
    return NO;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //    [self finishLoading:LoadingStateSuccessResult];
    [MBProgressHUD hideHUDForView:self.contentView animated:YES];
    
    self.loadFail = NO;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{
    //    [self finishLoading:LoadingStateFail];
    [MBProgressHUD hideHUDForView:self.contentView animated:YES];
    
    self.loadFail = YES;
}

@end
