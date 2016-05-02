//
//  LoginViewController.m
//  ProcurableApp
//
//  Created by Will Turner on 2/9/16.
//  Copyright © 2016 Wilson Turner. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "LoginViewController.h"
#import "NetworkingController.h"
#import "MBProgressHUD.h"
#import "SearchViewController.h"
#import "MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"

@interface LoginViewController () <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NetworkingController *networkingController;
@property (strong, nonatomic) UITextField *emailTextField;
@property (strong, nonatomic) UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *submitButton;
@property (strong, nonatomic) IBOutlet UILabel *errorLabel;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    [self.emailTextField setDelegate:self];
    [self.passwordTextField setDelegate:self];
    self.networkingController = [[NetworkingController alloc] init];
    [self.errorLabel setHidden:YES];
    [self.submitButton setEnabled:NO];
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideInput)];
    tapGesture.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGesture];
}

- (void)hideInput {
    [self.emailTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

- (void)setLabels {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.errorLabel setHidden:NO];
        [self.errorLabel setText:@"Login Successful"];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self presentMainInterface];
    });
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (self.emailTextField.text.length > 0 && self.passwordTextField.text.length > 0) {
        [self submitButtonTapped:nil];
    }
    
    if (textField == self.emailTextField) {
        [self.passwordTextField becomeFirstResponder];
    } else {
        [self.passwordTextField resignFirstResponder];
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    [self.submitButton setEnabled:NO];
    if (textField == self.emailTextField) {
        if (self.passwordTextField.text.length > 0) {
            if (textField.text.length - range.length + string.length > 0) {
                [self.submitButton setEnabled:YES];
            }
        }
    } else {
        if (self.emailTextField.text.length > 0) {
            if (textField.text.length - range.length + string.length > 0) {
                [self.submitButton setEnabled:YES];
            }
        }
    }
    return YES;
}

- (void)presentMainInterface {
    UIViewController* centerViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
    UIViewController* navigationDrawerViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"NavDrawerViewController"];
    MMDrawerController *drawerController;
    drawerController = [[MMDrawerController alloc] initWithCenterViewController:centerViewController rightDrawerViewController:navigationDrawerViewController];
    
    drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeBezelPanningCenterView;
    drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModePanningCenterView;
    [drawerController setShowsShadow:NO];
    [[[[UIApplication sharedApplication] delegate] window] setRootViewController:drawerController];
}

- (void)setLabels2 {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.errorLabel setHidden:NO];
        [self.errorLabel setText:@"CookieTest Successful"];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    });
}

- (void)errorUpdate:(NSString *)error {
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.errorLabel setHidden:NO];
        [self.errorLabel setText:error];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        // Set the annular determinate mode to show task progress.
        hud.mode = MBProgressHUDModeText;
        [hud setLabelText:@"Login Error"];
        [hud hide:YES afterDelay:2.0f];
    });
}

- (IBAction)submitButtonTapped:(id)sender {
    [self hideInput];
    [self.errorLabel setHidden:YES];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak __typeof(self) weakSelf = self;
    [self.networkingController loginUser:self.emailTextField.text withPassword:self.passwordTextField.text completion:^(BOOL value, NSError * __nullable error) {
        if (value && !error)
        {
            [weakSelf setLabels];
        } else {
            [weakSelf errorUpdate:error.domain];
        }
    }];
}

#pragma mark - Table View Delegate and Datasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *tableIdentifier = @"LoginCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    
    UITextField *textField = (UITextField *)[cell viewWithTag:100];
    switch (indexPath.row) {
        case 0:
            [textField setPlaceholder:@"Email"];
            [textField setKeyboardType:UIKeyboardTypeEmailAddress];
            [textField setAutocorrectionType:UITextAutocorrectionTypeNo];
            [textField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
            [textField setSpellCheckingType:UITextSpellCheckingTypeDefault];
            [textField setDelegate:self];
            self.emailTextField = textField;
            break;
        case 1:
            [textField setPlaceholder:@"Password"];
            [textField setKeyboardType:UIKeyboardTypeDefault];
            [textField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
            [textField setAutocorrectionType:UITextAutocorrectionTypeNo];
            [textField setSpellCheckingType:UITextSpellCheckingTypeNo];
            [textField setSecureTextEntry:YES];
            [textField setDelegate:self];
            self.passwordTextField = textField;
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
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0;
}

@end
