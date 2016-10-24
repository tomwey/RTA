//
//  UserVC.m
//  RTA
//
//  Created by tangwei1 on 16/10/24.
//  Copyright © 2016年 tomwey. All rights reserved.
//

#import "UserVC.h"
#import "Defines.h"

@interface UserVC () <UITableViewDataSource,
UITableViewDelegate,
UIActionSheetDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) User *user;

@property (nonatomic, strong) UIImagePickerController *imagePickerController;

@property (nonatomic, weak) UIImageView *avatarView;

@end

@implementation UserVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navBar.title = @"用户信息";
    
    self.tableView = [[UITableView alloc] initWithFrame:self.contentView.bounds style:UITableViewStylePlain];
    [self.contentView addSubview:self.tableView];
    
    self.tableView.dataSource = self;
    self.tableView.delegate   = self;
    
    self.tableView.rowHeight  = 60;
    
    [self.tableView removeBlankCells];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.user = [[UserService sharedInstance] currentUser];
    
    [self.tableView reloadData];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell.id"];
    if ( !cell ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell.id"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if ( indexPath.row == 0 ) {
        cell.textLabel.text = @"头像";
        UIImageView *avatarView = (UIImageView *)[cell.contentView viewWithTag:1011];
        if ( !avatarView ) {
            avatarView = AWCreateImageView(nil);
            avatarView.frame = CGRectMake(0, 0, 48, 48);
            [cell.contentView addSubview:avatarView];
            avatarView.tag = 1011;
            
            avatarView.cornerRadius = avatarView.height / 2;
            
            avatarView.center = CGPointMake(self.contentView.width - 20 - 15 - avatarView.width / 2,
                                            self.tableView.rowHeight / 2 );
        }
        
        [avatarView setImageWithURL:[NSURL URLWithString:self.user.avatar] placeholderImage:[UIImage imageNamed:@"default_avatar.png"]];
        
        self.avatarView = avatarView;
    } else if ( indexPath.row == 1 ) {
        cell.textLabel.text = @"用户名";
        cell.detailTextLabel.text = [self.user formatUsername];
    } else if ( indexPath.row == 2 ) {
        cell.textLabel.text = @"性别";
        cell.detailTextLabel.text = [self.user formatSex];
    } else if ( indexPath.row == 3 ) {
        cell.textLabel.text = @"生日";
        cell.detailTextLabel.text = [self.user formatBirth];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ( indexPath.row == 0 ) {
        // 修改头像
        UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:nil delegate:self
                                               cancelButtonTitle:@"取消"
                                          destructiveButtonTitle:nil
                                               otherButtonTitles:@"拍照", @"选择图片", nil];
        [as showInView:self.contentView];
    } else if ( indexPath.row == 1 ) {
        // 设置用户名
        UIViewController *vc = [[AWMediator sharedInstance] openVCWithName:@"UpdateNicknameVC" params:nil];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ( indexPath.row == 2 ) {
        // 设置性别
        [[[SexPicker alloc] init] showInView:self.contentView selectedBlock:^(SexPicker *sender, id selectedObj) {
            NSLog(@"selected sex: %@", selectedObj);
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.detailTextLabel.text = selectedObj[@"label"];
        }];
    } else if ( indexPath.row == 3 ) {
        // 设置生日
        [[[DatePicker alloc] init] showInView:self.contentView selectedBlock:^(DatePicker *sender, NSDate *selectedDate) {
            NSLog(@"date: %@", selectedDate);
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            NSDateFormatter *df = [[NSDateFormatter alloc] init];
            df.dateFormat = @"yyyy-MM-dd";
            cell.detailTextLabel.text = [df stringFromDate:selectedDate];
        }];
    }
}

- (UIImagePickerController *)imagePickerController
{
    if (!_imagePickerController) {
        _imagePickerController = [[UIImagePickerController alloc] init];
        _imagePickerController.allowsEditing = YES;
        _imagePickerController.delegate      = self;
    }
    return _imagePickerController;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ( buttonIndex == 0 ) {
        // 拍照
        if ( ![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] ) {
            [self showAlertWithMessage:@"设备不支持拍照"];
            return;
        }
        
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else if ( buttonIndex == 1 ) {
        // 选择图片
        if ( ![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary] ) {
            [self showAlertWithMessage:@"设备不支持该功能"];
            return;
        }
        
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    if ( buttonIndex < 2 ) {
        [self presentViewController:self.imagePickerController animated:YES completion:nil];
    }
}

- (void)showAlertWithMessage:(NSString *)msg
{
    [[[UIAlertView alloc] initWithTitle:@"提示"
                               message:msg delegate:nil
                     cancelButtonTitle:@"确定"
                     otherButtonTitles:nil] show];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    self.avatarView.image = editedImage;
    
    [self.imagePickerController dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.imagePickerController dismissViewControllerAnimated:YES completion:nil];
}

@end
