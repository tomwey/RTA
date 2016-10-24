//
//  HomeVC.m
//  RTA
//
//  Created by tangwei1 on 16/10/10.
//  Copyright © 2016年 tomwey. All rights reserved.
//

#import "HomeVC.h"
#import "Defines.h"

@implementation HomeVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ( self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil] ) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"实时"
                                                        image:[UIImage imageNamed:@"home.png"]
                                                selectedImage:[UIImage imageNamed:@"home_selected.png"]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navBar.title = @"实时";
    
    [self addLeftBarItemWithView:nil];
    
//    [self.networkService POST:@"GetStationByLngAndLat"
//                       params:@{} completion:<#^(id result, NSError *error)completion#>]
}

@end
