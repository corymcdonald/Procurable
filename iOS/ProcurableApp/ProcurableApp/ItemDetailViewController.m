//
//  ItemDetailViewController.m
//  ProcurableApp
//
//  Created by Will Turner on 4/12/16.
//  Copyright © 2016 Wilson Turner. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "MBProgressHUD.h"
#import "CartSingleton.h"

@interface ItemDetailViewController ()
@property (strong, nonatomic) IBOutlet UILabel *itemName;
@property (strong, nonatomic) IBOutlet UILabel *itemNumber;
@property (strong, nonatomic) IBOutlet UILabel *itemIDNumber;
@property (strong, nonatomic) IBOutlet UILabel *itemStatus;
@property (strong, nonatomic) IBOutlet UILabel *itemComments;

@end

@implementation ItemDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.itemName setText:[self.inventoryItem name]];
    [self.itemNumber setText:[self.inventoryItem partNumber]];
    [self.itemIDNumber setText:[[self.inventoryItem idNumber] stringValue]];
    switch ([[self.inventoryItem status] integerValue]) {
        case 0:
            [self.itemStatus setText:@"Allocated"];
            break;
        case 1:
            [self.itemStatus setText:@"Unallocated"];
            break;
        case 2:
            [self.itemStatus setText:@"Deprecated"];
            break;
        default:
            [self.itemStatus setText:@"Status Unknown"];
            break;
    }
    [self.itemComments setText:[self.inventoryItem comments]];
}

- (IBAction)didAddItemToCart:(id)sender {
    CartSingleton *sharedCart = [CartSingleton sharedCart];
    [sharedCart.cart addObject:self.inventoryItem];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
