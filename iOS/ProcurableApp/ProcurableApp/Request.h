//
//  Request.h
//  ProcurableApp
//
//  Created by Will Turner on 3/28/16.
//  Copyright © 2016 Wilson Turner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Request : NSObject
@property (strong, nonatomic) NSArray *items;
@property (strong, nonatomic) User *requestedBy;
@property (strong, nonatomic) User *requestedFor;
@property (strong, nonatomic) NSNumber *idNumber;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *comments;
@property (strong, nonatomic) NSString *receivedCreatedDate;
@property (strong, nonatomic) NSDate *createdDate;
@property (strong, nonatomic) NSString *createdDateDisplay;

@property (strong, nonatomic) NSString *receivedLastModifiedDate;
@property (strong, nonatomic) NSDate *lastModifiedDate;
@property (strong, nonatomic) NSString *lastModifiedDisplay;
@property (assign, nonatomic) NSNumber *status;
@property (strong, nonatomic) NSString *statusDisplay;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
