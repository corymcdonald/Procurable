//
//  RegisterViewController.m
//  ProcurableApp
//
//  Created by Will Turner on 2/22/16.
//  Copyright © 2016 Wilson Turner. All rights reserved.
//

#import "RegisterViewController.h"
#import "NetworkingController.h"
#import "MBProgressHUD.h"
#import "SearchViewController.h"
#import "MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"

@interface RegisterViewController () <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NetworkingController *networkingController;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UITextField *confirmPasswordTextField;
@property (strong, nonatomic) IBOutlet UILabel *errorLabel;
@property (strong, nonatomic) IBOutlet UIButton *submitButton;
@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutlet UIPickerView *picker;
@property (assign, nonatomic) NSInteger selectedDepartment;
@property (strong, nonatomic) NSArray *departmentNumberArray;
@property (strong, nonatomic) NSArray *departmentArray;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.networkingController = [[NetworkingController alloc] init];
    [self getDepartments];
    [self setDelegatesAndDataSources];
    [self.errorLabel setHidden:YES];
    [self.submitButton setEnabled:NO];
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideInput)];
    tapGesture.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGesture];
}

- (void)setDelegatesAndDataSources {
    [self.emailTextField setDelegate:self];
    [self.passwordTextField setDelegate:self];
    [self.confirmPasswordTextField setDelegate:self];
    [self.picker setDataSource:self];
    [self.picker setDelegate:self];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
}

- (void)hideInput {
    [self.emailTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.confirmPasswordTextField resignFirstResponder];
}

- (void)setLabels {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.errorLabel setHidden:NO];
        [self.errorLabel setText:@"Registration Successful"];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self presentMainInterface];
    });
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

- (void)setLabels3 {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.errorLabel setHidden:NO];
        [self.errorLabel setText:@"Set Successful"];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    });
}

- (void)resetLabels {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.errorLabel setText:@"An error has occurred"];
    });
}

- (IBAction)submitButtonTapped:(id)sender {
    [self hideInput];
    [self.errorLabel setHidden:YES];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak __typeof(self) weakSelf = self;
    [self.networkingController registerNewUser:self.emailTextField.text withPassword:self.passwordTextField.text withConfirmPassword:self.confirmPasswordTextField.text withDepartmentNumber:[NSNumber numberWithInteger:self.selectedDepartment] withcompletion:^(BOOL value, NSError * __nullable error) {
        if (value && !error)
        {
            [weakSelf setLabels];
        } else {
            [weakSelf errorUpdate:error.domain];
        }
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (self.emailTextField.text.length > 0 && self.passwordTextField.text.length > 0 && self.confirmPasswordTextField.text.length > 0 && [self.picker selectedRowInComponent:0] != 0) {
        [self submitButtonTapped:nil];
    }
    
    if (textField == self.emailTextField) {
        [self.passwordTextField becomeFirstResponder];
    } else if (textField == self.passwordTextField) {
        [self.confirmPasswordTextField becomeFirstResponder];
    } else {
        [self.confirmPasswordTextField resignFirstResponder];
    }
    return YES;
}

- (void)errorUpdate:(NSString *)error {
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.errorLabel setHidden:NO];
        [self.errorLabel setText:error];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        // Set the annular determinate mode to show task progress.
        hud.mode = MBProgressHUDModeText;
        [hud setLabelText:@"Registration Error"];
        [hud hide:YES afterDelay:2.0f];
    });
}

- (void)departmentErrorUpdate:(NSString *)error {
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.errorLabel setHidden:NO];
        [self.errorLabel setText:error];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        // Set the annular determinate mode to show task progress.
        hud.mode = MBProgressHUDModeText;
        [hud setLabelText:@"Error Fetching Departments"];
        [hud hide:YES afterDelay:2.0f];
    });
}

- (void)getDepartments {
    [self hideInput];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak __typeof(self) weakSelf = self;
    [self.networkingController fetchDepartmentsForRegister:^(NSArray *names, NSArray *numbers, NSError * __nullable error) {
        if (names && !error)
        {
            [weakSelf pickerUpdate:names];
            weakSelf.departmentNumberArray = numbers;
        } else {
            [weakSelf departmentErrorUpdate:@"Server Error"];
        }
    }];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    [self.submitButton setEnabled:NO];
    if (textField == self.emailTextField) {
        if (self.passwordTextField.text.length > 0 && self.confirmPasswordTextField.text.length > 0) {
            if (textField.text.length - range.length + string.length > 0) {
                [self.submitButton setEnabled:YES];
            }
        }
    } else if (textField == self.passwordTextField) {
        if (self.emailTextField.text.length > 0 && self.confirmPasswordTextField.text.length > 0) {
            if (textField.text.length - range.length + string.length > 0) {
                [self.submitButton setEnabled:YES];
            }
        }
    } else {
        if (self.emailTextField.text.length > 0 && self.passwordTextField.text.length > 0) {
            if (textField.text.length - range.length + string.length > 0) {
                [self.submitButton setEnabled:YES];
            }
        }
    }
    return YES;
}

#pragma mark - Table View Delegate and Datasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *tableIdentifier = @"RegisterCell";
    
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
        case 2:
            [textField setPlaceholder:@"Confirm Password"];
            [textField setKeyboardType:UIKeyboardTypeDefault];
            [textField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
            [textField setAutocorrectionType:UITextAutocorrectionTypeNo];
            [textField setSpellCheckingType:UITextSpellCheckingTypeNo];
            [textField setSecureTextEntry:YES];
            [textField setDelegate:self];
            self.confirmPasswordTextField = textField;
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
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0;
}

#pragma Picker

- (void)pickerUpdate:(NSArray *)array {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.departmentArray = array;
        [self.picker reloadComponent:0];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    });
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.departmentArray count] + 1;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *string = @"Select a department";
    if (pickerView == self.picker && row > 0) {
        string = [self.departmentArray objectAtIndex:row - 1];
    }
    return string;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectedDepartment = -1;
    if (row > 0) {
        self.selectedDepartment = [[self.departmentNumberArray objectAtIndex:row - 1] integerValue];
    }
    if ([self.picker selectedRowInComponent:0] != 0 && self.passwordTextField.text.length > 0 && self.emailTextField.text.length > 0 && self.confirmPasswordTextField.text.length > 0) {
        [self.submitButton setEnabled:YES];
    } else {
        [self.submitButton setEnabled:NO];
    }
}

@end
