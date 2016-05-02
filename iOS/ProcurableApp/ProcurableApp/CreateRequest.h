//
//  CreateRequest.h
//  ProcurableApp
//
//  Created by Will Turner on 5/2/16.
//  Copyright © 2016 Wilson Turner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CreateRequest : NSObject
@property (strong, nonatomic) NSArray *items;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *comments;

- (instancetype)initWithItems:(NSArray *)items name:(NSString *)name comments:(NSString *)comments;
@end
