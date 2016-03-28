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

@interface SearchViewController ()
@property (strong, nonatomic) NetworkingController *networkingController;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.networkingController = [[NetworkingController alloc] init];
    // Do any additional setup after loading the view.
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

@end
