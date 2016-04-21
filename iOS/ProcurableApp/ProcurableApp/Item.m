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
        _name = nil;
        _comments = nil;
        _url = nil;
        _itemDict = nil;
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
            _name = [dictionary objectForKey:@"Name"];
            _comments = [dictionary objectForKey:@"Comments"];
            _url = [dictionary objectForKey:@"URL"];
            _itemDict = [dictionary objectForKey:@"Item"];
        }
    }
    return self;
}

@end
