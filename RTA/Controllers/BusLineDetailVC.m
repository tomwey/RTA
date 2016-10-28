//
//  BusLineDetailVC.m
//  RTA
//
//  Created by tangwei1 on 16/10/28.
//  Copyright © 2016年 tomwey. All rights reserved.
//

#import "BusLineDetailVC.h"
#import "Defines.h"
#import "WalkingView.h"
#import "BusLineView.h"

@interface BusLineDetailVC ()

@property (nonatomic, strong) UIScrollView *buslineContentView;

@end

@implementation BusLineDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBar.title = @"路线详情";
    
    id buslineInfo = self.params[@"busline"];
    
    CGFloat padding = 15;
    
    UILabel *titleLabel = AWCreateLabel(CGRectMake(padding, padding,
                                                   self.contentView.width - padding * 2,
                                                   30),
                                        buslineInfo[@"formated_title"],
                                        NSTextAlignmentLeft,
                                        AWSystemFontWithSize(20, NO),
                                        AWColorFromRGB(57, 57, 57));
    [self.contentView addSubview:titleLabel];
    
    // body
    UILabel *bodyLabel = AWCreateLabel(CGRectMake(padding, titleLabel.bottom + 10,
                                                  titleLabel.width,
                                                  titleLabel.height),
                                       buslineInfo[@"formated_body"],
                                       NSTextAlignmentLeft,
                                       AWSystemFontWithSize(15, NO),
                                       AWColorFromRGB(135, 135, 135));
    [self.contentView addSubview:bodyLabel];
    
    // 线
    AWHairlineView *horizontalLine = [AWHairlineView horizontalLineWithWidth:self.contentView.width
                                                                       color:CONTENT_VIEW_BG_COLOR
                                                                      inView:self.contentView];
    horizontalLine.center = CGPointMake(self.contentView.width / 2, 95);
    
    // 添加路线详情
    [self addBuslineContents];
}

- (void)addBuslineContents
{
    self.buslineContentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 95, self.contentView.width,
                                                                             self.contentView.height - 95)];
    [self.contentView addSubview:self.buslineContentView];
    
    CGFloat top = 10;
    NSArray *segments = self.params[@"busline"][@"segments"];
    for (id seg in segments) {
        id busline = [seg[@"bus"][@"buslines"] firstObject];
        if ( busline ) {
            BusLineView *bView = [[BusLineView alloc] initWithBuslineData:busline];
            [self.buslineContentView addSubview:bView];
            bView.frame = CGRectMake(15, top, self.contentView.width - 30,
                                     150);
            top = bView.bottom;
        }
        
        id walking = seg[@"walking"];
        if ( walking ) {
            WalkingView *wView = [[WalkingView alloc] initWithWalkingData:walking];
            [self.buslineContentView addSubview:wView];
            wView.frame = CGRectMake(15, top + 5, self.contentView.width - 30, 60);
            top = wView.bottom + 5;
        }
    }
    
    self.buslineContentView.contentSize = CGSizeMake(self.contentView.width, top + 10);
}

@end
