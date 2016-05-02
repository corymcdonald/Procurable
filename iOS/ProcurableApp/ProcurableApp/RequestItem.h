//
//  RequestItem.h
//  ProcurableApp
//
//  Created by Will Turner on 5/1/16.
//  Copyright © 2016 Wilson Turner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestItem : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *comments;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSNumber *count;

- (instancetype)initWithName:(NSString *)name comments:(NSString *)comments url:(NSString *)url count:(NSInteger)count;
- (NSArray *)generateItems;
@end
