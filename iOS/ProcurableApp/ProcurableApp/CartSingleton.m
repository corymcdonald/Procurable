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
        _isEmpty = YES;
    }
    return self;
}

- (void)emptyCart {
    self.isEmpty = YES;
    [self.cart removeAllObjects];
}

- (void)addItem:(RequestItem *)item {
    self.isEmpty = NO;
    [self.cart addObject:item];
}

- (void)removeItem:(NSInteger)index {
    if (index >= 0 && index < [self.cart count]) {
        [self.cart removeObjectAtIndex:index];
    }
    if ([self.cart count] == 0) {
        self.isEmpty = YES;
    }
}

- (RequestItem *)getItem:(NSInteger)index {
    return [self.cart objectAtIndex:index];
}

- (NSInteger)count {
    return [self.cart count];
}

- (void)dealloc {
}



@end
