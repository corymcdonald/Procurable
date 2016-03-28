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

@interface SearchViewController ()
@property (strong, nonatomic) NetworkingController *networkingController;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.networkingController = [[NetworkingController alloc] init];

    MMDrawerBarButtonItem * leftButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(leftPress:)];
    [self.navigationItem setLeftBarButtonItem:leftButton animated:YES];
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

-(MMDrawerController*)mm_drawerController{
    UIViewController *parentViewController = self.parentViewController;
    while (parentViewController != nil) {
        if([parentViewController isKindOfClass:[MMDrawerController class]]){
            return (MMDrawerController *)parentViewController;
        }
        parentViewController = parentViewController.parentViewController;
    }
    return nil;
}

- (void)leftPress:(id)stuff {
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

@end
