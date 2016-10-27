//
//  LocationSearchVC.m
//  RTA
//
//  Created by tomwey on 10/27/16.
//  Copyright © 2016 tomwey. All rights reserved.
//

#import "LocationSearchVC.h"
#import "Defines.h"
#import "LocationService.h"

@interface LocationSearchVC () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, weak) UIView *searchBg;

@property (nonatomic, copy) NSArray *dataSource;

@property (nonatomic, strong) LocationService *locationService;

@end
@implementation LocationSearchVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navBar.title = @"搜索";
    
    self.contentView.backgroundColor = AWColorFromRGB(239,239,239);
    
    // 搜索
    UIView *searchBg = [[UIView alloc] initWithFrame:CGRectMake(10, 10, self.contentView.width - 20, 50)];
    [self.contentView addSubview:searchBg];
    searchBg.cornerRadius = 6;
    searchBg.backgroundColor = [UIColor whiteColor];
    
    self.searchBg = searchBg;
    
    UIImageView *iconView = AWCreateImageView(@"icon_search.png");
    [searchBg addSubview:iconView];
    iconView.center = CGPointMake(10 + iconView.width / 2,
                                  searchBg.height / 2);
    
    CGRect frame = CGRectMake(iconView.right + 10,
                              5,
                              searchBg.width - iconView.right - 10 - 10,
                              40);
    UITextField *searchInput = [[UITextField alloc] initWithFrame:frame];
    [searchBg addSubview:searchInput];
    searchInput.placeholder = @"输入地址";
    searchInput.autocorrectionType = UITextAutocorrectionTypeNo;
    
    [searchInput addTarget:self action:@selector(doSearch:)
          forControlEvents:UIControlEventEditingChanged];
}

- (void)doSearch:(UITextField *)sender
{
    if ( sender.text.trim.length == 0 ) {
        self.dataSource = @[];
        self.tableView.hidden = YES;
    } else {
        if ( !self.locationService ) {
            self.locationService = [[LocationService alloc] init];
        }
        
        [self.locationService POISearch:sender.text.trim boundary:@"哈密" completion:^(NSArray *locations, NSError *aError) {
//            NSLog(@"result: %@", locations);
            self.dataSource = locations;
            if ( [self.dataSource count] > 0 ) {
                self.tableView.hidden = NO;
                [self.tableView reloadData];
            } else {
                self.tableView.hidden = YES;
            }
        }];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell.id"];
    if ( !cell ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell.id"];
    }
    
    cell.textLabel.text = [self.dataSource[indexPath.row] valueForKey:@"title"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    id info = self.dataSource[indexPath.row];
    
    if (self.params[@"selectBlock"]) {
        ((void (^)(id info))self.params[@"selectBlock"])(info);
    }
    
    [self.navigationController popViewControllerAnimated:YES];    
}

- (UITableView *)tableView
{
    if ( !_tableView ) {
        CGRect frame = CGRectMake(self.searchBg.left,
                                  self.searchBg.bottom + 10,
                                  self.searchBg.width,
                                  self.contentView.height - 264 - self.searchBg.bottom - 20);
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        [self.contentView addSubview:_tableView];
        _tableView.cornerRadius = 6;
        
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        [_tableView removeBlankCells];
        
        [_tableView removeCompatibility];
        
        _tableView.rowHeight = 50;
    }
    return _tableView;
}

@end
