//
//  RecentActivity.h
//  Snag'em
//
//  Created by Aidan Curtis on 12/26/15.
//  Copyright © 2015 NCSU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecentActivity : UITableViewCell
@property (weak, nonatomic) NSArray* array_of_activities;
@property (weak, nonatomic) IBOutlet UILabel *event1;
@property (weak, nonatomic) IBOutlet UILabel *event2;
@property (weak, nonatomic) IBOutlet UILabel *event3;
@property (weak, nonatomic) IBOutlet UILabel *event4;
@property (weak, nonatomic) IBOutlet UILabel *event5;
@property (weak, nonatomic) IBOutlet UILabel *time1;
@property (weak, nonatomic) IBOutlet UILabel *time2;
@property (weak, nonatomic) IBOutlet UILabel *time3;
@property (weak, nonatomic) IBOutlet UILabel *time4;
@property (weak, nonatomic) IBOutlet UILabel *time5;

@end
