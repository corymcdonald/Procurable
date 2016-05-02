//
//  RequestItem.m
//  ProcurableApp
//
//  Created by Will Turner on 5/1/16.
//  Copyright © 2016 Wilson Turner. All rights reserved.
//

#import "RequestItem.h"

@implementation RequestItem

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _name = nil;
        _comments = nil;
        _url = nil;
        _count = 0;
    }
    return self;
}

- (instancetype)initWithName:(NSString *)name comments:(NSString *)comments url:(NSString *)url count:(NSInteger)count {
    self = [super init];
    if (self)
    {
        _name = name;
        _comments = comments;
        _url = url;
        _count = [[NSNumber alloc] initWithInteger:count];
    }
    return self;
}

@end
