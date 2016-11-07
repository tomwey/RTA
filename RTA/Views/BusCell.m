//
//  BusCell.m
//  RTA
//
//  Created by tangwei1 on 16/10/25.
//  Copyright © 2016年 tomwey. All rights reserved.
//

#import "BusCell.h"
#import "Defines.h"

@interface BusCell ()

@property (nonatomic, strong) UIView *containerView;

// 公交线路
@property (nonatomic, strong) UILabel *busLineLabel;

// 当前行驶到站点名称
@property (nonatomic, strong) UILabel *currentStationLabel;

// 垂直分割线
@property (nonatomic, strong) AWHairlineView *lineView;

// 距离
@property (nonatomic, strong) UILabel *distanceLabel;

// 终点站
@property (nonatomic, strong) UILabel *endStationLabel;

// 剩余站数
@property (nonatomic, strong) UILabel *leftStationLabel;

@property (nonatomic, strong) id selectedData;

@property (nonatomic, copy) void (^didSelectBlock)(UIView<AWTableDataConfig> *sender, id selectedData);

@end
@implementation BusCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ( self = [super initWithStyle:style reuseIdentifier:reuseIdentifier] ) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)configData:(id)data selectBlock:(void (^)(UIView<AWTableDataConfig> *sender, id selectedData))selectBlock
{
    NSLog(@"data: %@", data);
//    BusLine = 11;
//    Distaince = "1179.1km";
//    EndStation = "\U65b0\U534e\U8def";
//    LineType = 0;
//    OverplusCount = 100;
//    StationID = S0252;
//    StationName = "\U5ed6\U5bb6\U6e7e";
//    Surplus = 0;
//    ss = 0;
    
    self.selectedData = data;
    
    self.didSelectBlock = selectBlock;
    
    NSString *string = [NSString stringWithFormat:@"%@路", [[[data valueForKey:@"BusLine"] description] trim]];
    NSMutableAttributedString *attrText = [[NSMutableAttributedString alloc] initWithString:string];
    [attrText addAttributes:@{ NSFontAttributeName: AWSystemFontWithSize(BUS_LIST_FONT_SMALL, NO),
                               NSForegroundColorAttributeName: BUS_LIST_TITLE_GRAY_COLOR }
                      range:NSMakeRange(string.length - 1, 1)];
    self.busLineLabel.attributedText = attrText;
    
    self.currentStationLabel.text = [data valueForKey:@"StationName"];
    
    self.distanceLabel.text = [data valueForKey:@"Distaince"];
    
    
    string = [NSString stringWithFormat:@"开往 %@", [data valueForKey:@"EndStation"]];
    attrText = [[NSMutableAttributedString alloc] initWithString:string];
    [attrText addAttributes:@{
                              NSFontAttributeName: AWSystemFontWithSize(BUS_LIST_FONT_SMALL, NO),
                              NSForegroundColorAttributeName: BUS_LIST_TITLE_GRAY_COLOR
                              } range:NSMakeRange(0, 2)];
    self.endStationLabel.attributedText = attrText;
    
    NSInteger leftCount = [[data valueForKey:@"OverplusCount"] integerValue];
    if ( leftCount > 99 ) {
        // 未出站
        attrText = [[NSMutableAttributedString alloc] initWithString:@"未出站"];
        [attrText addAttributes:@{ NSFontAttributeName: AWSystemFontWithSize(BUS_LIST_FONT_SMALL, NO),
                                   NSForegroundColorAttributeName: BUS_LIST_TITLE_GRAY_COLOR }
                          range:NSMakeRange(0, 3)];
    } else if ( leftCount == 0 ) {
        // 已到站
        attrText = [[NSMutableAttributedString alloc] initWithString:@"已到站"];
        [attrText addAttributes:@{ NSFontAttributeName: AWSystemFontWithSize(BUS_LIST_FONT_SMALL, NO),
                                   NSForegroundColorAttributeName: BUS_LIST_TITLE_GRAY_COLOR }
                          range:NSMakeRange(0, 3)];
    } else {
        //
        string = [NSString stringWithFormat:@"%d站", leftCount];
        attrText = [[NSMutableAttributedString alloc] initWithString:string];
        [attrText addAttributes:@{ NSFontAttributeName: AWSystemFontWithSize(BUS_LIST_FONT_SMALL, NO),
                                   NSForegroundColorAttributeName: BUS_LIST_TITLE_GRAY_COLOR }
                          range:NSMakeRange(string.length - 1, 1)];
    }
    self.leftStationLabel.attributedText = attrText;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat left = 15;
    self.containerView.frame = CGRectMake(left, 0, self.width - left * 2, self.height - left);
    
    self.busLineLabel.frame = CGRectMake(10, 5, self.containerView.width / 2, 37);
    
    [self.distanceLabel sizeToFit];
    self.distanceLabel.position = CGPointMake(self.containerView.width - self.busLineLabel.left - self.distanceLabel.width,
                                              self.busLineLabel.midY - self.distanceLabel.height / 2);
    
    self.lineView.center = CGPointMake(self.distanceLabel.left - 3, self.distanceLabel.midY);
    
    [self.currentStationLabel sizeToFit];
    self.currentStationLabel.center = CGPointMake(self.lineView.left - 4 - self.currentStationLabel.width / 2, self.lineView.midY);
    
    self.endStationLabel.frame = self.busLineLabel.frame;
    self.endStationLabel.width = self.containerView.width * 0.6;
    self.endStationLabel.top   = self.containerView.height - self.busLineLabel.top - self.endStationLabel.height;
    
    self.leftStationLabel.frame = CGRectMake(0,
                                             0,
                                             self.containerView.width * 0.4 - 10,
                                             34);
    self.leftStationLabel.center = CGPointMake(self.containerView.width - 10 - self.leftStationLabel.width / 2,
                                               self.endStationLabel.midY);
}

