//
//  InventoryItem.m
//  ProcurableApp
//
//  Created by Will Turner on 4/25/16.
//  Copyright © 2016 Wilson Turner. All rights reserved.
//

#import "InventoryItem.h"

@implementation InventoryItem

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _idNumber = nil;
        _name = nil;
        _comments = nil;
        _partNumber = nil;
        _price = nil;
        _status = NO;
        _vendorName = nil;
        _vendorWebsite = nil;
        _vendorId = nil;
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
            _name = [dictionary objectForKey:@"Name"];
            _comments = [dictionary objectForKey:@"Comments"];
            _partNumber = [dictionary objectForKey:@"PartNumber"];
            _price = [dictionary objectForKey:@"Price"];
            _status = [dictionary objectForKey:@"Status"];
            _vendorName = [(NSDictionary *)[dictionary objectForKey:@"Vendor"] objectForKey:@"Name"];
            _vendorWebsite = [(NSDictionary *)[dictionary objectForKey:@"Vendor"] objectForKey:@"Website"];
            _vendorId = [dictionary objectForKey:@"VendorID"];
        }
    }
    return self;
}

@end
