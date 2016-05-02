//
//  CartSingleton.h
//  ProcurableApp
//
//  Created by Will Turner on 4/30/16.
//  Copyright © 2016 Wilson Turner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestItem.h"

@interface CartSingleton : NSObject
@property (nonatomic, strong) NSMutableArray *cart;
@property (nonatomic, assign) BOOL isEmpty;

+ (id)sharedCart;
- (void)emptyCart;
- (void)addItem:(RequestItem *)item;
- (NSInteger)count;
@end