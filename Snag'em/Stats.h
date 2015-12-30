//
//  Stats.h
//  Snag'em
//
//  Created by Aidan Curtis on 12/26/15.
//  Copyright © 2015 NCSU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Stats : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *points;
@property (weak, nonatomic) IBOutlet UILabel *rank;
@property (weak, nonatomic) IBOutlet UILabel *bonus;
@property (weak, nonatomic) IBOutlet UILabel *tags;
@property (weak, nonatomic) IBOutlet UILabel *level;
@property (weak, nonatomic) IBOutlet UILabel *team;

@end
