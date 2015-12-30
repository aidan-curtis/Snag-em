//
//  Network_List.h
//  Snag'em
//
//  Created by Aidan Curtis on 12/27/15.
//  Copyright © 2015 NCSU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Network_List : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *school;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *reason1;
@property (weak, nonatomic) IBOutlet UILabel *email;

@property (weak, nonatomic) IBOutlet UILabel *reason2;

@end
