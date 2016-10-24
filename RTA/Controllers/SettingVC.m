//
//  SettingVC.m
//  RTA
//
//  Created by tangwei1 on 16/10/10.
//  Copyright © 2016年 tomwey. All rights reserved.
//

#import "SettingVC.h"
#import "Defines.h"

@interface SettingVC () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, weak)   SettingTableHeader *tableHeader;

@end
@implementation SettingVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ( self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil] ) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的"
                                                        image:[UIImage imageNamed:@"mine.png"]
                                                selectedImage:[UIImage imageNamed:@"mine_selected.png"]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataSource = [[NSArray alloc] initWithContentsOfFile:
                       [[NSBundle mainBundle] pathForResource:@"Settings.plist" ofType:nil]];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.height -= 49;
    self.tableView.dataSource = self;
    self.tableView.delegate   = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.rowHeight = 50;
    
    self.tableView.tableHeaderView = [[SettingTableHeader alloc] init];
    self.tableHeader = (SettingTableHeader *)self.tableView.tableHeaderView;
    
    __weak typeof(self) me = self;
    self.tableHeader.didSelectCallback = ^(SettingTableHeader *sender) {
        [me gotoUserProfile];
    };
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cell.id";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if ( !cell ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    id obj = self.dataSource[indexPath.section][indexPath.row];
    
    if ( ![obj valueForKey:@"action"] ) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.imageView.image = [UIImage imageNamed:[[obj valueForKey:@"icon"] description]];
    cell.textLabel.text  = [[obj valueForKey:@"label"] description];
    cell.textLabel.textColor = AWColorFromRGB(135, 135, 135);
    
    cell.detailTextLabel.text = [obj valueForKey:@"value"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    id obj = self.dataSource[indexPath.section][indexPath.row];
    NSString *action = [[obj valueForKey:@"action"] description];
    
    SEL selector = NSSelectorFromString(action);
    if ( [self respondsToSelector:selector] ) {
        [self performSelector:selector withObject:nil];
    }
}

- (void)gotoUserProfile
{
    
}

- (void)openNFC
{
    NSURL *nfcAppURL = [NSURL URLWithString:NFC_APP_URL];
    if ( [[UIApplication sharedApplication] canOpenURL:nfcAppURL] ) {
        [[UIApplication sharedApplication] openURL:nfcAppURL];
    } else {
        [self showAlertWithTitle:@"提示" message:@"您还未安装该应用"];
    }
}

- (void)gotoInvite
{
    UIViewController *vc = [[AWMediator sharedInstance] openVCWithName:@"InviteVC" params:nil];
    [AWAppWindow().navController pushViewController:vc animated:YES];
}

- (void)clearCache
{
    [[MBProgressHUD showHUDAddedTo:self.contentView animated:YES] setLabelText:@"缓存清除中..."];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.contentView animated:YES];
        });
    });
}

- (void)gotoFeedback
{
    WebViewVC *page = [[WebViewVC alloc] initWithURL:[NSURL URLWithString:FEEDBACK_URL] title:@"意见反馈"];
    [AWAppWindow().navController pushViewController:page animated:YES];
}

- (void)openQQ
{
    AWAppOpenQQ(OFFICIAL_QQ);
}

- (void)gotoWechat
{
    WebViewVC *page = [[WebViewVC alloc] initWithURL:[NSURL URLWithString:OFFICIAL_WECHAT_URL] title:@"官方微信"];
    [AWAppWindow().navController pushViewController:page animated:YES];
}

- (void)openPhone
{
    NSString *phone = [NSString stringWithFormat:@"tel:%@", OFFICIAL_TELPHONE];
    NSURL *phoneURL = [NSURL URLWithString:phone];
    
    if ( [[UIApplication sharedApplication] canOpenURL:phoneURL] ) {
        [[UIApplication sharedApplication] openURL:phoneURL];
    } else {
        [self showAlertWithTitle:@"提示" message:@"您的设备不支持打电话功能"];
    }
}

- (void)gotoVersion
{
    
}

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message
{
    [[[UIAlertView alloc] initWithTitle:title
                                message:message
                               delegate:nil
                      cancelButtonTitle:nil
                      otherButtonTitles:@"确定",nil] show];
}

@end