- (void)tap
{
    if ( self.didSelectBlock ) {
        self.didSelectBlock(self, self.selectedData);
    }
}

- (UIView *)containerView
{
    if ( !_containerView ) {
        _containerView = [[UIView alloc] init];
        [self.contentView addSubview:_containerView];
        _containerView.backgroundColor = [UIColor whiteColor];
        _containerView.layer.cornerRadius = 2;
        _containerView.layer.borderColor = [BUS_LIST_CONTAINER_BORDER_GRAY_COLOR CGColor];
        _containerView.layer.borderWidth = 0.5;
        
        _containerView.clipsToBounds = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [_containerView addGestureRecognizer:tap];
    }
    return _containerView;
}

- (UILabel *)busLineLabel
{
    if ( !_busLineLabel ) {
        _busLineLabel = AWCreateLabel(CGRectZero,
                                      nil,
                                      NSTextAlignmentLeft,
                                      AWSystemFontWithSize(22, NO),
                                      BUS_LIST_TITLE_BLACK_COLOR);
        [self.containerView addSubview:_busLineLabel];
    }
    return _busLineLabel;
}

- (UILabel *)currentStationLabel
{
    if ( !_currentStationLabel ) {
        _currentStationLabel = AWCreateLabel(CGRectZero,
                                      nil,
                                      NSTextAlignmentRight,
                                      AWSystemFontWithSize(16, YES),
                                      AWColorFromRGB(79, 150, 214));
        [self.containerView addSubview:_currentStationLabel];
    }
    return _currentStationLabel;
}

- (UILabel *)distanceLabel
{
    if ( !_distanceLabel ) {
        _distanceLabel = AWCreateLabel(CGRectZero,
                                             nil,
                                             NSTextAlignmentRight,
                                             AWSystemFontWithSize(BUS_LIST_FONT_SMALL, NO),
                                             AWColorFromRGB(252, 111, 10));
        [self.containerView addSubview:_distanceLabel];
    }
    return _distanceLabel;
}

- (UILabel *)endStationLabel
{
    if ( !_endStationLabel ) {
        _endStationLabel = AWCreateLabel(CGRectZero,
                                       nil,
                                       NSTextAlignmentLeft,
                                       AWSystemFontWithSize(16, NO),
                                       AWColorFromRGB(135, 135, 135));
        [self.containerView addSubview:_endStationLabel];
    }
    return _endStationLabel;
}

- (UILabel *)leftStationLabel
{
    if ( !_leftStationLabel ) {
        _leftStationLabel = AWCreateLabel(CGRectZero,
                                         nil,
                                         NSTextAlignmentRight,
                                         AWSystemFontWithSize(20, NO),
                                         BUS_LIST_TITLE_BLACK_COLOR);
        [self.containerView addSubview:_leftStationLabel];
    }
    return _leftStationLabel;
}

- (AWHairlineView *)lineView
{
    if ( !_lineView ) {
        _lineView = [AWHairlineView verticalLineWithHeight:15
                                                     color:AWColorFromRGB(134, 134, 134)
                                                    inView:self.containerView];
    }
    return _lineView;
}

@end
