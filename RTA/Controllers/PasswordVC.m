//
//  PasswordVC.m
//  RTA
//
//  Created by tangwei1 on 16/10/24.
//  Copyright © 2016年 tomwey. All rights reserved.
//

#import "PasswordVC.h"
#import "Defines.h"

@interface PasswordVC () <UITextFieldDelegate>

@end

@implementation PasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBar.title = @"设置密码";
    
    // 用户输入背景
    UIView *inputBGView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.width - 30, 108)];
    inputBGView.cornerRadius = 8;
    [self.contentView addSubview:inputBGView];
    inputBGView.backgroundColor = [UIColor whiteColor];
    
    inputBGView.layer.borderColor = [IOS_DEFAULT_CELL_SEPARATOR_LINE_COLOR CGColor];
    inputBGView.layer.borderWidth = 0.5;//( 1.0 / [[UIScreen mainScreen] scale] ) / 2;
    
    inputBGView.clipsToBounds = YES;
    
    inputBGView.center = CGPointMake(self.contentView.width / 2, 20 + inputBGView.height / 2);
    
    // 密码
    UITextField *userField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, inputBGView.width - 20, 34)];
    [inputBGView addSubview:userField];
    userField.placeholder = @"输入密码";
    userField.secureTextEntry = YES;
    userField.delegate = self;
    
    UIView *hairLine = [[AWHairlineView alloc] initWithLineColor:IOS_DEFAULT_CELL_SEPARATOR_LINE_COLOR];
    [inputBGView addSubview:hairLine];
    hairLine.frame = CGRectMake(-1, inputBGView.height / 2, inputBGView.width + 1, 1);
    
    // 确认密码
    UITextField *codeField = [[UITextField alloc] initWithFrame:CGRectMake(10, 54 + 10, inputBGView.width - 20, 34)];
    [inputBGView addSubview:codeField];
    codeField.placeholder = @"确认密码";
    codeField.returnKeyType = UIReturnKeyDone;
    codeField.secureTextEntry = YES;
    codeField.delegate = self;
    
    // 确定按钮
    AWButton *okButton = [AWButton buttonWithTitle:@"完成" color:NAV_BAR_BG_COLOR];
    [self.contentView addSubview:okButton];
    okButton.frame = CGRectMake(15, inputBGView.bottom  + 15, inputBGView.width, 50);
    [okButton addTarget:self forAction:@selector(done)];

}

- (void)back
{
    for (UIViewController *vc in [self.navigationController viewControllers]) {
        if ( [NSStringFromClass([vc class]) isEqualToString:@"LoginVC"] ) {
            [self.navigationController popToViewController:vc animated:YES];
            break;
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (void)done
{
    
}

@end
