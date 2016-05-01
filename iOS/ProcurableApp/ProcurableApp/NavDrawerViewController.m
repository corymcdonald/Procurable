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
#import "MBProgressHUD.h"
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
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Logout" message:@"Are you sure you want to logout?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *logout = [UIAlertAction actionWithTitle:@"Logout" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (NSHTTPCookie *each in cookieStorage.cookies) {
            [cookieStorage deleteCookie:each];
        }
        [self presentWelcomeInterface];
    }];
    [alert addAction:cancel];
    [alert addAction:logout];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)presentWelcomeInterface {
    UIViewController* rootController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"loginScreen"];
    UINavigationController* navigation = [[UINavigationController alloc] initWithRootViewController:rootController];
    [[[[UIApplication sharedApplication] delegate] window] setRootViewController:navigation];
}

- (void)closeDrawer {
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}

- (NSString *)navigationDestination:(NSNumber *)num {
    switch (num.intValue) {
        case 0:
            return @"Main";
        case 1:
            return @"RequestsToApproveViewController";
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
        [[[centerNavigationController navigationController] navigationBar] setBackgroundColor:[UIColor colorWithRed:244/256 green:67/256 blue:54/256 alpha:1.0f]];
        MMDrawerBarButtonItem * rightButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(rightPress:)];
        [centerViewController.navigationItem setRightBarButtonItem:rightButton animated:YES];
        [centerViewController.navigationItem setHidesBackButton:YES];
//        UIView *titleView = [[UIView alloc] init];
//        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ProcurableRed"]];
//        [imageView setContentMode:UIViewContentModeScaleAspectFit];
//        [titleView addSubview:imageView];
//        
//        [titleView addConstraint:[NSLayoutConstraint constraintWithItem:titleView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:imageView attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f]];
//        [titleView addConstraint:[NSLayoutConstraint constraintWithItem:titleView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:imageView attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
//        [imageView addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:50]];
//        
//        [centerNavigationController.navigationItem setTitleView:titleView];
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
