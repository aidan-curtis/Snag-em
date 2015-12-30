//
//  MissionsListCompleted.h
//  Snag'em
//
//  Created by Aidan Curtis on 8/9/15.
//  Copyright (c) 2015 NCSU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MissionsListCompleted : UITableViewController<UITableViewDataSource, UITableViewDelegate>{

    NSArray* responses;
    NSMutableArray* jsonCompletedMission;
    NSMutableArray* completedMissions;
    
}
@property (strong, nonatomic) IBOutlet UITableView *theTable;

@end
