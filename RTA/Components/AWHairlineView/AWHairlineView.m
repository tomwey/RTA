//
//  AWHairlineView.m
//  deyi
//
//  Created by tangwei1 on 16/9/2.
//  Copyright © 2016年 tangwei1. All rights reserved.
//

#import "AWHairlineView.h"

@implementation AWHairlineView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    return [self initWithLineColor:[UIColor lightGrayColor]];
}

- (instancetype)initWithLineColor:(UIColor *)lineColor
{
    if ( self = [super init] ) {
        self.layer.borderColor = [lineColor CGColor];
        self.layer.borderWidth = ( 1.0 / [[UIScreen mainScreen] scale] ) / 2;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

@end
