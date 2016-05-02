//
//  Item.h
//  ProcurableApp
//
//  Created by Will Turner on 4/11/16.
//  Copyright © 2016 Wilson Turner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InventoryItem.h"

@interface Item : NSObject
@property (strong, nonatomic) NSNumber *idNumber;
@property (assign, nonatomic) BOOL inInventory;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *comments;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) InventoryItem *inventoryItem;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
