//
//  ChatViewController.m
//  Parse Chat
//
//  Created by Marthan Nodado on 6/25/22.
//

#import "ChatViewController.h"
#import <Parse/Parse.h>

@interface ChatViewController ()

@end

@implementation ChatViewController

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

- (IBAction)sendMessage:(id)sender {
    
    // 4. initialize Parse object
    PFObject *chatMessage = [PFObject objectWithClassName:@"Message_FBU2021"];
    
    // 5. Create a 'text' key and store message to object
    chatMessage[@"text"] = self.chatField.text;

    // 6. Send out message
    [chatMessage saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"Message was saved: %@", chatMessage[@"text"]);
        } else {
            NSLog(@"Problem saving message: %@", error.localizedDescription);
        }
    }];
    
    // 7. Clear text field
    self.chatField.text = @"";

}
@end
