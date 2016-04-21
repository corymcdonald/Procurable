//
//  User.h
//  ProcurableApp
//
//  Created by Will Turner on 4/11/16.
//  Copyright © 2016 Wilson Turner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property (strong, nonatomic) NSArray *claims;
@property (strong, nonatomic) NSArray *logins;
@property (strong, nonatomic) NSArray *roles;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *idNumber;
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *name;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
