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
#import "NetworkingController.h"
#import "MBProgressHUD.h"
#import "CreateRequest.h"

@interface CreateRequestViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *requestItemsTableView;
@property (strong, nonatomic) IBOutlet UITableView *createRequestTableView;
@property (strong, nonatomic) IBOutlet UIButton *addItemButton;
@property (strong, nonatomic) UITextField *requestName;
@property (strong, nonatomic) UITextField *requestComments;
@property (strong, nonatomic) NSIndexPath *selectedCell;
@property (strong, nonatomic) CartSingleton *sharedCart;
@property (strong, nonatomic) UIAlertController *alert;
@property (strong, nonatomic) NetworkingController *networkingController;

@end

@implementation CreateRequestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.requestItemsTableView setDelegate:self];
    [self.requestItemsTableView setDataSource:self];
    [self.createRequestTableView setDelegate:self];
    [self.createRequestTableView setDataSource:self];
    self.networkingController = [[NetworkingController alloc] init];
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideInput)];
    tapGesture.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGesture];
    self.automaticallyAdjustsScrollViewInsets = false;
    self.sharedCart = [CartSingleton sharedCart];
    
    
    self.requestItemsTableView.allowsMultipleSelectionDuringEditing = NO;
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.requestItemsTableView reloadData];
}

- (void)hideInput {
    [self.requestName resignFirstResponder];
    [self.requestComments resignFirstResponder];
}

#pragma mark - Table View Delegate and Datasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.createRequestTableView) {
        static NSString *tableIdentifier = @"CreateRequest";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
        }
        UITextField *textField = (UITextField *)[cell viewWithTag:100];
        switch (indexPath.row) {
            case 0:
                [textField setPlaceholder:@"Request Name"];
                self.requestName = textField;
                break;
            case 1:
                [textField setPlaceholder:@"Request Comments"];
                self.requestComments = textField;
                break;
            default:
                [textField setPlaceholder:@"Text"];
                break;
        }
        return cell;
    }
    static NSString *tableIdentifier = @"RequestItems";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    
    RequestItem *item = [self.sharedCart getItem:[indexPath row]];
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:400];
    [nameLabel setText:[item name]];
    UILabel *urlLabel = (UILabel *)[cell viewWithTag:401];
    [urlLabel setText:[item url]];
    UILabel *commentLabel = (UILabel *)[cell viewWithTag:402];
    [commentLabel setText:[item comments]];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.createRequestTableView) {
        return NO;
    }
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.sharedCart removeItem:[indexPath row]];
        [self.requestItemsTableView reloadData];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedCell = indexPath;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.createRequestTableView) {
        return 2;
    }
    return [self.sharedCart count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView == self.createRequestTableView) {
        return @"Create Request";
    }
    return @"Selected Items";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.createRequestTableView) {
        return 44.0;
    }
    return 75.0;
}

- (IBAction)createRequestTapped:(id)sender {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self hideInput];
    __weak __typeof(self) weakSelf = self;
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (int i = 0; i < [self.sharedCart count]; i++) {
        NSArray *itemArray = [[self.sharedCart getItem:i] generateItems];
        for (int j = 0; j < [itemArray count]; j++) {
            [arr addObject:[itemArray objectAtIndex:j]];
        }
    }
    CreateRequest *request = [[CreateRequest alloc] initWithItems:arr name:self.requestName.text comments:self.requestComments.text];
    [self.networkingController createRequest:request withCompletion:^(BOOL success, NSError * __nullable error) {
        if (success && !error)
        {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            NSLog(@"Stuff");
        } else {
            //            [weakSelf errorUpdate:error.domain];
        }
    }];
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
