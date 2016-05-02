//
//  NetworkingController.m
//  ProcurableApp
//
//  Created by Will Turner on 2/9/16.
//  Copyright © 2016 Wilson Turner. All rights reserved.
//

#import "NetworkingController.h"

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

#pragma User State
- (void)registerNewUser:(NSString *)user withPassword:(NSString *)password withConfirmPassword:(NSString *)confirmPassword withDepartmentNumber:(NSNumber *)departmentNumber withcompletion:(NetworkingControllerCompletionHandler)completionHandler {
    NSURL *url = [NSURL URLWithString:@"https://procurable.azurewebsites.net/Account/Register/"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSDictionary *dictionary = @{
                                 @"Email": user,
                                 @"Password": password,
                                 @"ConfirmPassword": confirmPassword,
                                 @"DepartmentID": departmentNumber
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
                } else if ([dictionary objectForKey:@"Succeeded"] && ![[dictionary objectForKey:@"Succeeded"] boolValue]) {
                    NSError *err = [NSError errorWithDomain:@"Register Failed" code:-1 userInfo:nil];
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

- (void)fetchDepartmentsForRegister:(DepartmentControllerCompletionHandler)completionHandler {
    NSURL *url = [NSURL URLWithString:@"https://procurable.azurewebsites.net/Departments"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
        if (data) {
            NSError *parseError;
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&parseError];
            if (dictionary) {
                NSArray *dictionaryArray = [[NSArray alloc] initWithArray:(NSArray *)dictionary];
                NSMutableArray *departmentArray = [[NSMutableArray alloc] init];
                NSMutableArray *numberArray = [[NSMutableArray alloc] init];
                for (int i = 0; i < [dictionaryArray count]; i++) {
                    [departmentArray addObject:[(NSDictionary *)[dictionaryArray objectAtIndex:i] objectForKey:@"Name"]];
                    [numberArray addObject:[(NSDictionary *)[dictionaryArray objectAtIndex:i] objectForKey:@"ID"]];
                }
                completionHandler(departmentArray, numberArray, parseError);
            } else {
                NSError *err = [NSError errorWithDomain:@"Error Fetching Departments" code:-1 userInfo:nil];
                completionHandler(nil, nil, err);
            }
        } else if (error) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                completionHandler(nil, nil, error);
            }];
        } else {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                completionHandler(nil, nil, nil);
            }];
        }
    }];
    [dataTask resume];
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
                } else if ([dictionary objectForKey:@"Succeeded"] && ![[dictionary objectForKey:@"Succeeded"] boolValue]) {
                    NSError *err = [NSError errorWithDomain:@"Login Failed" code:-1 userInfo:nil];
                    completionHandler(NO, err);
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

#pragma Requests

- (void)listAllRequests:(RequestsCompletionHandler)completionHandler {
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
                NSArray *arr = [self requestArray:dictionary];
                completionHandler(arr, parseError);
            } else {
                NSError *err = [NSError errorWithDomain:@"Error Retreiving My Requests" code:-1 userInfo:nil];
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

- (void)listAllRequestsToBeApproved:(RequestsCompletionHandler)completionHandler {
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    NSHTTPCookie *appCookie;
    for (NSHTTPCookie *cookie in cookies) {
        if ([cookie.name isEqualToString:@".AspNet.ApplicationCookie"]) {
            appCookie = cookie;
        }
    }
    
    NSString *cookieValue = [[[appCookie name] stringByAppendingString:@"="] stringByAppendingString:[appCookie value]];
    NSURL *url = [NSURL URLWithString:@"https://procurable.azurewebsites.net/requests/Approve"];
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
                NSError *err = [NSError errorWithDomain:@"Error Retreiving Requests Awaiting Approval" code:-1 userInfo:nil];
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

- (void)createRequest:(CreateRequest *)requestItem withCompletion:(NetworkingControllerCompletionHandler)completionHandler {
    NSString *urlString = @"https://procurable.azurewebsites.net/requests/Create/";
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSDictionary *dictionary = @{
                                 @"Items": requestItem.items,
                                 @"Name": requestItem.name,
                                 @"Comments": requestItem.comments
                                 };
    
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary options:kNilOptions error:&error];
    
    if (!error) {
        NSURLSessionDataTask *uploadTask = [self.session uploadTaskWithRequest:request fromData:data completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
            if (data) {
                NSError *parseError;
                NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&parseError];
                if (dictionary) {
                    completionHandler(YES, parseError);
                } else {
                    NSError *err = [NSError errorWithDomain:@"Error Creating Request" code:-1 userInfo:nil];
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

- (void)editRequest:(NSNumber *)idNumber withCompletion:(NetworkingControllerCompletionHandler)completionHandler {
    NSString *urlString = @"https://procurable.azurewebsites.net/requests/Edit/";
    NSURL *url = [NSURL URLWithString:[urlString stringByAppendingString:[idNumber stringValue]]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSDictionary *dictionary = @{
                                 @"Status": @"Approved"
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
                } else {
                    NSError *err = [NSError errorWithDomain:@"Error Editing Request" code:-1 userInfo:nil];
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

- (void)updateRequestStatus:(NSNumber *)idNumber withValue:(NSNumber *)value withCompletion:(NetworkingControllerCompletionHandler)completionHandler {
    NSString *urlString = @"https://procurable.azurewebsites.net/requests/UpdateStatus/";
    NSURL *url = [NSURL URLWithString:[urlString stringByAppendingString:[idNumber stringValue]]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSDictionary *dictionary = @{
                                 @"status": value
                                 };
    
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary options:kNilOptions error:&error];
    
    if (!error) {
        NSURLSessionDataTask *uploadTask = [self.session uploadTaskWithRequest:request fromData:data completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
            if ([data length]) {
                NSError *err = [NSError errorWithDomain:@"Error Updating Request" code:-1 userInfo:nil];
                completionHandler(NO, err);
            } else {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    completionHandler(YES, nil);
                }];
            }
        }];
        [uploadTask resume];
    }
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

- (void)listAllInventoryItems:(ItemsCompletionHandler)completionHandler {
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
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:cookieValue forHTTPHeaderField:@"Cookie"];
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
        if (data) {
            NSError *parseError;
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&parseError];
            if (dictionary) {
                NSArray *arr = [self itemsArray:dictionary];
                completionHandler(arr, parseError);
            } else {
                NSError *err = [NSError errorWithDomain:@"Error Retreiving Items" code:-1 userInfo:nil];
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

- (void)searchForItems:(NSString *)string withCompletion:(SearchItemsCompletionHandler)completionHandler {
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    NSHTTPCookie *appCookie;
    for (NSHTTPCookie *cookie in cookies) {
        if ([cookie.name isEqualToString:@".AspNet.ApplicationCookie"]) {
            appCookie = cookie;
        }
    }
    
    NSString *cookieValue = [[[appCookie name] stringByAppendingString:@"="] stringByAppendingString:[appCookie value]];
    NSString *urlString = @"https://procurable.azurewebsites.net/InventoryItems/Search?query=";
    urlString = [urlString stringByAppendingString:string];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:cookieValue forHTTPHeaderField:@"Cookie"];
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
        if (data) {
            NSError *parseError;
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&parseError];
            if (dictionary) {
                NSArray *arr = [self itemsArray:dictionary];
                completionHandler(YES, arr, parseError);
            } else {
                NSError *err = [NSError errorWithDomain:@"An Error Occurred During Search" code:-1 userInfo:nil];
                completionHandler(NO, [[NSArray alloc] init], err);
            }
        } else if (error) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                completionHandler(NO, [[NSArray alloc] init], error);
            }];
        } else {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                completionHandler(NO, [[NSArray alloc] init], nil);
            }];
        }
    }];
    [dataTask resume];
}

