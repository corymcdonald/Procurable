//
//  CreateRequest.m
//  ProcurableApp
//
//  Created by Will Turner on 5/2/16.
//  Copyright © 2016 Wilson Turner. All rights reserved.
//

#import "CreateRequest.h"

@implementation CreateRequest
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _items = nil;
        _name = @"";
        _comments = @"";
    }
    return self;
}

- (instancetype)initWithItems:(NSArray *)items name:(NSString *)name comments:(NSString *)comments {
    self = [super init];
    if (self)
    {
        _items = items;
        _name = name;
        _comments = comments;
    }
    return self;
}
@end
