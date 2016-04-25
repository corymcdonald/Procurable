//
//  InventoryItem.h
//  ProcurableApp
//
//  Created by Will Turner on 4/25/16.
//  Copyright © 2016 Wilson Turner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InventoryItem : NSObject
@property (strong, nonatomic) NSNumber *idNumber;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *comments;
@property (strong, nonatomic) NSString *partNumber;
@property (strong, nonatomic) NSNumber *price;
@property (assign, nonatomic) BOOL status;
@property (strong, nonatomic) NSString *vendorName;
@property (strong, nonatomic) NSString *vendorWebsite;
@property (strong, nonatomic) NSNumber *vendorId;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
