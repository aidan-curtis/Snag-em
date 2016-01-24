//
//  Event.h
//  Snag'em
//
//  Created by Aidan Curtis on 1/3/16.
//  Copyright © 2016 NCSU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Event : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *subtitle;

@end
