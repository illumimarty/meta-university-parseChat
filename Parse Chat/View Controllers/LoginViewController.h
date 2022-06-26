//
//  LoginViewController.h
//  Parse Chat
//
//  Created by Marthan Nodado on 6/25/22.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : ViewController
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
- (IBAction)loginUser:(id)sender;
- (IBAction)registerUser:(id)sender;

@end

NS_ASSUME_NONNULL_END
