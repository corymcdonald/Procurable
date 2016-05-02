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

@interface RegisterViewController () <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>
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

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIColor *color = [UIColor grayColor];
    CGColorRef gray = color.CGColor;
    self.bgView.layer.shadowColor = gray;
    self.bgView.layer.shadowOffset = CGSizeMake(0, 5);
    self.bgView.layer.shadowRadius = 2;
    self.bgView.layer.shadowOpacity = 1;
    self.bgView.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bgView.bounds].CGPath;
    self.bgView.layer.masksToBounds = NO;
    
    
    
    self.networkingController = [[NetworkingController alloc] init];
    self.emailTextField.returnKeyType = UIReturnKeyNext;
    self.passwordTextField.returnKeyType = UIReturnKeyNext;
    self.confirmPasswordTextField.returnKeyType = UIReturnKeyNext;
    [self getDepartments];
    [self setDelegatesAndDataSources];
    [self.errorLabel setHidden:YES];
    [self.submitButton setEnabled:NO];
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideInput)];
    tapGesture.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGesture];
    // Do any additional setup after loading the view.
}

- (void)setDelegatesAndDataSources {
    [self.emailTextField setDelegate:self];
    [self.passwordTextField setDelegate:self];
    [self.confirmPasswordTextField setDelegate:self];
    [self.picker setDataSource:self];
    [self.picker setDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)errorUpdate:(NSString *)error {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.errorLabel setHidden:NO];
        [self.errorLabel setText:error];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    });
}

- (IBAction)editText:(id)sender {
    if ([self.picker selectedRowInComponent:0] != 0 && self.passwordTextField.text.length > 0 && self.emailTextField.text.length > 0 && self.confirmPasswordTextField.text.length > 0) {
        [self.submitButton setEnabled:YES];
        self.emailTextField.returnKeyType = UIReturnKeyGo;
        self.passwordTextField.returnKeyType = UIReturnKeyGo;
        self.confirmPasswordTextField.returnKeyType = UIReturnKeyGo;

    } else {
        [self.submitButton setEnabled:NO];
        self.emailTextField.returnKeyType = UIReturnKeyNext;
        self.passwordTextField.returnKeyType = UIReturnKeyNext;
        self.confirmPasswordTextField.returnKeyType = UIReturnKeyNext;
    }
}

- (IBAction)submitButtonTapped:(id)sender {
    [self hideInput];
    [self.errorLabel setHidden:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hud.opacity = 0.0f;
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
    if ([textField returnKeyType] == UIReturnKeyGo) {
        [self submitButtonTapped:nil];
        return YES;
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

- (void)getDepartments {
    [self hideInput];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    hud.opacity = 0.0f;
    __weak __typeof(self) weakSelf = self;
    [self.networkingController fetchDepartmentsForRegister:^(NSArray *names, NSArray *numbers, NSError * __nullable error) {
        if (names && !error)
        {
            [weakSelf pickerUpdate:names];
            weakSelf.departmentNumberArray = numbers;
        } else {
            [weakSelf errorUpdate:@"Error Fetching Departments"];
        }
    }];
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
        self.emailTextField.returnKeyType = UIReturnKeyGo;
        self.passwordTextField.returnKeyType = UIReturnKeyGo;
        self.confirmPasswordTextField.returnKeyType = UIReturnKeyGo;
    } else {
        [self.submitButton setEnabled:NO];
        self.emailTextField.returnKeyType = UIReturnKeyNext;
        self.passwordTextField.returnKeyType = UIReturnKeyNext;
        self.confirmPasswordTextField.returnKeyType = UIReturnKeyNext;
    }
}

@end
