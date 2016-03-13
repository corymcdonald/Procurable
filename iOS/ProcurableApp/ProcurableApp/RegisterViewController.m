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

@interface RegisterViewController ()
@property (strong, nonatomic) NetworkingController *networkingController;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UITextField *confirmPasswordTextField;
@property (strong, nonatomic) IBOutlet UILabel *errorLabel;
@property (strong, nonatomic) IBOutlet UIButton *submitButton;
@property (strong, nonatomic) IBOutlet UIButton *loginRegisterButton;
@property (assign, nonatomic) BOOL isRegister;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.networkingController = [[NetworkingController alloc] init];
    [self.errorLabel setHidden:YES];
    [self.submitButton setEnabled:NO];
    self.isRegister = NO;
    [self.confirmPasswordTextField setHidden:YES];
    [self.loginRegisterButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideInput)];
    tapGesture.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGesture];
    // Do any additional setup after loading the view.
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
    });
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
    if (self.passwordTextField.text.length > 0 && self.emailTextField.text.length > 0 && self.confirmPasswordTextField.text.length > 0) {
        [self.submitButton setEnabled:YES];
    } else {
        [self.submitButton setEnabled:NO];
    }
}

- (IBAction)submitButtonTapped:(id)sender {
    [self hideInput];
    [self.errorLabel setHidden:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hud.opacity = 0.0f;
    __weak __typeof(self) weakSelf = self;
        [self.networkingController registerNewUser:self.emailTextField.text withPassword:self.passwordTextField.text withConfirmPassword:self.confirmPasswordTextField.text completion:^(BOOL value, NSError * __nullable error) {
        if (value && !error)
        {
//            SearchViewController *viewController = [[SearchViewController alloc] init];
//            [weakSelf.navigationController pushViewController:viewController animated:YES];
            [weakSelf setLabels];
        } else {
            [weakSelf errorUpdate:error.domain];
        }
    }];
}

//TODO: TEMPORARY
- (IBAction)loginRegisterButtonTapped:(id)sender {
    [self hideInput];
    [self.errorLabel setHidden:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    hud.opacity = 0.0f;
    __weak __typeof(self) weakSelf = self;
    [self.networkingController temporaryCreateItemWithCompletion:^(BOOL value, NSError * __nullable error) {
        if (value && !error)
        {
            //            SearchViewController *viewController = [[SearchViewController alloc] init];
            //            [weakSelf.navigationController pushViewController:viewController animated:YES];
            [weakSelf setLabels3];
        } else {
            [weakSelf errorUpdate:error.domain];
        }
    }];
    
    
    
//    self.isRegister = !self.isRegister;
//    if (self.isRegister) {
//        [self.confirmPasswordTextField setHidden:NO];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.loginRegisterButton.titleLabel setText:@"Login"];
//        });
//    } else {
//        [self.confirmPasswordTextField setHidden:YES];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.loginRegisterButton.titleLabel setText:@"Register"];
//        });
//    }
}

@end
