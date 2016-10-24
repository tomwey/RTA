//
//  InteractVC.m
//  RTA
//
//  Created by tangwei1 on 16/10/10.
//  Copyright © 2016年 tomwey. All rights reserved.
//

#import "InteractVC.h"
#import "Defines.h"

@implementation InteractVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ( self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil] ) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"广场"
                                                        image:[UIImage imageNamed:@"interact.png"]
                                                selectedImage:[UIImage imageNamed:@"interact_selected.png"]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navBar.title = @"广场";
    
    [self addLeftBarItemWithView:nil];
}

@end
