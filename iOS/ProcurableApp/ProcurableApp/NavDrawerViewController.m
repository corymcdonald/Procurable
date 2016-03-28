//
//  NavDrawerViewController.m
//  ProcurableApp
//
//  Created by Will Turner on 3/27/16.
//  Copyright © 2016 Wilson Turner. All rights reserved.
//

#import "NavDrawerViewController.h"
#import "MMDrawerController.h"

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

- (IBAction)logoutPressed:(id)sender {
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *each in cookieStorage.cookies) {
        [cookieStorage deleteCookie:each];
    }
}

- (IBAction)searchPressed:(id)sender {
    [[self navigationController] popToRootViewControllerAnimated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([segue.identifier isEqualToString:@"DRAWER_SEGUE"]) {
//        MMDrawerController *destinationViewController = (MMDrawerController *)segue.destinationViewController;
//        
//        // Instantitate and set the center view controller.
//        UIViewController *centerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FIRST_TOP_VIEW_CONTROLLER"];
//        [destinationViewController setCenterViewController: centerViewController];
//        
//        // Instantiate and set the left drawer controller.
//        UIViewController *leftDrawerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SIDE_DRAWER_CONTROLLER"];
//        [destinationViewController setLeftDrawerViewController: leftDrawerViewController];
//    }
}

@end
