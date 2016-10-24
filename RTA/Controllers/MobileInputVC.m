//
//  UserFormVC.m
//  RTA
//
//  Created by tangwei1 on 16/10/24.
//  Copyright © 2016年 tomwey. All rights reserved.
//

#import "MobileInputVC.h"
#import "Defines.h"

@interface MobileInputVC () <UITextFieldDelegate>

@end

@implementation MobileInputVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBar.title = self.params[@"title"];
    
    // 用户输入背景
    UIView *inputBGView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.width - 30, 108)];
    inputBGView.cornerRadius = 8;
    [self.contentView addSubview:inputBGView];
    inputBGView.backgroundColor = [UIColor whiteColor];
    
    inputBGView.layer.borderColor = [IOS_DEFAULT_CELL_SEPARATOR_LINE_COLOR CGColor];
    inputBGView.layer.borderWidth = 0.5;//( 1.0 / [[UIScreen mainScreen] scale] ) / 2;
    
    inputBGView.clipsToBounds = YES;
    
    inputBGView.center = CGPointMake(self.contentView.width / 2, 20 + inputBGView.height / 2);
    
    // 手机
    UITextField *userField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, inputBGView.width - 20, 34)];
    [inputBGView addSubview:userField];
    userField.placeholder = @"手机号";
    userField.keyboardType = UIKeyboardTypeNumberPad;
    
    userField.delegate = self;
    
    // 获取验证码按钮
    AWButton *codeBtn = [AWButton buttonWithTitle:@"获取验证码" color:NAV_BAR_BG_COLOR];
    [inputBGView addSubview:codeBtn];
    codeBtn.frame = CGRectMake(0, 0, 100, 40);
    codeBtn.left = inputBGView.width - 5 - codeBtn.width;
    codeBtn.top  = userField.midY - codeBtn.height / 2;
    
    userField.width -= codeBtn.width;
    
    [codeBtn addTarget:self forAction:@selector(doFetchCode:)];
    
    codeBtn.titleAttributes = @{ NSFontAttributeName: AWSystemFontWithSize(14, NO) };
    
    UIView *hairLine = [[AWHairlineView alloc] initWithLineColor:IOS_DEFAULT_CELL_SEPARATOR_LINE_COLOR];
    [inputBGView addSubview:hairLine];
    hairLine.frame = CGRectMake(-1, inputBGView.height / 2, inputBGView.width + 1, 1);
    
    // 验证码
    UITextField *codeField = [[UITextField alloc] initWithFrame:CGRectMake(10, 54 + 10, inputBGView.width - 20, 34)];
    [inputBGView addSubview:codeField];
    codeField.placeholder = @"验证码";
    codeField.keyboardType = UIKeyboardTypePhonePad;
    codeField.returnKeyType = UIReturnKeyDone;
    
    codeField.delegate = self;
    
    // 确定按钮
    AWButton *okButton = [AWButton buttonWithTitle:@"确定" color:NAV_BAR_BG_COLOR];
    [self.contentView addSubview:okButton];
    okButton.frame = CGRectMake(15, inputBGView.bottom  + 15, inputBGView.width, 50);
    [okButton addTarget:self forAction:@selector(doNext)];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (void)doNext
{
    UIViewController *vc = [[AWMediator sharedInstance] openVCWithName:@"PasswordVC" params:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)doFetchCode:(AWButton *)sender
{
    
}

@end
