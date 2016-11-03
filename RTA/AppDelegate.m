//
//  AppDelegate.m
//  RTA
//
//  Created by tangwei1 on 16/10/10.
//  Copyright © 2016年 tomwey. All rights reserved.
//

#import "AppDelegate.h"
#import "Defines.h"
#import "UMMobClick/MobClick.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "WXApi.h"
#import "AFNetworkReachabilityManager.h"

@interface AppDelegate () <WXApiDelegate>

@end

@implementation AppDelegate

// 和share sdk冲突
//+ (void)load
//{
//    // 设置缓存大小
//    NSURLCache *urlCache = [[NSURLCache alloc] initWithMemoryCapacity:20 * 1024 * 1024
//                                                         diskCapacity:100 * 1024 * 1024
//                                                             diskPath:@"Images"];
//    [NSURLCache setSharedURLCache:urlCache];
//
//    // 导航条
////    [[UINavigationBar appearance] setBackgroundImage:AWImageFromColor(NAV_BAR_BG_COLOR)
////                                       forBarMetrics:UIBarMetricsDefault];
////    [[UINavigationBar appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];
//}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    // 设置缓存大小
    NSURLCache *urlCache = [[NSURLCache alloc] initWithMemoryCapacity:20 * 1024 * 1024
                                                         diskCapacity:100 * 1024 * 1024
                                                             diskPath:@"Images"];
    [NSURLCache setSharedURLCache:urlCache];

    // 状态条
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if ( AFNetworkReachabilityStatusNotReachable == status ) {
            [self.window makeToast:@"网络已经断开" duration:2.0 position:CSToastPositionTop];
        } else {
            
        }
    }];
    
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    
    UITabBarController *tabBar = [[UITabBarController alloc] init];
    
    UIViewController *homeVC = [UIViewController createControllerWithName:@"HomeVC"];
    UIViewController *inquireVC = [UIViewController createControllerWithName:@"InquireVC"];
    UIViewController *interactVC = [UIViewController createControllerWithName:@"InteractVC"];
    UIViewController *settingVC = [UIViewController createControllerWithName:@"SettingVC"];
    
    tabBar.viewControllers = @[homeVC, inquireVC, interactVC, settingVC];
    
    tabBar.selectedIndex = 0;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:tabBar];
    nav.navigationBarHidden = YES;
    
    self.window.rootViewController = nav;
    
    [self.window makeKeyAndVisible];
    
    [[VersionCheckService sharedInstance] startCheckWithSilent:YES];
    
    // 友盟统计
    UMConfigInstance.appKey = UMENG_KEY;
    UMConfigInstance.channelId = @"App Store";
    [MobClick startWithConfigure:UMConfigInstance];
    
    // 初始化分享SDK
    [self initShareSDK];
    
    return YES;
}

- (void)initShareSDK
{
    [ShareSDK registerApp:@"185a719e32d25"
          activePlatforms:@[@(SSDKPlatformTypeQQ), @(SSDKPlatformTypeWechat)]
                 onImport:^(SSDKPlatformType platformType) {
                     //
                     switch (platformType) {
                         case SSDKPlatformTypeQQ:
                         {
                             [ShareSDKConnector connectQQ:[QQApiInterface class]
                                        tencentOAuthClass:[TencentOAuth class]];
                         }
                             break;
                         case SSDKPlatformTypeWechat:
                         {
                             [ShareSDKConnector connectWeChat:[WXApi class] delegate:self];
                         }
                             break;
                             
                         default:
                             break;
                     }
                 } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
                     switch (platformType) {
                         case SSDKPlatformTypeWechat:
                         {
                             [appInfo SSDKSetupWeChatByAppId:WX_APP_ID appSecret:WX_APP_SECRET];
                         }
                             break;
                         case SSDKPlatformTypeQQ:
                         {
                             [appInfo SSDKSetupQQByAppId:QQ_APP_ID appKey:QQ_APP_SECRET authType:SSDKAuthTypeBoth];
                         }
                             break;
                             
                         default:
                             break;
                     }
                 }];
}

-(void)onResp:(BaseResp *)resp
{
    NSLog(@"The response of wechat.");
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

@implementation UIWindow (NavBar)

- (UINavigationController *)navController
{
    return (UINavigationController *)self.rootViewController;
}

@end
