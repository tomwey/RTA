//
//  InquireVC.m
//  RTA
//
//  Created by tangwei1 on 16/10/10.
//  Copyright © 2016年 tomwey. All rights reserved.
//

#import "InquireVC.h"
#import "Defines.h"

@interface InquireVC ()

@end

@implementation InquireVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ( self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil] ) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"换乘"
                                                        image:[UIImage imageNamed:@"inquire.png"]
                                                selectedImage:[UIImage imageNamed:@"inquire_selected.png"]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navBar.title = @"换乘";
    
    [self addLeftBarItemWithView:nil];
    
    self.contentView.backgroundColor = AWColorFromRGB(239, 239, 239);
    
    UIView *inputBg = [[UIView alloc] initWithFrame:CGRectMake(10, 10, self.contentView.width - 20, 108)];
    inputBg.backgroundColor = [UIColor whiteColor];
    inputBg.cornerRadius = 6;
    [self.contentView addSubview:inputBg];
    
    InputCell *startCell = [[InputCell alloc] initWithIcon:@"icon_start.png" title:@"我的位置"];
    [inputBg addSubview:startCell];
    startCell.frame = CGRectMake(15, 0, inputBg.width - 30, inputBg.height / 2);
    startCell.titleAttributes = @{ NSForegroundColorAttributeName: AWColorFromRGBA(50, 69, 255, 0.9) };
    
    __weak typeof(self) me = self;
    startCell.clickBlock = ^(InputCell *sender) {
        
        void (^selectLocationBlock)(id location) = ^(id location) {
            NSLog(@"%@", location);
            //    {
            //        "ad_info" =     {
            //            adcode = 650502;
            //            city = "\U54c8\U5bc6\U5e02";
            //            district = "\U4f0a\U5dde\U533a";
            //            province = "\U65b0\U7586\U7ef4\U543e\U5c14\U81ea\U6cbb\U533a";
            //        };
            //        address = "\U65b0\U7586\U7ef4\U543e\U5c14\U81ea\U6cbb\U533a\U54c8\U5bc6\U5e02\U4f0a\U5dde\U533a\U4e8c\U5821\U6536\U8d39\U7ad9\U5411\U897f500\U7c73\U5904\U8def\U5357";
            //        category = "\U6c7d\U8f66:\U52a0\U6cb9\U7ad9:\U5176\U5b83\U52a0\U6cb9\U7ad9";
            //        id = 2133268359532900694;
            //        location =     {
            //            lat = "43.01545";
            //            lng = "93.15819999999999";
            //        };
            //        tel = " ";
            //        title = "\U542b\U9526\U4e8c\U5821L-CNG\U52a0\U6c14\U5357\U7ad9";
            //        type = 0;
            //    }
            sender.title = [location valueForKey:@"title"];
        };
        UIViewController *vc = [[AWMediator sharedInstance] openVCWithName:@"LocationSearchVC" params:@{ @"selectBlock": selectLocationBlock }];
        [me.tabBarController.navigationController pushViewController:vc animated:YES];
    };
    
    // 加一根线
    AWHairlineView *line = [AWHairlineView horizontalLineWithWidth:inputBg.width
                                                             color:self.contentView.backgroundColor
                                                            inView:inputBg];
    line.center = CGPointMake(inputBg.width / 2, inputBg.height / 2);
    
    InputCell *endCell = [[InputCell alloc] initWithIcon:@"icon_end.png"
                                                   title:@"你要去哪儿？"];
    [inputBg addSubview:endCell];
    endCell.frame = startCell.frame;
    endCell.top = startCell.bottom;
    
    endCell.titleAttributes = @{ NSForegroundColorAttributeName: AWColorFromRGB(135,135,135) };
    endCell.clickBlock = ^(InputCell *sender) {
        void (^selectLocationBlock)(id location) = ^(id location) {
//            NSLog(@"%@", location);
            sender.title = [location valueForKey:@"title"];
        };
        UIViewController *vc = [[AWMediator sharedInstance] openVCWithName:@"LocationSearchVC" params:@{ @"selectBlock": selectLocationBlock }];
        [me.tabBarController.navigationController pushViewController:vc animated:YES];
    };
    
    // 确定
    AWButton *okButton = [AWButton buttonWithTitle:@"确定" color:NAV_BAR_BG_COLOR];
    [self.contentView addSubview:okButton];
    okButton.frame = CGRectMake(30, inputBg.bottom + 20, self.contentView.width - 30 * 2, 44);
    [okButton addTarget:self forAction:@selector(doQuery)];
}

- (void)doQuery
{
    
}

@end
