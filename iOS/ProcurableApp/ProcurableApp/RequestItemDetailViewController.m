//
//  RequestItemDetailViewController.m
//  ProcurableApp
//
//  Created by Will Turner on 4/29/16.
//  Copyright © 2016 Wilson Turner. All rights reserved.
//

#import "RequestItemDetailViewController.h"
#import "ItemDetailViewController.h"
#import "MBProgressHUD.h"

@interface RequestItemDetailViewController ()
@property (strong, nonatomic) IBOutlet UILabel *itemName;
@property (strong, nonatomic) IBOutlet UILabel *itemURL;
@property (strong, nonatomic) IBOutlet UILabel *itemStatus;
@property (strong, nonatomic) IBOutlet UILabel *itemComments;

@end

@implementation RequestItemDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.itemName setText:[self.item name]];
    [self.itemURL setText:[self.item url]];
    if ([self.item inInventory]) {
        [self.itemStatus setText:@"In Inventory"];
    } else {
        [self.itemStatus setText:@"Not In Inventory"];
    }
    [self.itemComments setText:[self.item comments]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
