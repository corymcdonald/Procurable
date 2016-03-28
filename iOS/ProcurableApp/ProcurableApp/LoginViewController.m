//
//  LoginViewController.m
//  ProcurableApp
//
//  Created by Will Turner on 2/9/16.
//  Copyright © 2016 Wilson Turner. All rights reserved.
//

#import "LoginViewController.h"
#import "NetworkingController.h"
#import "MBProgressHUD.h"
#import "SearchViewController.h"
#import "MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"

@interface LoginViewController ()
@property (strong, nonatomic) NetworkingController *networkingController;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *submitButton;
@property (strong, nonatomic) IBOutlet UILabel *errorLabel;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.networkingController = [[NetworkingController alloc] init];
    [self.errorLabel setHidden:YES];
    [self.submitButton setEnabled:NO];
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
}

- (void)setLabels {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.errorLabel setHidden:NO];
        [self.errorLabel setText:@"Login Successful"];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self presentMainInterface];
    });
}

- (void)presentMainInterface {
    UIViewController* centerViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
    UIViewController* navigationDrawerViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"NavDrawerViewController"];
//    MMDrawerBarButtonItem * leftButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(leftPress:)];
//    [centerViewController.navigationItem setLeftBarButtonItem:leftButton animated:YES];
    MMDrawerController *drawerController;
    drawerController = [[MMDrawerController alloc] initWithCenterViewController:centerViewController leftDrawerViewController:navigationDrawerViewController];
    
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
    if (self.passwordTextField.text.length > 0 && self.emailTextField.text.length > 0) {
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
    [self.networkingController loginUser:self.emailTextField.text withPassword:self.passwordTextField.text completion:^(BOOL value, NSError * __nullable error) {
        if (value && !error)
        {
            [weakSelf setLabels];
        } else {
            [weakSelf errorUpdate:error.domain];
        }
    }];
}

@end
