//
//  InquireVC.m
//  RTA
//
//  Created by tangwei1 on 16/10/10.
//  Copyright © 2016年 tomwey. All rights reserved.
//

#import "InquireVC.h"
#import "Defines.h"
#import <WebKit/WebKit.h>

@interface InquireVC () <UIWebViewDelegate>

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0

@property (nonatomic, strong) WKWebView *webView;

#else

@property (nonatomic, strong) UIWebView *webView;

#endif

@property (nonatomic, assign) BOOL loadFail;

@end

@implementation InquireVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ( self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil] ) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"换乘"
                                                        image:[UIImage imageNamed:@"inquire.png"]
                                                selectedImage:[UIImage imageNamed:@"inquire_selected.png"]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navBar.title = @"换乘";
    
    [self addLeftBarItemWithView:nil];
    
    self.webView = [[WKWebView alloc] initWithFrame:self.contentView.bounds];//[[UIWebView alloc] initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:self.webView];
    
//    self.webView.scalesPageToFit = YES;
    
//    self.webView.delegate = self;
    
    [self startLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ( self.loadFail ) {
        [self startLoad];
    }
}

- (void)startLoad
{
    [MBProgressHUD showHUDAddedTo:self.contentView animated:YES];
    
    NSURL *pageURL = [NSURL URLWithString:TRANSFER_URL];
    [self.webView loadRequest:[NSURLRequest requestWithURL:pageURL]];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
//    [MBProgressHUD showHUDAddedTo:self.contentView animated:YES];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"request: %@, type: %d", request, navigationType);
    if ( [[[request URL] absoluteString] hasSuffix:@"/search.html"] ) {
        return YES;
    }
    
    WebViewVC *vc = [[WebViewVC alloc] initWithURL:request.URL title:@"换乘列表"];
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
    self.loadFail = YES;
    
    [MBProgressHUD hideHUDForView:self.contentView animated:YES];
}

@end
