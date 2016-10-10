//
//  User.h
//  RTA
//
//  Created by tangwei1 on 16/10/10.
//  Copyright © 2016年 tomwey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, copy, readonly) NSString *mobile;
@property (nonatomic, copy, readonly) NSString *avatar;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSDate   *birthday;
@property (nonatomic, copy, readonly) NSNumber *sex;

- (instancetype)initWithDictionary:(NSDictionary *)jsonResult;

@end

@interface User (Deco)

- (NSString *)nickname;
- (NSString *)formatBirth;
- (NSString *)formatSex;

@end
