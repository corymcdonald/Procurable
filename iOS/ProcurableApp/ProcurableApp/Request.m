//
//  Request.m
//  ProcurableApp
//
//  Created by Will Turner on 3/28/16.
//  Copyright © 2016 Wilson Turner. All rights reserved.
//

#import "Request.h"

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
        _createdDate = nil;
        _createdDateDisplay = nil;
        _lastModified = nil;
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
            _items = [dictionary objectForKey:@"Items"];
            _requestedBy = [dictionary objectForKey:@"RequestedBy"];
            _requestedFor = [dictionary objectForKey:@"RequestedFor"];
            _idNumber = [dictionary objectForKey:@"ID"];
            _name = [dictionary objectForKey:@"Name"];
            _comments = [dictionary objectForKey:@"Comments"];
            _createdDate = [dictionary objectForKey:@"CreatedDate"];
            _createdDateDisplay = [dictionary objectForKey:@"CreatedDateDisplay"];
            _lastModified = [dictionary objectForKey:@"LastModified"];
            _lastModifiedDisplay = [dictionary objectForKey:@"LastModifiedDisplay"];
            _status = [dictionary objectForKey:@"Status"];
            _statusDisplay = [dictionary objectForKey:@"StatusDisplay"];
        }
    }
    return self;
}

@end
