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
#import "NavDrawerViewController.h"
#import "MMDrawerBarButtonItem.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"
#import "Item.h"
#import "ItemDetailViewController.h"

@interface SearchViewController () <UISearchBarDelegate>
@property (strong, nonatomic) NetworkingController *networkingController;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *items;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) Item *selectedItem;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.networkingController = [[NetworkingController alloc] init];

    MMDrawerBarButtonItem * rightButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(rightPress:)];
    [self getItemsFromSite];
    [self.navigationItem setRightBarButtonItem:rightButton animated:YES];
    [self.searchBar setDelegate:self];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 34)];
//    
//    [imageView setImage:[UIImage imageNamed:@"ProcurableRed"]];
//    [imageView setClipsToBounds:YES];
//    [imageView setContentMode:UIViewContentModeScaleAspectFit];
//    [self.navigationItem.titleView addSubview:imageView];
//    [self.navigationItem setTitleView:imageView];
//    [self.navigationItem.titleView setFrame:CGRectMake(0, 0, 40, 34)];
}

-(void) viewWillAppear:(BOOL)inAnimated {
    NSIndexPath *selected = [self.tableView indexPathForSelectedRow];
    if (selected) {
        [self.tableView deselectRowAtIndexPath:selected animated:NO];
    }
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

- (void)getItemsFromSite {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak __typeof(self) weakSelf = self;
    [self.networkingController listAllInventoryItems:^(NSArray *items, NSError * __nullable error) {
        if ([items count] > 0 && !error)
        {
            weakSelf.items = items;
            [weakSelf resolve];
        } else {
            //            [weakSelf errorUpdate:error.domain];
        }
    }];
}

- (void)isSuccessful {
    NSLog(@"Success");
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    });
}

- (void)rightPress:(id)stuff {
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}

#pragma mark - Table View Delegate and Datasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *tableIdentifier = @"SearchCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    
    UILabel *mainLabel = (UILabel *)[cell viewWithTag:100];
    UILabel *idLabel = (UILabel *)[cell viewWithTag:101];
    UILabel *availabilityLabel = (UILabel *)[cell viewWithTag:102];
    Item *item = (Item *)[self.items objectAtIndex:indexPath.row];
    [mainLabel setText:[item name]];
    [idLabel setText:[[item idNumber] stringValue]];
    [availabilityLabel setText:@"No"];
    if (item.inInventory) {
        [availabilityLabel setText:@"Yes"];
    }
//    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//    [dateFormat setDateFormat:@"MMMM d, YYYY"];
//    NSString *dateString = [dateFormat stringFromDate:[item createdDate]];
//    NSString *labelText = [[[[[[item idNumber] stringValue] stringByAppendingString:@", "] stringByAppendingString:[request name]] stringByAppendingString:@", "] stringByAppendingString:dateString];
//    mainLabel.text = labelText;
//    progressLabel.text = [item statusDisplay];
    //    [cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.items count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedItem = (Item *)[self.items objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"ItemDetailSegue" sender:self];
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    self.selectedItem = (Item *)[self.items objectAtIndex:indexPath.row];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak __typeof(self) weakSelf = self;
    [self.networkingController searchForItems:[searchBar text] withCompletion:^(NSArray *items, NSError * __nullable error) {
        if ([items count] > 0 && !error)
        {
            weakSelf.items = items;
            [weakSelf resolve];
        } else {
            //            [weakSelf errorUpdate:error.domain];
        }
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ItemDetailSegue"])
    {
        ItemDetailViewController *vc = [segue destinationViewController];
        [vc setItem:self.selectedItem];
        [vc setIsRequestItem:NO];
    }
}

@end