- (void)inventoryItemDetail:(NSNumber *)idNumber withCompletion:(ItemDetailCompletionHandler)completionHandler {
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    NSHTTPCookie *appCookie;
    for (NSHTTPCookie *cookie in cookies) {
        if ([cookie.name isEqualToString:@".AspNet.ApplicationCookie"]) {
            appCookie = cookie;
        }
    }
        
    NSString *cookieValue = [[[appCookie name] stringByAppendingString:@"="] stringByAppendingString:[appCookie value]];
    NSString *urlString = @"https://procurable.azurewebsites.net/InventoryItems/Details/";
    urlString = [urlString stringByAppendingString:[idNumber stringValue]];
    NSURL *URL = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request setHTTPMethod:@"GET"];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:cookieValue forHTTPHeaderField:@"Cookie"];
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
        if (data) {
            NSError *parseError;
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&parseError];
            if (dictionary) {
                InventoryItem *item = [[InventoryItem alloc] initWithDictionary:dictionary];
                completionHandler(item, parseError);
            } else {
                NSError *err = [NSError errorWithDomain:@"Error Getting Inventory Item" code:-1 userInfo:nil];
                completionHandler(nil, err);
            }
        } else if (error) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                completionHandler(nil, error);
            }];
        } else {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                completionHandler(nil, nil);
            }];
        }
    }];
    [dataTask resume];
}

- (NSArray *)itemsArray:(NSDictionary *)dict {
    NSArray *array = (NSArray *)dict;
    NSMutableArray *output = [[NSMutableArray alloc] init];
    for (NSDictionary *dictionary in array) {
        [output addObject:[[InventoryItem alloc] initWithDictionary:dictionary]];
    }
    return output;
}

@end
