//
//  AppDelegate.m
//  ProcurableApp
//
//  Created by Will Turner on 2/9/16.
//  Copyright © 2016 Wilson Turner. All rights reserved.
//

#import "AppDelegate.h"
#import "MMDrawerBarButtonItem.h"
#import "CartSingleton.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    
    // Override point for customization after application launch.
    if ([self isLoggedIn]) {
        [self presentMainInterface];
    } else {
        [self presentWelcomeInterface];
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)isLoggedIn {
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    NSHTTPCookie *appCookie;
    for (NSHTTPCookie *cookie in cookies) {
        if ([cookie.name isEqualToString:@".AspNet.ApplicationCookie"]) {
            appCookie = cookie;
        }
    }
    return [appCookie.value length] != 0;
}

- (void)presentMainInterface {
    UIViewController* centerViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
    UIViewController* navigationDrawerViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"NavDrawerViewController"];
    self.drawerController = [[MMDrawerController alloc] initWithCenterViewController:centerViewController rightDrawerViewController:navigationDrawerViewController];

    self.drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeBezelPanningCenterView;
    self.drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModePanningCenterView;
    [self.drawerController setShowsShadow:NO];
    
    self.window.rootViewController = self.drawerController;
}

- (void)presentWelcomeInterface {
    UIViewController* rootController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"loginScreen"];
    
    UINavigationController* navigation = [[UINavigationController alloc] initWithRootViewController:rootController];
    self.window.rootViewController = navigation;
}

@end
