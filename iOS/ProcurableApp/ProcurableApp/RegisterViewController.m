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

@interface RegisterViewController ()
@property (strong, nonatomic) NetworkingController *networkingController;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UITextField *confirmPasswordTextField;
@property (strong, nonatomic) IBOutlet UILabel *errorLabel;
@property (strong, nonatomic) IBOutlet UIButton *submitButton;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.networkingController = [[NetworkingController alloc] init];
    [self.errorLabel setHidden:YES];
    [self.submitButton setEnabled:NO];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setLabels {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.errorLabel setHidden:NO];
        [self.errorLabel setText:@"Registration Successful"];
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
    [self.passwordTextField resignFirstResponder];
    [self.errorLabel setHidden:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hud.opacity = 0.0f;
    __weak __typeof(self) weakSelf = self;
        [self.networkingController registerNewUser:self.emailTextField.text withPassword:self.passwordTextField.text withConfirmPassword:self.confirmPasswordTextField.text completion:^(BOOL value, NSError * __nullable error) {
        if (value && !error)
        {
            [weakSelf setLabels];
        } else {
            [weakSelf errorUpdate:error.domain];
        }
    }];
}

@end
