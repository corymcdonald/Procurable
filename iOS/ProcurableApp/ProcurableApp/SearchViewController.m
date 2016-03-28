//
//  SearchViewController.m
//  ProcurableApp
//
//  Created by Will Turner on 2/25/16.
//  Copyright © 2016 Wilson Turner. All rights reserved.
//

#import "SearchViewController.h"
#import "NetworkingController.h"
#import "MBProgressHUD.h"
#import "NavDrawerViewController.h"
#import "MMDrawerBarButtonItem.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"

@interface SearchViewController ()
@property (strong, nonatomic) NetworkingController *networkingController;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.networkingController = [[NetworkingController alloc] init];

    MMDrawerBarButtonItem * rightButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(rightPress:)];
    [self.navigationItem setRightBarButtonItem:rightButton animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)isSuccessful {
    NSLog(@"Success");
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    });
}

- (IBAction)fetchShit:(id)sender {
     MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak __typeof(self) weakSelf = self;
    [self.networkingController listAllRequests:^(BOOL value, NSError * __nullable error) {
        if (value && !error)
        {
            [weakSelf isSuccessful];
        } else {
            ;
        }
    }];
}

- (void)rightPress:(id)stuff {
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}

@end
