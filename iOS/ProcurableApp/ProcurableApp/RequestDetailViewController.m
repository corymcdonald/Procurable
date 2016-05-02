//
//  RequestDetailViewController.m
//  ProcurableApp
//
//  Created by Will Turner on 3/28/16.
//  Copyright © 2016 Wilson Turner. All rights reserved.
//

#import "RequestDetailViewController.h"
#import "MBProgressHUD.h"
#import "NetworkingController.h"
#import "Item.h"
#import "RequestItemDetailViewController.h"

@interface RequestDetailViewController ()
@property (strong, nonatomic) NetworkingController *networkingController;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIView *statusView;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *requestIDLabel;
@property (strong, nonatomic) IBOutlet UIButton *denyRequestButton;
@property (strong, nonatomic) IBOutlet UIButton *approveRequestButton;
@property (strong, nonatomic) Item *selectedItem;

@end

@implementation RequestDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self updateFields];
    self.networkingController = [[NetworkingController alloc] init];
    NSString *idString = @"ID: ";
    [self.requestIDLabel setText:[idString stringByAppendingString:[self.request.idNumber stringValue]]];
    [self.dateLabel setText:self.request.createdDateDisplay];
    [self.statusLabel setText:self.request.statusDisplay];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.textView setText:self.request.comments];
    if ([self.request.items count] > 0) {
        [self.tableView setHidden:NO];
    } else {
        [self.tableView setHidden:YES];
    }
    if (self.isManagerDetail) {
        [self.denyRequestButton setHidden:NO];
        [self.approveRequestButton setHidden:NO];
    } else {
        [self.denyRequestButton setHidden:YES];
        [self.approveRequestButton setHidden:YES];
    }
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 2 is approve
- (IBAction)approvePressed:(id)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    hud.opacity = 0.0f;
    __weak __typeof(self) weakSelf = self;
    [self.networkingController updateRequestStatus:self.request.idNumber withValue:@2 withCompletion:^(BOOL value, NSError * __nullable error) {
        if (value && !error)
        {
            [weakSelf updateToast:@"Request Approved"];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } else {
            [weakSelf errorUpdate:@"Request Update Failed"];
        }
    }];
}

// 3 is deny
- (IBAction)denyPressed:(id)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    hud.opacity = 0.0f;
    __weak __typeof(self) weakSelf = self;
    [self.networkingController updateRequestStatus:self.request.idNumber withValue:@3 withCompletion:^(BOOL value, NSError * __nullable error) {
        if (value && !error)
        {
            [weakSelf updateToast:@"Request Denied"];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } else {
            [weakSelf errorUpdate:@"Request Update Failed"];
        }
    }];
}

- (void)errorUpdate:(NSString *)error {
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        [hud setLabelText:error];
        [hud hide:YES afterDelay:2.0f];
    });
}

- (void)updateToast:(NSString *)message {
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        [hud setLabelText:message];
        [hud hide:YES afterDelay:2.0f];
    });
}

#pragma mark - Table View Delegate and Datasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *tableIdentifier = @"ItemCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:100];
    [nameLabel setText:[(Item *)[self.request.items objectAtIndex:indexPath.row] name]];
    UILabel *commentsLabel = (UILabel *)[cell viewWithTag:101];
    [commentsLabel setText:[(Item *)[self.request.items objectAtIndex:indexPath.row] comments]];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.request.items count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75.0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedItem = (Item *)[self.request.items objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"RequestItemDetailSegue" sender:self];
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Accessory!");
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"RequestItemDetailSegue"])
    {
        RequestItemDetailViewController *vc = [segue destinationViewController];
        [vc setItem:self.selectedItem];
    }
}

@end
