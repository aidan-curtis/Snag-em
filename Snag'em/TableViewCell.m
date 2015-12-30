//
//  TableViewCell.m
//  Snag'em
//
//  Created by Aidan Curtis on 6/22/15.
//  Copyright (c) 2015 NCSU. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell
@synthesize missionText, missionImage;
- (void)awakeFromNib {
    // Initialization code
}
- (UIEdgeInsets)layoutMargins {
    return UIEdgeInsetsZero;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
