//
//  NavDrawerViewController.m
//  ProcurableApp
//
//  Created by Will Turner on 3/27/16.
//  Copyright © 2016 Wilson Turner. All rights reserved.
//

#import "NavDrawerViewController.h"
#import "MMDrawerController.h"
#import "NavButton.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"

@interface NavDrawerViewController ()

@end

@implementation NavDrawerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)logoutPressed {
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *each in cookieStorage.cookies) {
        [cookieStorage deleteCookie:each];
    }
}

- (void)closeDrawer {
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}

- (NSString *)navigationDestination:(NSNumber *)num {
    switch (num.intValue) {
        case 0:
            return @"Main";
        case 1:
            return @"MyRequestsViewController";
        case 2:
            return @"MyRequestsViewController";
        case 3:
            return @"SavedRequestsViewController";
        case 4:
            return @"ViewReportsViewController";
        default:
            break;
    }
    [self logoutPressed];
    return nil;
}

- (IBAction)navigate:(id)sender {
    [self closeDrawer];
    NavButton *button = (NavButton *)sender;
    NSString *destination = [self navigationDestination:button.buttonValue];
    if ([destination length] > 0) {
        UIViewController* centerViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:destination];
        UINavigationController * centerNavigationController = [[UINavigationController alloc] initWithRootViewController:centerViewController];
        MMDrawerBarButtonItem * rightButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(rightPress:)];
        [centerViewController.navigationItem setRightBarButtonItem:rightButton animated:YES];
        [centerViewController.navigationItem setHidesBackButton:YES];
//        MMDrawerController *drawerController;
//        drawerController = [[MMDrawerController alloc] initWithCenterViewController:centerNavigationController rightDrawerViewController:navigationDrawerViewController];
//
//        drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeBezelPanningCenterView;
//        drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModePanningCenterView;
//        [drawerController setShowsShadow:NO];
        
        MMDrawerController *root = (MMDrawerController *)[[[UIApplication sharedApplication] delegate] window].rootViewController;
        [root setCenterViewController:centerNavigationController];
    }
}

- (void)rightPress:(id)stuff {
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}

@end
