//
//  Network_List.m
//  Snag'em
//
//  Created by Aidan Curtis on 12/27/15.
//  Copyright © 2015 NCSU. All rights reserved.
//

#import "Network_List.h"

@implementation Network_List
@synthesize school, name, image, reason1, reason2, email;
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
