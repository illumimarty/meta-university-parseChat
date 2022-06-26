//
//  ChatCell.h
//  Parse Chat
//
//  Created by Marthan Nodado on 6/25/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChatCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *messageString;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

@end

NS_ASSUME_NONNULL_END
