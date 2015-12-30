//
//  MissionsList.h
//  Snag'em
//
//  Created by Aidan Curtis on 7/29/15.
//  Copyright (c) 2015 NCSU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Mission.h"
@interface MissionsList : UITableViewController <UITableViewDataSource, UITableViewDelegate>{
    NSString * formattedMission;
    NSArray* randomMissionsArray;
    NSString* hobbyistMission;
    NSString* ultimateMission;
    NSString* goldenMission;
    UIImage* currentLoadedImage;
    NSMutableArray* arrayOfDifficultyStrings;
    
    
}
@property (strong, nonatomic) IBOutlet UITableView *table;

@end
