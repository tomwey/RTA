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
    
    self.title = @"我的";
    
    self.dataSource = [[NSArray alloc] initWithContentsOfFile:
                       [[NSBundle mainBundle] pathForResource:@"Settings.plist" ofType:nil]];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.contentView.bounds style:UITableViewStyleGrouped];
    [self.contentView addSubview:self.tableView];
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    id obj = self.dataSource[indexPath.section][indexPath.row];
    
    cell.imageView.image = [UIImage imageNamed:[[obj valueForKey:@"icon"] description]];
    cell.textLabel.text  = [[obj valueForKey:@"label"] description];
    cell.textLabel.textColor = AWColorFromRGB(135, 135, 135);
    
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
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@""]];
}

- (void)gotoInvite
{
    
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
    
}

- (void)openQQ
{
    
}

- (void)gotoWechat
{
    
}

- (void)openPhone
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@""]];
}

- (void)gotoVersion
{
    
}

@end
