//
//  ItemDetailViewController.m
//  ProcurableApp
//
//  Created by Will Turner on 4/12/16.
//  Copyright © 2016 Wilson Turner. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "NetworkingController.h"
#import "MBProgressHUD.h"

@interface ItemDetailViewController ()
@property (strong, nonatomic) NetworkingController *networkingController;

@end

@implementation ItemDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.networkingController = [[NetworkingController alloc] init];
    [self fetchItemDetails];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fetchItemDetails {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    hud.opacity = 0.0f;
    __weak __typeof(self) weakSelf = self;
    [self.networkingController inventoryItemDetail:self.item.idNumber withCompletion:^(Item * __nullable item, NSError * __nullable error) {
        if (item && !error) 
        {
            NSLog(@"Denied");
        } else {
            NSLog(error.domain);
        }
    }];
}

@end
