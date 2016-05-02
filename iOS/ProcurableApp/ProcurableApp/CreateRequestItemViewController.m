//
//  CreateRequestItemViewController.m
//  ProcurableApp
//
//  Created by Will Turner on 5/1/16.
//  Copyright © 2016 Wilson Turner. All rights reserved.
//

#import "CreateRequestItemViewController.h"
#import "CartSingleton.h"
#import "RequestItem.h"

@interface CreateRequestItemViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UITextField *name;
@property (strong, nonatomic) UITextField *comments;
@property (strong, nonatomic) UITextField *url;
@property (strong, nonatomic) UITextField *count;
@property (strong, nonatomic) CartSingleton *sharedCart;

@end

@implementation CreateRequestItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = false;
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    self.sharedCart = [CartSingleton sharedCart];
    
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideInput)];
    tapGesture.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGesture];
}

- (void)hideInput {
    [self.name resignFirstResponder];
    [self.comments resignFirstResponder];
    [self.url resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.name) {
        [self.comments becomeFirstResponder];
    } else if (textField == self.comments) {
        [self.url becomeFirstResponder];
    } else {
        [self.url resignFirstResponder];
    }
    return YES;
}

#pragma mark - Table View Delegate and Datasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *tableIdentifier = @"CreateRequestItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    
    UITextField *textField = (UITextField *)[cell viewWithTag:300];
    switch (indexPath.row) {
        case 0:
            [textField setPlaceholder:@"Name"];
            self.name = textField;
            break;
        case 1:
            [textField setPlaceholder:@"Comments"];
            [textField setAutocapitalizationType:UITextAutocapitalizationTypeSentences];
            [textField setAutocorrectionType:UITextAutocorrectionTypeDefault];
            self.comments = textField;
            break;
        case 2:
            [textField setPlaceholder:@"URL"];
            [textField setKeyboardType:UIKeyboardTypeWebSearch];
            self.url = textField;
            break;
        case 3:
            [textField setPlaceholder:@"Quantity"];
            [textField setKeyboardType:UIKeyboardTypeNumberPad];
            self.url = textField;
            break;
        default:
            [textField setPlaceholder:@"Text"];
            break;
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Create Item";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0;
}

- (IBAction)createButtonTapped:(id)sender {
    [self hideInput];
    [self.sharedCart addItem:[[RequestItem alloc] initWithName:self.name.text comments:self.comments.text url:self.url.text count:[self.count.text intValue]]];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
