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
    
    UIView *inputBg = [[UIView alloc] initWithFrame:CGRectMake(10, 10, self.contentView.width - 20, 88)];
    inputBg.backgroundColor = [UIColor whiteColor];
    inputBg.cornerRadius = 6;
    [self.contentView addSubview:inputBg];
    
    InputCell *startCell = [[InputCell alloc] initWithIcon:@"icon_start.png" title:@"我的位置"];
    [inputBg addSubview:startCell];
    startCell.frame = CGRectMake(15, 0, inputBg.width - 30, inputBg.height / 2);
    startCell.titleAttributes = @{ NSForegroundColorAttributeName: AWColorFromRGBA(50, 69, 255, 0.9) };
    
    // 加一根线
    AWHairlineView *line = [AWHairlineView horizontalLineWithWidth:inputBg.width
                                                             color:self.contentView.backgroundColor
                                                            inView:self.contentView];
    line.center = CGPointMake(inputBg.width / 2, inputBg.height / 2);
    
    InputCell *endCell = [[InputCell alloc] initWithIcon:@"icon_end.png" title:@"你要去哪儿？"];
    [inputBg addSubview:endCell];
    endCell.frame = startCell.frame;
    endCell.top = startCell.bottom;
    
    endCell.titleAttributes = @{ NSForegroundColorAttributeName: AWColorFromRGB(135,135,135) };
    
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
