//
//  TableViewCell.h
//  Snag'em
//
//  Created by Aidan Curtis on 6/22/15.
//  Copyright (c) 2015 NCSU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *missionText;
@property (weak, nonatomic) IBOutlet UIImageView *missionImage;

@end
