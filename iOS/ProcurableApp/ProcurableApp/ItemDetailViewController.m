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
#import "RequestItem.h"

@interface ItemDetailViewController () <UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *itemName;
@property (strong, nonatomic) IBOutlet UILabel *itemNumber;
@property (strong, nonatomic) IBOutlet UILabel *itemIDNumber;
@property (strong, nonatomic) IBOutlet UILabel *itemStatus;
@property (strong, nonatomic) IBOutlet UILabel *itemComments;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *positionConstraint;
@property (strong, nonatomic) IBOutlet UITextView *requestComments;
@property (strong, nonatomic) IBOutlet UITextField *requestCount;
@property (strong, nonatomic) IBOutlet UIStackView *lowerStack;
@property (strong, nonatomic) IBOutlet UIStackView *upperStack;
@property (strong, nonatomic) IBOutlet UIButton *addItemButton;

@end

@implementation ItemDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.itemName setText:[self.inventoryItem name]];
    [self.requestComments setDelegate:self];
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
    
    
    
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleDefault;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelNumberPad)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    [self.requestCount setInputAccessoryView:numberToolbar];
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideInput)];
    tapGesture.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGesture];
}

- (void)cancelNumberPad {
    [self.requestCount resignFirstResponder];
    self.requestCount.text = @"";
}

- (void)hideInput {
    [self.requestComments resignFirstResponder];
    [self.requestCount resignFirstResponder];
}

- (void)doneWithNumberPad {
    [self.requestCount resignFirstResponder];
    [self.requestComments becomeFirstResponder];
}

- (IBAction)didAddItemToCart:(id)sender {
    CartSingleton *sharedCart = [CartSingleton sharedCart];
    if ([self.requestCount.text length]) {
        [sharedCart addItem:[[RequestItem alloc] initWithName:[self.inventoryItem name] comments:[self.requestComments text] url:[self.inventoryItem vendorWebsite] count:[[self.requestCount text] integerValue]]];
    } else {
        [sharedCart addItem:[[RequestItem alloc] initWithName:[self.inventoryItem name] comments:[self.requestComments text] url:[self.inventoryItem vendorWebsite] count:1]];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
    [UIView animateWithDuration:0.3f animations:^{
        [self.lowerStack setFrame:CGRectMake(self.lowerStack.frame.origin.x, self.lowerStack.frame.origin.y - 158, self.lowerStack.frame.size.width, self.lowerStack.frame.size.height)];
        [self.upperStack setFrame:CGRectMake(self.upperStack.frame.origin.x, self.upperStack.frame.origin.y - 158, self.upperStack.frame.size.width, self.upperStack.frame.size.height)];
        [self.addItemButton setFrame:CGRectMake(self.addItemButton.frame.origin.x, self.addItemButton.frame.origin.y - 158, self.addItemButton.frame.size.width, self.addItemButton.frame.size.height)];
        [self.positionConstraint setConstant:-150.0f];
    }];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    [UIView animateWithDuration:0.3f animations:^{
        [self.lowerStack setFrame:CGRectMake(self.lowerStack.frame.origin.x, self.lowerStack.frame.origin.y + 158, self.lowerStack.frame.size.width, self.lowerStack.frame.size.height)];
        [self.upperStack setFrame:CGRectMake(self.upperStack.frame.origin.x, self.upperStack.frame.origin.y + 158, self.upperStack.frame.size.width, self.upperStack.frame.size.height)];
        [self.addItemButton setFrame:CGRectMake(self.addItemButton.frame.origin.x, self.addItemButton.frame.origin.y + 158, self.addItemButton.frame.size.width, self.addItemButton.frame.size.height)];
        [self.positionConstraint setConstant:8.0f];
    }];
}

@end
