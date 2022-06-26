//
//  ChatViewController.h
//  Parse Chat
//
//  Created by Marthan Nodado on 6/25/22.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChatViewController : ViewController
@property (weak, nonatomic) IBOutlet UITextField *chatField;
- (IBAction)sendMessage:(id)sender;

@end

NS_ASSUME_NONNULL_END
