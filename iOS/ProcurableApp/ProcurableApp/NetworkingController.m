//
//  NetworkingController.m
//  ProcurableApp
//
//  Created by Will Turner on 2/9/16.
//  Copyright © 2016 Wilson Turner. All rights reserved.
//

#import "NetworkingController.h"
#import "Request.h"

static NSString *const kURL = @"https://procurable.azurewebsites.net";

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

- (void)cookieTestWithCompletion:(NetworkingControllerCompletionHandler)completionHandler {
    
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    NSHTTPCookie *appCookie;
    for (NSHTTPCookie *cookie in cookies) {
        if ([cookie.name isEqualToString:@".AspNet.ApplicationCookie"]) {
            appCookie = cookie;
        }
    }
    
    NSString *cookieValue = [[[appCookie name] stringByAppendingString:@"="] stringByAppendingString:[appCookie value]];
    NSURL *url = [NSURL URLWithString:@"https://procurable.azurewebsites.net/InventoryItems"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:cookieValue forHTTPHeaderField:@"Cookie"];
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
        if (data) {
            NSError *parseError;
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&parseError];
            if (dictionary) {
                completionHandler(YES, parseError);
            } else {
                NSError *err = [NSError errorWithDomain:@"An unknown error has occurred" code:-1 userInfo:nil];
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
    [dataTask resume];
}

- (void)temporaryCreateItemWithCompletion:(NetworkingControllerCompletionHandler)completionHandler {
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    NSHTTPCookie *appCookie;
    for (NSHTTPCookie *cookie in cookies) {
        if ([cookie.name isEqualToString:@".AspNet.ApplicationCookie"]) {
            appCookie = cookie;
        }
    }
    NSString *cookieValue = [[[appCookie name] stringByAppendingString:@"="] stringByAppendingString:[appCookie value]];
    
    NSURL *url = [NSURL URLWithString:@"https://procurable.azurewebsites.net/Projects/Create/"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:cookieValue forHTTPHeaderField:@"Cookie"];
    
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSS'Z'"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    NSDictionary *dictionary = @{
                                 @"Prioity": @0,
                                 @"Status": @0,
                                 @"CreatedDate": dateString,
                                 @"LastModified": dateString
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

#pragma User State

- (void)registerNewUser:(NSString *)user withPassword:(NSString *)password withConfirmPassword:(NSString *)confirmPassword completion:(NetworkingControllerCompletionHandler)completionHandler {
    NSURL *url = [NSURL URLWithString:@"https://procurable.azurewebsites.net/Account/Register/"];
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
    
    
    NSURL *url = [NSURL URLWithString:@"https://procurable.azurewebsites.net/Account/Login/"];
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
                    NSArray *cookies = [NSHTTPCookie cookiesWithResponseHeaderFields:[(NSHTTPURLResponse *) response allHeaderFields] forURL:[response URL]];
                    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookies:cookies forURL:[response URL] mainDocumentURL:nil];
                    for (NSHTTPCookie *cookie in cookies) {
                        NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
                        [cookieProperties setObject:cookie.name forKey:NSHTTPCookieName];
                        [cookieProperties setObject:cookie.value forKey:NSHTTPCookieValue];
                        [cookieProperties setObject:cookie.domain forKey:NSHTTPCookieDomain];
                        [cookieProperties setObject:cookie.path forKey:NSHTTPCookiePath];
                        [cookieProperties setObject:[NSNumber numberWithInteger:cookie.version] forKey:NSHTTPCookieVersion];
                        
                        [cookieProperties setObject:[[NSDate date] dateByAddingTimeInterval:31536000] forKey:NSHTTPCookieExpires];
                        
                        NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
                        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
                        NSLog(@"name:%@ value:%@", cookie.name, cookie.value);
                    }
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

/*
 http://stackoverflow.com/questions/1852515/how-to-clear-cookies-from-nshttpcookiestorage-more-then-once
 */

- (void)logout {
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *each in cookieStorage.cookies) {
        [cookieStorage deleteCookie:each];
    }
}

#pragma Requests

- (void)listAllRequests:(NetworkingControllerCompletionHandler)completionHandler {
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    NSHTTPCookie *appCookie;
    for (NSHTTPCookie *cookie in cookies) {
        if ([cookie.name isEqualToString:@".AspNet.ApplicationCookie"]) {
            appCookie = cookie;
        }
    }
    
    NSString *cookieValue = [[[appCookie name] stringByAppendingString:@"="] stringByAppendingString:[appCookie value]];
    NSURL *url = [NSURL URLWithString:@"https://procurable.azurewebsites.net/requests"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:cookieValue forHTTPHeaderField:@"Cookie"];
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
        if (data) {
            NSError *parseError;
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&parseError];
            if (dictionary) {
                completionHandler(YES, parseError);
            } else {
                NSError *err = [NSError errorWithDomain:@"An unknown error has occurred" code:-1 userInfo:nil];
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
    [dataTask resume];
}

- (void)listAllRequestsToBeApproved:(RequestsCompletionHandler)completionHandler {
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    NSHTTPCookie *appCookie;
    for (NSHTTPCookie *cookie in cookies) {
        if ([cookie.name isEqualToString:@".AspNet.ApplicationCookie"]) {
            appCookie = cookie;
        }
    }
    
    NSString *cookieValue = [[[appCookie name] stringByAppendingString:@"="] stringByAppendingString:[appCookie value]];
    NSURL *url = [NSURL URLWithString:@"https://procurable.azurewebsites.net/requests/approve"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:cookieValue forHTTPHeaderField:@"Cookie"];
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
        if (data) {
            NSError *parseError;
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&parseError];
            if (dictionary) {
                NSArray *arr = [self requestArray:dictionary];
                completionHandler(arr, parseError);
            } else {
                NSError *err = [NSError errorWithDomain:@"An unknown error has occurred" code:-1 userInfo:nil];
                completionHandler([[NSArray alloc] init], err);
            }
        } else if (error) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                completionHandler([[NSArray alloc] init], error);
            }];
        } else {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                completionHandler([[NSArray alloc] init], nil);
            }];
        }
    }];
    [dataTask resume];
}

- (void)requestDetail:(NetworkingControllerCompletionHandler)completionHandler {
}

- (void)createRequest:(NetworkingControllerCompletionHandler)completionHandler {
}

- (void)editRequest:(NetworkingControllerCompletionHandler)completionHandler {
}

- (void)deleteRequest:(NetworkingControllerCompletionHandler)completionHandler {
}

- (NSArray *)requestArray:(NSDictionary *)dict {
    NSArray *array = (NSArray *)dict;
    NSMutableArray *output = [[NSMutableArray alloc] init];
    for (NSDictionary *dictionary in array) {
        [output addObject:[[Request alloc] initWithDictionary:dictionary]];
    }
    return output;
}

#pragma Inventory

- (void)listAllInventoryItems:(NetworkingControllerCompletionHandler)completionHandler {
}

- (void)inventoryItemDetail:(NetworkingControllerCompletionHandler)completionHandler {
}

- (void)createInventoryItem:(NetworkingControllerCompletionHandler)completionHandler {
}

- (void)editInventoryItem:(NetworkingControllerCompletionHandler)completionHandler {
}

- (void)deleteInventoryItem:(NetworkingControllerCompletionHandler)completionHandler {
}

@end
