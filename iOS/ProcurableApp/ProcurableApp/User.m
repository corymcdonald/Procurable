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
        _firstName = @"";
        _lastName = @"";
        _email = @"";
        _idNumber = @"";
        _userName = @"";
        _name = @"";
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
            if ([[dictionary objectForKey:@"FirstName"] class] != [NSNull class]) {
                _firstName = [dictionary objectForKey:@"FirstName"];
            } else {
                _firstName = @"FirstName";
            }
            if ([[dictionary objectForKey:@"LastName"] class] != [NSNull class]) {
                _lastName = [dictionary objectForKey:@"LastName"];
            } else {
                _lastName = @"LastName";
            }
            if ([[dictionary objectForKey:@"Email"] class] != [NSNull class]) {
                _email = [dictionary objectForKey:@"Email"];
            } else {
                _email = @"No Email";
            }
            if ([[dictionary objectForKey:@"Id"] class] != [NSNull class]) {
                _idNumber = [dictionary objectForKey:@"Id"];
            } else {
                _idNumber = @"No ID";
            }
            if ([[dictionary objectForKey:@"UserName"] class] != [NSNull class]) {
                _userName = [dictionary objectForKey:@"UserName"];
            } else {
                _userName = @"No Username";
            }
            _name = [[_firstName stringByAppendingString:@" "] stringByAppendingString:_lastName];
        }
    }
    return self;
}



@end
