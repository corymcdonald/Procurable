//
//  LoginViewController.m
//  ProcurableApp
//
//  Created by Will Turner on 2/9/16.
//  Copyright © 2016 Wilson Turner. All rights reserved.
//

#import "LoginViewController.h"
#import "NetworkingController.h"

@interface LoginViewController ()
@property (strong, nonatomic) NetworkingController *networkingController;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *submitButton;

@end

@implementation LoginViewController

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
    [self.networkingController loginUser:self.emailTextField.text withPassword:self.passwordTextField.text completion:^(BOOL value, NSError * __nullable error) {
        if (value && !error)
        {
            [weakSelf setLabels];
        } else {
            [weakSelf setLabelsFailure:error.domain];
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
