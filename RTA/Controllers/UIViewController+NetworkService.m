//
//  UIViewController+NetworkService.m
//  RTA
//
//  Created by tomwey on 10/24/16.
//  Copyright © 2016 tomwey. All rights reserved.
//

#import "UIViewController+NetworkService.h"
#import "NetworkService.h"
#import <objc/runtime.h>

@implementation UIViewController (NetworkService)

static char kNetworkServiceKey;

- (NetworkService *)networkService
{
    id obj = objc_getAssociatedObject(self, &kNetworkServiceKey);
    if ( !obj ) {
        obj = [[NetworkService alloc] init];
        objc_setAssociatedObject(obj,
                                 &kNetworkServiceKey,
                                 obj,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return (NetworkService *)obj;
}

@end
