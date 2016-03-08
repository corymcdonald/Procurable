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

- (void)cookieTestWithCompletion:(NetworkingControllerCompletionHandler)completionHandler {
    
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    NSHTTPCookie *appCookie;
    for (NSHTTPCookie *cookie in cookies) {
        if ([cookie.name isEqualToString:@".AspNet.ApplicationCookie"]) {
            appCookie = cookie;
        }
    }
    
    NSString *cookieValue = [[[appCookie name] stringByAppendingString:@"="] stringByAppendingString:[appCookie value]];
    NSURL *url = [NSURL URLWithString:@"https://procurable.azurewebsites.net/Inventories"];
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

- (void)logout {
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *each in cookieStorage.cookies) {
        [cookieStorage deleteCookie:each];
    }
}

- (NSArray *)calculateValues:(NSArray *)array {
    NSCountedSet *set = [[NSCountedSet alloc] initWithArray:array];
    return [NSArray arrayWithObjects:@([set countForObject:@1]), @([set countForObject:@2]), @([set countForObject:@3]), @([set countForObject:@4]), @([set countForObject:@5]), @([set countForObject:@6]), nil];
}

@end
