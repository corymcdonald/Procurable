//
//  RegisterViewController.m
//  ProcurableApp
//
//  Created by Will Turner on 2/22/16.
//  Copyright © 2016 Wilson Turner. All rights reserved.
//

#import "RegisterViewController.h"
#import "NetworkingController.h"

@interface RegisterViewController ()
@property (strong, nonatomic) NetworkingController *networkingController;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UITextField *confirmPasswordTextField;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.networkingController = [[NetworkingController alloc] init];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setLabels {
    NSLog(@"Do The Thing!");
}

- (void)setLabelsFailure:(NSString *)error {
    NSLog(@"The Thing Broke!");
}

- (IBAction)submitButtonTapped:(id)sender {
    [self.passwordTextField resignFirstResponder];
    __weak __typeof(self) weakSelf = self;
        [self.networkingController registerNewUser:self.emailTextField.text withPassword:self.passwordTextField.text withConfirmPassword:self.confirmPasswordTextField.text completion:^(BOOL value, NSError * __nullable error) {
        if (value && !error)
        {
            [weakSelf setLabels];
        } else {
            [weakSelf setLabelsFailure:error.domain];
        }
    }];
}

@end
