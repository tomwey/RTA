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

@property (nonatomic, copy, readwrite) NSString *token;

@end

@implementation User

- (instancetype)initWithDictionary:(NSDictionary *)jsonResult
{
//    Birthday = "2016-10-14";
//    HeadUrl = "http://182.150.21.101:9091/Images/tx.jpg";
//    LoginName = 18380412156;
//    Password = "";
//    Sex = 1;
//    Tel = 18380412156;
//    UpdateTime = "<null>";
//    UserID = "92977498-7787-4346-939c-fa97e19563ef";
//    UserName = "\U5f20\U742a";
//    resultdes = "\U6267\U884c\U6210\U529f";
//    status = 101;
    if ( self = [super init] ) {
        self.mobile = [jsonResult[@"LoginName"] description];
        self.avatar = [jsonResult[@"HeadUrl"] description];
        self.name = [jsonResult[@"UserName"] description];
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        df.dateFormat = @"yyyy-MM-dd";
        
        self.birthday = [df dateFromString:[jsonResult[@"Birthday"] description]];
        self.sex = jsonResult[@"Sex"];
        
        self.token = jsonResult[@"UserID"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.mobile forKey:@"mobile"];
    [aCoder encodeObject:self.token forKey:@"token"];
    [aCoder encodeObject:self.avatar forKey:@"avatar"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.sex forKey:@"sex"];
    [aCoder encodeObject:self.birthday forKey:@"birthday"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    User *aUser = [[User alloc] init];
    aUser.mobile = [[aDecoder decodeObjectForKey:@"mobile"] description];
    aUser.token = [[aDecoder decodeObjectForKey:@"token"] description];
    aUser.avatar = [[aDecoder decodeObjectForKey:@"avatar"] description];
    aUser.sex = [aDecoder decodeObjectForKey:@"sex"];
    aUser.name = [[aDecoder decodeObjectForKey:@"name"] description];
    aUser.birthday = [aDecoder decodeObjectForKey:@"birthday"];
    return aUser;
}

- (void)updateName:(NSString *)name
{
    self.name = name;
}

- (void)updateBirth:(NSDate *)birth
{
    self.birthday = birth;
}

- (void)updateAvatar:(NSString *)avatar
{
    self.avatar = avatar;
}

- (void)updateSex:(NSNumber *)sex
{
    self.sex = sex;
}

@end

@implementation User (Deco)

- (NSString *)hackMobile
{
    return [self.mobile stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
}

- (NSString *)nickname
{
    return self.name ?: [self hackMobile] ?: @"请登录";
}

- (NSString *)formatBirth
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy-MM-dd";
    return self.birthday ? [df stringFromDate:self.birthday] : @"未设置";
}

- (NSString *)formatSex
{
    return self.sex ? ([self.sex integerValue] == 0 ? @"男" : @"女") : @"未设置";
}

- (NSString *)formatUsername
{
    return self.name ?: [self hackMobile];
}

- (BOOL)validateMobile
{
    NSString* reg = @"^1[3|4|5|7|8][0-9]\\d{4,8}$";
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", reg];
    if ( [predicate evaluateWithObject:self.mobile] ) {
        return YES;
    }
    return NO;
}

@end
