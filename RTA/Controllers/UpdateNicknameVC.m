//
//  UpdateNicknameVC.m
//  RTA
//
//  Created by tangwei1 on 16/10/24.
//  Copyright © 2016年 tomwey. All rights reserved.
//

#import "UpdateNicknameVC.h"
#import "Defines.h"

@interface UpdateNicknameVC ()

@end

@implementation UpdateNicknameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navBar.title = @"设置昵称";
    
    AWTextField *textField = [[AWTextField alloc] initWithFrame:CGRectMake(15, 15,
                                                                           self.contentView.width - 30,
                                                                           37)];
    [self.contentView addSubview:textField];
    
    textField.text = [[[UserService sharedInstance] currentUser] name] ?:
                     [[[UserService sharedInstance] currentUser] mobile];
    
    AWButton *saveBtn = [AWButton buttonWithTitle:@"保存" color:NAV_BAR_BG_COLOR];
    saveBtn.frame = textField.frame;
    saveBtn.height = 44;
    saveBtn.top = textField.bottom + 20;
    
    [self.contentView addSubview:saveBtn];
    
    [saveBtn addTarget:self forAction:@selector(save)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)save
{
    
}

@end
