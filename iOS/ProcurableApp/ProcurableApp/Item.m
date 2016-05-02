//
//  Item.m
//  ProcurableApp
//
//  Created by Will Turner on 4/11/16.
//  Copyright © 2016 Wilson Turner. All rights reserved.
//

#import "Item.h"

@implementation Item

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _idNumber = nil;
        _inInventory = NO;
        _name = @"";
        _comments = @"";
        _url = @"";
        _inventoryItem = nil;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self)
    {
        if ([dictionary isKindOfClass:[NSDictionary class]]) {
            _idNumber = [dictionary objectForKey:@"ID"];
            _inInventory = [dictionary objectForKey:@"InInventory"];
            if ([[dictionary objectForKey:@"Name"] class] != [NSNull class]) {
                _name = [dictionary objectForKey:@"Name"];
            } else {
                _name = @"";
            }
            if ([[dictionary objectForKey:@"Comments"] class] != [NSNull class]) {
                _comments = [dictionary objectForKey:@"Comments"];
            } else {
                _comments = @"";
            }
            if ([[dictionary objectForKey:@"URL"] class] != [NSNull class]) {
                _url = [dictionary objectForKey:@"URL"];
            } else {
                _url = @"";
            }
            _inventoryItem = nil;
            if ([dictionary objectForKey:@"Item"]) {
                _inventoryItem = [[InventoryItem alloc] initWithDictionary:(NSDictionary *)[dictionary objectForKey:@"Item"]];
            }
        }
    }
    return self;
}

@end
