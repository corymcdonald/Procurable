//
//  CartSingleton.m
//  ProcurableApp
//
//  Created by Will Turner on 4/30/16.
//  Copyright © 2016 Wilson Turner. All rights reserved.
//

#import "CartSingleton.h"

@implementation CartSingleton

+ (id)sharedCart {
    static CartSingleton *sharedCart = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedCart = [[self alloc] init];
    });
    return sharedCart;
}

- (id)init {
    if (self = [super init]) {
        _cart = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)emptyCart {
    [self.cart removeAllObjects];
}

- (void)dealloc {
}



@end
