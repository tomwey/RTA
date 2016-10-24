//
//  InviteVC.m
//  RTA
//
//  Created by tangwei1 on 16/10/24.
//  Copyright © 2016年 tomwey. All rights reserved.
//

#import "InviteVC.h"
#import "Defines.h"

@interface InviteVC ()

@end

@implementation InviteVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navBar.title = @"邀请好友";
    
    self.contentView.backgroundColor = AWColorFromRGB(251, 251, 251);
    
    UIImageView *wxView = AWCreateImageView(@"wechat.png");
    [self.contentView addSubview:wxView];
    
    wxView.center = CGPointMake(self.contentView.width / 2, 30 + wxView.height / 2);
    
    UILabel *tipLabel = AWCreateLabel(CGRectMake(0, wxView.bottom + 20,
                                                 self.contentView.width,
                                                 34),
                                      @"扫描二维码下载客户端, 我的公交出行必备～",
                                      NSTextAlignmentCenter,
                                      AWSystemFontWithSize(14, NO),
                                      AWColorFromRGB(201, 201, 201));
    [self.contentView addSubview:tipLabel];
    
    UILabel *inviteLabel = AWCreateLabel(CGRectMake(0, 0, 50, 34),
                                         @"邀请",
                                         NSTextAlignmentCenter,
                                         nil,
                                         tipLabel.textColor);
    [self.contentView addSubview:inviteLabel];
    inviteLabel.backgroundColor = self.contentView.backgroundColor;
    
    inviteLabel.center = CGPointMake(self.contentView.width / 2, tipLabel.bottom + 10 + inviteLabel.height / 2);
    
    CGFloat width = ( self.contentView.width - inviteLabel.width ) / 2 + 2;
    
    UIView *line1 = [[AWHairlineView alloc] initWithLineColor:tipLabel.textColor];
    [self.contentView addSubview:line1];
    line1.frame = CGRectMake(0, 0, width + 1, 1);
    line1.center = CGPointMake(line1.width / 2 - 1, inviteLabel.midY);
    
    UIView *line2 = [[AWHairlineView alloc] initWithLineColor:tipLabel.textColor];
    [self.contentView addSubview:line2];
    line2.frame = CGRectMake(0, 0, width + 1, 1);
    line2.center = CGPointMake(line2.width / 2 + inviteLabel.right - 1, inviteLabel.midY);
    
    [self.contentView bringSubviewToFront:inviteLabel];
    
    // 4个分享按钮
    NSArray *names = @[@"btn_wx.png", @"btn_friends.png", @"btn_qq.png", @"btn_message.png"];
    CGFloat padding = 10;
    
    for (int i = 0; i < names.count; i++) {
        UIButton *btn = AWCreateImageButton(names[i], self, @selector(btnClicked:));
        [self.contentView addSubview:btn];
        
        static CGFloat left;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            CGFloat width = btn.width;
            left = ( self.contentView.width - width * names.count - padding * ( names.count - 1) ) / 2;
        });
        
        btn.center = CGPointMake(left + btn.width / 2 + ( btn.width + padding ) * i,
                                 inviteLabel.bottom + 10 + btn.height / 2);
        
        btn.tag = 100 + i;
    }
    
    self.contentView.userInteractionEnabled = YES;
}

- (void)btnClicked:(UIButton *)sender
{
    switch (sender.tag) {
        case 100:
        {
            [self shareToWX];
        }
            break;
        case 101:
        {
            [self shareToFriends];
        }
            break;
        case 102:
        {
            [self shareToQQ];
        }
            break;
        case 103:
        {
            [self shareToMessage];
        }
            break;
            
        default:
            break;
    }
}

- (void)shareToWX
{
    NSLog(@"1234");
}

- (void)shareToFriends
{
    NSLog(@"1234");
}

- (void)shareToQQ
{
    NSLog(@"1234");
}

- (void)shareToMessage
{
    NSLog(@"1234");
}

@end
