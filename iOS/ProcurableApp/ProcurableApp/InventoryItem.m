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
        _count = nil;
        _idNumber = nil;
        _name = @"";
        _comments = @"";
        _partNumber = @"";
        _price = nil;
        _status = nil;
        _vendorName = @"";
        _vendorWebsite = @"";
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
            _count = [dictionary objectForKey:@"Count"];
            _idNumber = [[[dictionary objectForKey:@"Item"] objectAtIndex:0] objectForKey:@"ID"];
            if ([[[[dictionary objectForKey:@"Item"] objectAtIndex:0] objectForKey:@"Name"] class] != [NSNull class]) {
                _name = [[[dictionary objectForKey:@"Item"] objectAtIndex:0] objectForKey:@"Name"];
            } else {
                _name = @"No Name Provided";
            }
            if ([[[[dictionary objectForKey:@"Item"] objectAtIndex:0] objectForKey:@"Comments"] class] != [NSNull class]) {
                _comments = [[[dictionary objectForKey:@"Item"] objectAtIndex:0] objectForKey:@"Comments"];
            } else {
                _comments = @"No Comments";
            }
            if ([[[[dictionary objectForKey:@"Item"] objectAtIndex:0] objectForKey:@"PartNumber"] class] != [NSNull class]) {
                _partNumber = [[[dictionary objectForKey:@"Item"] objectAtIndex:0] objectForKey:@"PartNumber"];
            } else {
                _partNumber = @"No Part Number Provided";
            }
            NSNumber *minPrice = [[[dictionary objectForKey:@"Item"] objectAtIndex:0] objectForKey:@"Price"];
            for (int i = 1; i < [(NSNumber *)[dictionary objectForKey:@"Count"] intValue]; i++) {
                if ([[[dictionary objectForKey:@"Item"] objectAtIndex:i] objectForKey:@"Price"] < minPrice) {
                    minPrice = [[[dictionary objectForKey:@"Item"] objectAtIndex:0] objectForKey:@"Price"];
                }
            }
            _price = minPrice;
            _status = [[[dictionary objectForKey:@"Item"] objectAtIndex:0] objectForKey:@"Status"];
            if ([[[[[dictionary objectForKey:@"Item"] objectAtIndex:0] objectForKey:@"Vendor"] objectForKey:@"Name"] class] != [NSNull class]) {
                _vendorName = [[[[dictionary objectForKey:@"Item"] objectAtIndex:0] objectForKey:@"Vendor"] objectForKey:@"Name"];
            } else {
                _vendorName = @"No Vendor Name Provided";
            }
            if ([[[[[dictionary objectForKey:@"Item"] objectAtIndex:0] objectForKey:@"Vendor"] objectForKey:@"Website"] class] != [NSNull class]) {
                _vendorWebsite = [[[[dictionary objectForKey:@"Item"] objectAtIndex:0] objectForKey:@"Vendor"] objectForKey:@"Website"];
            } else {
                _vendorWebsite = @"No Website Provided";
            }
            _vendorId = [[[dictionary objectForKey:@"Item"] objectAtIndex:0] objectForKey:@"VendorID"];
        }
    }
    return self;
}

@end
