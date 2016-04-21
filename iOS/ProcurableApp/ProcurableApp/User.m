//
//  User.m
//  ProcurableApp
//
//  Created by Will Turner on 4/11/16.
//  Copyright © 2016 Wilson Turner. All rights reserved.
//

#import "User.h"

@implementation User
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _claims = nil;
        _logins = nil;
        _roles = nil;
        _firstName = nil;
        _lastName = nil;
        _email = nil;
        _idNumber = nil;
        _userName = nil;
        _name = nil;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self)
    {
        if ([dictionary isKindOfClass:[NSDictionary class]]) {
            _claims = [dictionary objectForKey:@"Claims"];
            _logins = [dictionary objectForKey:@"Logins"];
            _roles = [dictionary objectForKey:@"Roles"];
            _firstName = [dictionary objectForKey:@"FirstName"];
            _lastName = [dictionary objectForKey:@"LastName"];
            _email = [dictionary objectForKey:@"Email"];
            _idNumber = [dictionary objectForKey:@"Id"];
            _userName = [dictionary objectForKey:@"UserName"];
            _name = [[_firstName stringByAppendingString:@" "] stringByAppendingString:_lastName];
        }
    }
    return self;
}



@end
