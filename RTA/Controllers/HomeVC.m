//
//  HomeVC.m
//  RTA
//
//  Created by tangwei1 on 16/10/10.
//  Copyright © 2016年 tomwey. All rights reserved.
//

#import "HomeVC.h"
#import "Defines.h"

@interface HomeVC ()

@property (nonatomic, strong) UILabel *stationNameLabel;
@property (nonatomic, strong) UILabel *stationTipLabel;

@property (nonatomic, copy) NSString *stationId;

@property (nonatomic, strong) UIImageView *stationView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) AWTableViewDataSource *dataSource;

@end
@implementation HomeVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ( self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil] ) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"实时"
                                                        image:[UIImage imageNamed:@"home.png"]
                                                selectedImage:[UIImage imageNamed:@"home_selected.png"]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navBar.title = @"实时";
    
    [self addLeftBarItemWithView:nil];
    
//    UIImageView *bgView = AWCreateImageView(nil);
//    bgView.image = AWImageNoCached(@"home_bg.jpg");
//    bgView.frame = self.contentView.bounds;
//    [self.contentView addSubview:bgView];
//    bgView.contentMode = UIViewContentModeScaleAspectFill;
//    bgView.clipsToBounds = YES;
    
    UIImageView *bg1View = AWCreateImageView(nil);
    bg1View.image = AWImageNoCached(@"home_bg1.png");
    bg1View.frame = CGRectMake(0, 0, self.contentView.width,
                               self.contentView.width * 478 / 1080.0);
    [self.contentView addSubview:bg1View];
    
    UIImageView *bg2View = AWCreateImageView(nil);
    bg2View.image = AWImageNoCached(@"home_bg2.png");
    bg2View.frame = CGRectMake(0, bg1View.bottom,
                               bg1View.width,
                               self.contentView.height - bg1View.height);
    [self.contentView addSubview:bg2View];
    bg2View.contentMode = UIViewContentModeScaleAspectFill;
    bg2View.clipsToBounds = YES;
    
    self.stationView.center = CGPointMake(self.contentView.width / 2, bg1View.bottom - self.stationView.height / 2 - 15);
    
    self.stationTipLabel.hidden = NO;
    
    self.tableView = [[UITableView alloc] initWithFrame:self.contentView.bounds style:UITableViewStylePlain];
    [self.contentView addSubview:self.tableView];
    self.tableView.top = self.stationView.bottom + 15;
    self.tableView.height = self.contentView.height - self.tableView.top;
    
    self.tableView.dataSource = self.dataSource;
    self.tableView.hidden = YES;
    
    self.tableView.rowHeight = 110;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView removeBlankCells];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    
    __weak typeof(self) me = self;
    [self.tableView addRefreshControlWithReloadCallback:^(UIRefreshControl *control) {
        if ( control ) {
            [me startFetchBusForLngAndLat:[[AWLocationManager sharedInstance] formatedCurrentLocation_1]];
        }
    }];
    
    [self startLocation];
}

- (void)startLocation
{
    self.stationNameLabel.text = @"定位中";
    
    [[AWLocationManager sharedInstance] startUpdatingLocation:^(CLLocation *location, NSError *error) {
        if ( error ) {
            NSLog(@"获取位置失败：%@", error);
            self.stationNameLabel.text = @"定位失败";
        } else {
            NSLog(@"%@", location.description);
            [self startFetchStation];
        }
    }];
}

- (void)startFetchStation
{
    NSString *lng_lat = [[AWLocationManager sharedInstance] formatedCurrentLocation_1];
    
    __weak typeof(self) me = self;
    [self.dataService POST:GET_STATION_BY_LNG_AND_LAT
                    params:@{ @"lng": [[lng_lat componentsSeparatedByString:@","] firstObject],
                              @"lat": [[lng_lat componentsSeparatedByString:@","] lastObject] }
                completion:^(id result, NSError *error) {
                    if ( error ) {
                        NSLog(@"获取站点失败：%@", error);
                        self.stationNameLabel.text = @"站点获取失败";
                    } else {
                        me.stationId = result[@"StationID"];
                        me.stationNameLabel.text = [result[@"StationName"] description];
                        [me startFetchBusForLngAndLat:lng_lat];
                    }
                }];
}

- (void)startFetchBusForLngAndLat:(NSString *)lngAndLat
{
    [MBProgressHUD showHUDAddedTo:self.contentView animated:YES];
    
    __weak typeof(self) me = self;
    [self.dataService POST:GET_BUS_LINE_QUERY_RESULT params:@{ @"stationid": self.stationId,
                                                               @"lng": [[lngAndLat componentsSeparatedByString:@","] firstObject],
                                                               @"lat":[[lngAndLat componentsSeparatedByString:@","] lastObject]
                                                               } completion:^(id result, NSError *error) {
                                                                   [MBProgressHUD hideHUDForView:me.contentView animated:YES];
                                                                   [me handleLoadCompletion:result error:error];
                                                               }];
}

- (void)handleLoadCompletion:(id)result error:(NSError *)error
{
    [self.tableView finishLoading];
    
    if ( !error ) {
        self.dataSource.dataSource = result[@"DataList"];
        self.tableView.hidden = NO;
        [self.tableView reloadData];
    }
}

- (UIImageView *)stationView
{
    if ( !_stationView ) {
        _stationView = AWCreateImageView(@"station_bg.png");
        [self.contentView addSubview:_stationView];
    }
    return _stationView;
}

- (UILabel *)stationNameLabel
{
    if ( !_stationNameLabel ) {
        _stationNameLabel = AWCreateLabel(self.stationView.bounds,
                                          nil,
                                          NSTextAlignmentCenter,
                                          AWSystemFontWithSize(20, NO),
                                          AWColorFromRGB(51, 51, 51));
        [self.stationView addSubview:_stationNameLabel];
        _stationNameLabel.height = 30;
    }
    return _stationNameLabel;
}

- (UILabel *)stationTipLabel
{
    if ( !_stationTipLabel ) {
        _stationTipLabel = AWCreateLabel(self.stationView.bounds,
                                          @"离你最近的公交站台",
                                          NSTextAlignmentCenter,
                                          AWSystemFontWithSize(14, NO),
                                          AWColorFromRGB(137, 137, 137));
        [self.stationView addSubview:_stationTipLabel];
        _stationTipLabel.height = 20;
        _stationTipLabel.top = self.stationNameLabel.bottom - 3;
    }
    return _stationTipLabel;
}

- (AWTableViewDataSource *)dataSource
{
    if ( !_dataSource ) {
        _dataSource = AWTableViewDataSourceCreate(nil, @"BusCell", @"cell.id");
        
        __weak typeof(self) me = self;
        _dataSource.itemDidSelectBlock = ^(UIView<AWTableDataConfig> *sender, id selectedData) {
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?stationid=%@&lineno=%@&lineType=%@",
                                               LINE_DETAIL_URL,
                                               [selectedData valueForKey:@"StationID"],
                                               [[[selectedData valueForKey:@"BusLine"] description] URLEncode],
                                               [selectedData valueForKey:@"LineType"]]];
            WebViewVC *page = [[WebViewVC alloc] initWithURL:url title:@"路线详情"];
            [me.tabBarController.navigationController pushViewController:page animated:YES];
        };
    }
    return _dataSource;
}

@end
