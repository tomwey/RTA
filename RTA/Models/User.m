//
//  User.m
//  RTA
//
//  Created by tangwei1 on 16/10/10.
//  Copyright © 2016年 tomwey. All rights reserved.
//

#import "User.h"

@interface User ()

@property (nonatomic, copy, readwrite) NSString *mobile;
@property (nonatomic, copy, readwrite) NSString *avatar;
@property (nonatomic, copy, readwrite) NSString *name;
@property (nonatomic, copy, readwrite) NSDate   *birthday;
@property (nonatomic, copy, readwrite) NSNumber *sex;

@end

@implementation User

- (instancetype)initWithDictionary:(NSDictionary *)jsonResult
{
    if ( self = [super init] ) {
        self.mobile = [jsonResult[@"mobile"] description];
        self.avatar = [jsonResult[@"headUrl"] description];
        self.name = [jsonResult[@"username"] description];
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        df.dateFormat = @"yyyy-MM-dd";
        
        self.birthday = [df dateFromString:[jsonResult[@"birth"] description]];
        self.sex = jsonResult[@"sex"];
    }
    return self;
}

@end

@implementation User (Deco)

- (NSString *)hackMobile
{
    return [self.mobile stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
}

- (NSString *)nickname
{
    return self.name ?: self.hackMobile ?: @"请登录";
}

- (NSString *)formatBirth
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"MM/dd";
    return [df stringFromDate:self.birthday];
}

- (NSString *)formatSex
{
    return [self.sex integerValue] == 0 ? @"男" : @"女";
}

@end
