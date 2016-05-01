//
//  CartSingleton.h
//  ProcurableApp
//
//  Created by Will Turner on 4/30/16.
//  Copyright © 2016 Wilson Turner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CartSingleton : NSObject
@property (nonatomic, strong) NSMutableArray *cart;

+ (id)sharedCart;
- (void)emptyCart;
@end