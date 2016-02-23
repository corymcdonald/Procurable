//
//  NetworkingController.m
//  ProcurableApp
//
//  Created by Will Turner on 2/9/16.
//  Copyright © 2016 Wilson Turner. All rights reserved.
//

#import "NetworkingController.h"

static NSString *const kAPIKey = @"a108606a-2ac7-4df5-ab4e-8304690632dc";

@interface NetworkingController ()

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSOperationQueue *sessionParseQueue;

@end

@implementation NetworkingController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _sessionParseQueue = [[NSOperationQueue alloc] init];
        _sessionParseQueue.maxConcurrentOperationCount = 1;
        _session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:_sessionParseQueue];
    }
    return self;
}

- (void)fetchRandomNumbers2:(NSString *)cookie completion:(DataControllerCompletionHandler)completionHandler {
    NSURL *url = [NSURL URLWithString:@"https://procurabledev.azurewebsites.net/Account/Register/"];
//    NSURL *url = [NSURL URLWithString:@"https://procurabledev.azurewebsites.net/Account/Login"];

//    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
//    config.HTTPAdditionalHeaders = @{
//                                     @"Cookie": cookie
//                                     };
//    self.session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:self.sessionParseQueue];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
        NSDictionary *dictionary = @{
                                     @"Email": @"bobTommm8mm@gmail.com",
                                     @"Password": @"Abcd1234$",
                                     @"ConfirmPassword": @"Abcd1234$"
                                     };

    NSError *error = nil;
        NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary options:kNilOptions error:&error];
    
    if (!error) {
        NSURLSessionDataTask *uploadTask = [self.session uploadTaskWithRequest:request fromData:data completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
            if (data) {
                NSError *parseError;
//                NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
//                NSArray *cookies = [NSHTTPCookie cookiesWithResponseHeaderFields:[httpResp allHeaderFields] forURL:[response URL]];
//                [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookies:cookies forURL:[response URL] mainDocumentURL:nil];
                NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&parseError];
                if ([dictionary objectForKey:@"result"]) {
                    NSArray *array = [[[dictionary objectForKey:@"result"] objectForKey:@"random"] objectForKey:@"data"];
                    completionHandler([self calculateValues:array], parseError);
                } else {
                    completionHandler(nil, [dictionary objectForKey:@"error"]);
                }
            } else if (error) {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    completionHandler(nil, error);
                }];
            } else {
                NSError *error = [NSError errorWithDomain:@"com.bottlerocketstudios.forecast.unspecified" code:-1000 userInfo:@{NSLocalizedDescriptionKey : @"Unspecified error fetching forecast"}];
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    completionHandler(nil, error);
                }];
            }
        }];
        [uploadTask resume];
    }
}

- (void)registerNewUser:(NSString *)user withPassword:(NSString *)password withConfirmPassword:(NSString *)confirmPassword completion:(NetworkingControllerCompletionHandler)completionHandler {
    NSURL *url = [NSURL URLWithString:@"https://procurabledev.azurewebsites.net/Account/Register/"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSDictionary *dictionary = @{
                                 @"Email": user,
                                 @"Password": password,
                                 @"ConfirmPassword": confirmPassword
                                 };
    
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary options:kNilOptions error:&error];
    
    if (!error) {
        NSURLSessionDataTask *uploadTask = [self.session uploadTaskWithRequest:request fromData:data completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
            if (data) {
                NSError *parseError;
                NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&parseError];
                if ([dictionary objectForKey:@"Succeeded"] && [[dictionary objectForKey:@"Succeeded"] boolValue]) {
                    completionHandler(YES, parseError);
                } else if ([[dictionary objectForKey:@"Errors"] count]) {
                    NSError *err = [NSError errorWithDomain:[[dictionary objectForKey:@"Errors"] objectAtIndex:0] code:-1 userInfo:nil];
                    completionHandler(NO, err);
                } else {
                    NSError *err = [NSError errorWithDomain:@"An unspecified error has occoured" code:-1 userInfo:nil];
                    completionHandler(NO, err);
                }
            } else if (error) {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    completionHandler(NO, error);
                }];
            } else {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    completionHandler(NO, nil);
                }];
            }
        }];
        [uploadTask resume];
    }
}

- (void)loginUser:(NSString *)user withPassword:(NSString *)password completion:(NetworkingControllerCompletionHandler)completionHandler {
    NSURL *url = [NSURL URLWithString:@"https://procurabledev.azurewebsites.net/Account/Login/"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSDictionary *dictionary = @{
                                 @"Email": user,
                                 @"Password": password
                                 };
    
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary options:kNilOptions error:&error];
    
    if (!error) {
        NSURLSessionDataTask *uploadTask = [self.session uploadTaskWithRequest:request fromData:data completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
            if (data) {
                NSError *parseError;
                NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&parseError];
                if ([dictionary objectForKey:@"Succeeded"] && [[dictionary objectForKey:@"Succeeded"] boolValue]) {
                    completionHandler(YES, parseError);
                } else if ([dictionary objectForKey:@"Error"]) {
                    NSError *err = [NSError errorWithDomain:[dictionary objectForKey:@"Error"] code:-1 userInfo:nil];
                    completionHandler(NO, err);
                }
            } else if (error) {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    completionHandler(NO, error);
                }];
            } else {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    completionHandler(NO, nil);
                }];
            }
        }];
        [uploadTask resume];
    }
}

- (void)fetchRandomNumbers:(NSInteger)integer completion:(DataControllerCompletionHandler)completionHandler {
    NSURL *url = [NSURL URLWithString:@"https://procurabledev.azurewebsites.net/Account/Register/"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"GET";
    //
    //    NSDictionary *dictionary = @{
    //                                 @"jsonrpc": @"2.0",
    //                                 @"method": @"generateIntegers",
    //                                 @"params": @{
    //                                         @"apiKey": kAPIKey,
    //                                         @"n": [NSNumber numberWithInteger:integer],
    //                                         @"min": @1,
    //                                         @"max": @6,
    //                                         @"replacement": @YES,
    //                                         @"base": @10
    //                                         },
    //                                 @"id": @898
    //                                 };
    
    NSError *error = nil;
    //    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary options:kNilOptions error:&error];
    
    if (!error) {
        NSURLSessionDataTask *uploadTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
            if (data) {
                NSError *parseError;
                NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
                NSArray *cookies = [NSHTTPCookie cookiesWithResponseHeaderFields:[httpResp allHeaderFields] forURL:[response URL]];
                [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookies:cookies forURL:[response URL] mainDocumentURL:nil];
                NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&parseError];
                if ([cookies count] == 2) {
                    NSString *string = [[cookies objectAtIndex:0] value];
                    [self fetchRandomNumbers2:string completion:completionHandler];
                } else {
                    completionHandler(nil, [dictionary objectForKey:@"error"]);
                }
            } else if (error) {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    completionHandler(nil, error);
                }];
            } else {
                NSError *error = [NSError errorWithDomain:@"com.bottlerocketstudios.forecast.unspecified" code:-1000 userInfo:@{NSLocalizedDescriptionKey : @"Unspecified error fetching forecast"}];
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    completionHandler(nil, error);
                }];
            }
        }];
        [uploadTask resume];
    }
}

- (NSArray *)calculateValues:(NSArray *)array {
    NSCountedSet *set = [[NSCountedSet alloc] initWithArray:array];
    return [NSArray arrayWithObjects:@([set countForObject:@1]), @([set countForObject:@2]), @([set countForObject:@3]), @([set countForObject:@4]), @([set countForObject:@5]), @([set countForObject:@6]), nil];
}

@end
