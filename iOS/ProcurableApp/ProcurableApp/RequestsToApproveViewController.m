//
//  RequestsToApproveViewController.m
//  ProcurableApp
//
//  Created by Will Turner on 4/4/16.
//  Copyright © 2016 Wilson Turner. All rights reserved.
//

#import "RequestsToApproveViewController.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"
#import "MBProgressHUD.h"
#import "NetworkingController.h"
#import "Request.h"
#import "RequestDetailViewController.h"


@interface RequestsToApproveViewController ()
@property (strong, nonatomic) NetworkingController *networkingController;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *requests;
@property (strong, nonatomic) Request *selectedRequest;

@end

@implementation RequestsToApproveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.networkingController = [[NetworkingController alloc] init];
    [self getRequests];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    //    [self.tableView setBackgroundColor:[UIColor colorWithRed:244/256 green:244/256 blue:244/256 alpha:1.0f]];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationItem setTitle:@"Manage Requests"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)resolve {
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.tableView reloadData];
    });
}

- (void)getRequests {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak __typeof(self) weakSelf = self;
    [self.networkingController listAllRequestsToBeApproved:^(NSArray *requests, NSError * __nullable error) {
        if ([requests count] > 0 && !error)
        {
            weakSelf.requests = requests;
            [weakSelf resolve];
        } else {
            //            [weakSelf errorUpdate:error.domain];
        }
    }];
}

#pragma mark - Table View Delegate and Datasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *tableIdentifier = @"ManagerCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    
    UILabel *mainLabel = (UILabel *)[cell viewWithTag:100];
    UILabel *requestedBy = (UILabel *)[cell viewWithTag:102];
    Request *request = (Request *)[self.requests objectAtIndex:indexPath.row];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMMM d, YYYY"];
    NSString *dateString = [dateFormat stringFromDate:[request createdDate]];
    NSString *labelText = @"";
    
    if ([request idNumber]) {
        labelText = [labelText stringByAppendingString:[[[request idNumber] stringValue] stringByAppendingString:@", "]];
    }
    if ([[request name] isKindOfClass:[NSString class]]) {
        labelText = [[labelText stringByAppendingString:[request name]] stringByAppendingString:@", "];
    }
    if ([[request createdDateDisplay] isKindOfClass:[NSString class]]) {
        labelText = [labelText stringByAppendingString:dateString];
    }
    [mainLabel setText:labelText];
    [requestedBy setText:[[request requestedFor] name]];
    if (!requestedBy.text) {
        [requestedBy setText:@"Name"];
    }
//        [cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.requests count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110.0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedRequest = (Request *)[self.requests objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"ViewRequestDetailSegue" sender:self];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ViewRequestDetailSegue"])
    {
        RequestDetailViewController *vc = [segue destinationViewController];
        [vc setRequest:self.selectedRequest];
        [vc setIsManagerDetail:YES];
    }
}

@end
