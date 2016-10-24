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

@interface InteractVC () <WKNavigationDelegate>

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

- (void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"loading"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navBar.title = @"广场";
    
    [self addLeftBarItemWithView:nil];
    
    self.webView = [[WKWebView alloc] initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:self.webView];
    self.webView.navigationDelegate = self;
    
    self.webView.scrollView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    
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

@end
