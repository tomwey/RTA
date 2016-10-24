//
//  UIViewController+NetworkService.h
//  RTA
//
//  Created by tomwey on 10/24/16.
//  Copyright © 2016 tomwey. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NetworkService;
@interface UIViewController (NetworkService)

@property (nonatomic, strong, readonly) NetworkService *networkService;

@end
