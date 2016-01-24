//
//  Inbox_Message.h
//  Snag'em
//
//  Created by Aidan Curtis on 1/3/16.
//  Copyright © 2016 NCSU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Inbox_Message : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *event;
@property (weak, nonatomic) IBOutlet UILabel *time;

@end
