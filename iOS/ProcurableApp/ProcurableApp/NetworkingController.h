//
//  NetworkingController.h
//  ProcurableApp
//
//  Created by Will Turner on 2/9/16.
//  Copyright © 2016 Wilson Turner. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^DataControllerCompletionHandler)(NSArray * __nullable values, NSError * __nullable error);
typedef void(^NetworkingControllerCompletionHandler)(BOOL value, NSError * __nullable error);
typedef void(^RequestsCompletionHandler)(NSArray *requests, NSError * __nullable error);
typedef void(^ItemsCompletionHandler)(NSArray *items, NSError * __nullable error);

@interface NetworkingController : NSObject
//- (void)fetchRandomNumbers:(NSInteger)integer completion:(DataControllerCompletionHandler)completionHandler;
//- (void)fetchRandomNumbers2:(NSString *)string completion:(DataControllerCompletionHandler)completionHandler;
- (void)registerNewUser:(NSString *)user withPassword:(NSString *)password withConfirmPassword:(NSString *)confirmPassword completion:(NetworkingControllerCompletionHandler)completionHandler;
- (void)loginUser:(NSString *)user withPassword:(NSString *)password completion:(NetworkingControllerCompletionHandler)completionHandler;
- (void)cookieTestWithCompletion:(NetworkingControllerCompletionHandler)completionHandler;
- (void)listAllRequests:(RequestsCompletionHandler)completionHandler;
- (void)listAllRequestsToBeApproved:(RequestsCompletionHandler)completionHandler;
- (void)temporaryCreateItemWithCompletion:(NetworkingControllerCompletionHandler)completionHandler;
- (void)updateRequestStatus:(NSNumber *)idNumber withValue:(NSNumber *)value withCompletion:(NetworkingControllerCompletionHandler)completionHandler;
- (void)listAllInventoryItems:(ItemsCompletionHandler)completionHandler;
- (void)searchForItems:(NSString *)string withCompletion:(ItemsCompletionHandler)completionHandler;
@end
NS_ASSUME_NONNULL_END
