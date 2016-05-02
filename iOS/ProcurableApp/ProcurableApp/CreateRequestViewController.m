//
//  CreateRequestViewController.m
//  ProcurableApp
//
//  Created by Will Turner on 4/12/16.
//  Copyright © 2016 Wilson Turner. All rights reserved.
//

#import "CreateRequestViewController.h"
#import "RequestItem.h"
#import "CartSingleton.h"

@interface CreateRequestViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *createItemTableView;
@property (strong, nonatomic) IBOutlet UITableView *requestItemsTableView;

@property (strong, nonatomic) UITextField *name;
@property (strong, nonatomic) UITextField *comments;
@property (strong, nonatomic) UITextField *url;
@property (strong, nonatomic) NSIndexPath *selectedCell;
@property (strong, nonatomic) CartSingleton *sharedCart;

@end

@implementation CreateRequestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.createItemTableView setDelegate:self];
    [self.createItemTableView setDataSource:self];
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideInput)];
    tapGesture.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGesture];
    self.sharedCart = [CartSingleton sharedCart];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)hideInput {
    [self.createItemTableView resignFirstResponder];
    [self.name resignFirstResponder];
    [self.comments resignFirstResponder];
    [self.url resignFirstResponder];
}

#pragma mark - Table View Delegate and Datasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *tableIdentifier = @"CreateRequestItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    
    if ([indexPath section] == 0) {
        UITextField *textField = (UITextField *)[cell viewWithTag:100];
        switch (indexPath.row) {
            case 0:
                [textField setPlaceholder:@"Request Name"];
                self.name = textField;
                break;
            case 1:
                [textField setPlaceholder:@"Request Comments"];
                self.comments = textField;
                break;
            default:
                [textField setPlaceholder:@"Text"];
                break;
        }
    } else if ([indexPath section] == 1) {
        UITextField *textField = (UITextField *)[cell viewWithTag:100];
        switch (indexPath.row) {
            case 0:
                [textField setPlaceholder:@"Item Name"];
                self.name = textField;
                break;
            case 1:
                [textField setPlaceholder:@"Item Comments"];
                self.comments = textField;
                break;
            case 2:
                [textField setPlaceholder:@"Item URL"];
                self.url = textField;
                break;
            default:
                [textField setPlaceholder:@"Text"];
                break;
        }
    }
    //    [availabilityLabel setText:@"No"];
    //    if (item.inInventory) {
    //        [availabilityLabel setText:@"Yes"];
    //    }
    //    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    //    [dateFormat setDateFormat:@"MMMM d, YYYY"];
    //    NSString *dateString = [dateFormat stringFromDate:[item createdDate]];
    //    NSString *labelText = [[[[[[item idNumber] stringValue] stringByAppendingString:@", "] stringByAppendingString:[request name]] stringByAppendingString:@", "] stringByAppendingString:dateString];
    //    mainLabel.text = labelText;
    //    progressLabel.text = [item statusDisplay];
    //    [cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedCell = indexPath;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.createItemTableView) {
        return 2;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.createItemTableView) {
        if (section == 0) {
            return 2;
        }
        return 3;
    }
    return [self.sharedCart count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView == self.createItemTableView) {
        if (section == 0) {
            return @"Request";
        }
        return @"Item";
    }
    return @"Selected Items";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.createItemTableView) {
        return 44.0;
    }
    return 75.0;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
