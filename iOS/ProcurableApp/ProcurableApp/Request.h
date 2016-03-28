//
//  Request.h
//  ProcurableApp
//
//  Created by Will Turner on 3/28/16.
//  Copyright © 2016 Wilson Turner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Request : NSObject
@property (strong, nonatomic) NSArray *items;
@property (strong, nonatomic) NSDictionary *requestedBy;
@property (strong, nonatomic) NSDictionary *requestedFor;
@property (strong, nonatomic) NSNumber *idNumber;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *comments;
@property (strong, nonatomic) NSString *createdDate;
@property (strong, nonatomic) NSString *createdDateDisplay;
@property (strong, nonatomic) NSString *lastModified;
@property (strong, nonatomic) NSString *lastModifiedDisplay;
@property (assign, nonatomic) NSNumber *status;
@property (strong, nonatomic) NSString *statusDisplay;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
