//
//  ChatViewController.m
//  Parse Chat
//
//  Created by Marthan Nodado on 6/25/22.
//

#import "ChatViewController.h"
#import "ChatCell.h"
#import <Parse/Parse.h>

@interface ChatViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *chatArray;

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // calls onTimer method every 60 seconds
    [self fetchMessages];
    [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(onTimer) userInfo:nil repeats:true];
    
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
    
    PFUser *user = PFUser.currentUser;
    
    // 4. initialize Parse object
    PFObject *chatMessage = [PFObject objectWithClassName:@"Message_FBU2021"];
    
    // 5. Create a 'text' key and store message to object
    chatMessage[@"text"] = self.chatField.text;
    chatMessage[@"user"] = user;

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
    
    [self fetchMessages];

}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    ChatCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatCell" forIndexPath:indexPath];
    
    PFObject *chatObject = self.chatArray[indexPath.row];
    PFUser *user = chatObject[@"user"];
    
    if (user) {
        cell.usernameLabel.text = user.username;
    } else {
        cell.usernameLabel.text = @"🤪";
    }
    
    cell.messageString.text = chatObject[@"text"];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (void)onTimer {
    [self fetchMessages];
    [self.tableView reloadData];
}

- (void)fetchMessages {
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Message_FBU2021"];
    [query includeKey:@"user"];
    [query orderByDescending:@"createdAt"];
//    [query whereKey:@"likesCount" greaterThan:@100];
    query.limit = 20;

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            // do something with the array of object returned by the call
            self.chatArray = [posts copy];
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

@end
