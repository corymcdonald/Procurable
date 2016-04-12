//
//  Request.m
//  ProcurableApp
//
//  Created by Will Turner on 3/28/16.
//  Copyright © 2016 Wilson Turner. All rights reserved.
//

#import "Request.h"
#import "Item.h"

@implementation Request

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _items = nil;
        _requestedBy = nil;
        _requestedFor = nil;
        _idNumber = nil;
        _name = nil;
        _comments = nil;
        _receivedCreatedDate = nil;
        _createdDate = nil;
        _createdDateDisplay = nil;
        _receivedLastModifiedDate = nil;
        _lastModifiedDate = nil;
        _lastModifiedDisplay = nil;
        _status = [NSNumber numberWithInt:-1];
        _statusDisplay = nil;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self)
    {
        if (dictionary) {
            NSArray *receivedItemArray = [dictionary objectForKey:@"Items"];
            NSMutableArray *itemArray = [[NSMutableArray alloc] init];
            for (int i = 0; i < [receivedItemArray count]; i++) {
                [itemArray addObject:[[Item alloc] initWithDictionary:[receivedItemArray objectAtIndex:i]]];
            }
            _items = [NSArray arrayWithArray:itemArray];
            _requestedBy = [[User alloc] initWithDictionary:[dictionary objectForKey:@"RequestedBy"]];
            _requestedFor = [[User alloc] initWithDictionary:[dictionary objectForKey:@"RequestedFor"]];
            _idNumber = [dictionary objectForKey:@"ID"];
            _name = [dictionary objectForKey:@"Name"];
            _comments = [dictionary objectForKey:@"Comments"];
            
            NSDateFormatter *RFC3339DateFormatter = [[NSDateFormatter alloc] init];
            RFC3339DateFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
            RFC3339DateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZZZZZ";
            RFC3339DateFormatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
            
            NSDate *date = [RFC3339DateFormatter dateFromString:[dictionary objectForKey:@"CreatedDateDisplay"]];
            _createdDate = date;
            _createdDateDisplay = [dictionary objectForKey:@"CreatedDateDisplay"];
            _receivedCreatedDate = [dictionary objectForKey:@"CreatedDate"];
            
            date = [RFC3339DateFormatter dateFromString:[dictionary objectForKey:@"LastModifiedDisplay"]];
            _lastModifiedDate = date;
            _lastModifiedDisplay = [dictionary objectForKey:@"LastModifiedDisplay"];
            _receivedCreatedDate = [dictionary objectForKey:@"LastModified"];
            
            _status = [dictionary objectForKey:@"Status"];
            _statusDisplay = [dictionary objectForKey:@"StatusDisplay"];
        }
    }
    return self;
}

@end
