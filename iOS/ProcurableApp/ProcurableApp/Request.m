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
        _name = @"";
        _comments = @"";
        _receivedCreatedDate = @"";
        _createdDate = nil;
        _createdDateDisplay = @"";
        _receivedLastModifiedDate = @"";
        _lastModifiedDate = nil;
        _lastModifiedDisplay = @"";
        _status = [NSNumber numberWithInt:-1];
        _statusDisplay = @"";
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
            
            NSDateFormatter *RFC3339DateFormatter = [[NSDateFormatter alloc] init];
            RFC3339DateFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
            RFC3339DateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZZZZZ";
            RFC3339DateFormatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
            
            if ([[dictionary objectForKey:@"CreatedDateDisplay"] class] != [NSNull class]) {
                NSDate *date = [RFC3339DateFormatter dateFromString:[dictionary objectForKey:@"CreatedDateDisplay"]];
                _createdDate = date;
                _createdDateDisplay = [dictionary objectForKey:@"CreatedDateDisplay"];
            } else {
                _createdDate = nil;
                _createdDateDisplay = @"Unknown";
            }
            _receivedCreatedDate = [dictionary objectForKey:@"CreatedDate"];
            
            if ([[dictionary objectForKey:@"LastModifiedDisplay"] class] != [NSNull class]) {
                NSDate *date = [RFC3339DateFormatter dateFromString:[dictionary objectForKey:@"LastModifiedDisplay"]];
                _lastModifiedDate = date;
                _lastModifiedDisplay = [dictionary objectForKey:@"LastModifiedDisplay"];
            } else {
                _lastModifiedDate = nil;
                _lastModifiedDisplay = @"Unknown";
            }
            _receivedLastModifiedDate = [dictionary objectForKey:@"LastModified"];
            
            _status = [dictionary objectForKey:@"Status"];
            if ([[dictionary objectForKey:@"StatusDisplay"] class] != [NSNull class]) {
                _statusDisplay = [dictionary objectForKey:@"StatusDisplay"];
            } else {
                _statusDisplay = @"Unknown";
            }
        }
    }
    return self;
}

@end
