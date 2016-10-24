//
//  ParamUtil.m
//  RTA
//
//  Created by tomwey on 10/24/16.
//  Copyright © 2016 tomwey. All rights reserved.
//

#import "ParamUtil.h"

NSString *stringByParams(NSDictionary *params)
{
    if (!params) {
        return nil;
    }
    
    NSMutableArray *temp = [NSMutableArray array];
    for (id key in params) {
        [temp addObject:[NSString stringWithFormat:@"%@=%@", key, params[key]]];
    }
    return [temp componentsJoinedByString:@"&"];
}
