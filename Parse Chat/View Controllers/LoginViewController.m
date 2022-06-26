//
//  LoginViewController.m
//  Parse Chat
//
//  Created by Marthan Nodado on 6/25/22.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)registerUser:(id)sender {
    
    // Check if fields are empty. If YES, do not continue to block
    if ([self isEitherFieldEmpty]) {
        [self showEmptyFieldAlert];
        return;
    }
    
    // initialize a user object
    PFUser *newUser = [PFUser user];
    
    // set user properties
    newUser.username = self.usernameTextField.text;
//    newUser.email = self.emailField.text; // don't neet a email for this app
    newUser.password = self.passwordTextField.text;
    
    // call sign up function on the object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"User registered successfully");
            
            // manually segue to logged in view
        }
    }];
}

- (IBAction)loginUser:(id)sender {
    
    // Check if fields are empty. If YES, do not continue to block
    if ([self isEitherFieldEmpty]) {
        [self showEmptyFieldAlert];
        return;
    }
    
    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
        } else {
            NSLog(@"User logged in successfully");
            
            // display view controller that needs to shown after successful login
        }
    }];
}

- (void) showEmptyFieldAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"One of the text fields are empty!" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    // create an OK action
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        // handle response here.
    }];
    // add the OK action to the alert controller
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:YES completion:^{}];
}

- (bool)isEitherFieldEmpty {
    return ([self.usernameTextField.text isEqual:@""] || [self.passwordTextField.text isEqual:@""]);
}

@end
