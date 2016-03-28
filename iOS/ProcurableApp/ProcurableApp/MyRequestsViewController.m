//
//  MyRequestsViewController.m
//  ProcurableApp
//
//  Created by Will Turner on 3/28/16.
//  Copyright © 2016 Wilson Turner. All rights reserved.
//

#import "MyRequestsViewController.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"

@interface MyRequestsViewController ()

@end

@implementation MyRequestsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    UIViewController* centerViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"MyRequestsViewController"];
//    UIViewController* navigationDrawerViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"NavDrawerViewController"];
//    MMDrawerController *drawerController;
//    drawerController = [[MMDrawerController alloc] initWithCenterViewController:centerViewController leftDrawerViewController:navigationDrawerViewController];
//    
//    drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeBezelPanningCenterView;
//    drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModePanningCenterView;
//    [drawerController setShowsShadow:NO];
//}

@end
