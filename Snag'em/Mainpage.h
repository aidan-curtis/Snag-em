//
//  Mainpage.h
//  Snag'em
//
//  Created by Aidan Curtis on 7/19/15.
//  Copyright (c) 2015 NCSU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MissionsList.h"
#import "MissionsListCompleted.h"
@interface Mainpage : UIViewController <UITableViewDelegate>
{
    NSArray* missions;
    MissionsList* list;
    MissionsListCompleted* completedList;
}
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIImageView *Avitar;
@property (weak, nonatomic) IBOutlet UILabel *Name;
@property (weak, nonatomic) IBOutlet UILabel *Team;
@property (weak, nonatomic) IBOutlet UILabel *IDNum;
- (IBAction)Missions:(id)sender;
- (IBAction)Completed:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *imageToBlur;
@property (weak, nonatomic) IBOutlet UIButton *missions_button;
@property (weak, nonatomic) IBOutlet UIButton *completed_button;
@property UIImage* AvatarImage;
@property (weak, nonatomic) IBOutlet UIView *MissionListContainer;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *menu;


@end
