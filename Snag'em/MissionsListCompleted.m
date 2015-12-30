//
//  MissionsListCompleted.m
//  Snag'em
//
//  Created by Aidan Curtis on 8/9/15.
//  Copyright (c) 2015 NCSU. All rights reserved.
//

#import "MissionsListCompleted.h"
#import "TableViewCell.h"
@implementation MissionsListCompleted
-(void)viewDidLoad{
    [super viewDidLoad];
    
    jsonCompletedMission=[[NSMutableArray alloc] init];
    completedMissions=[[NSMutableArray alloc] init];

    NSURLSession *task=[NSURLSession sharedSession];
    NSURLSessionDownloadTask* download=[task downloadTaskWithURL:[NSURL URLWithString:@"https://www.snagemgame.com/app_completedMissions.php"] completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        NSLog(@"did complete loading");
        jsonCompletedMission=[NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:location] options: kNilOptions error:nil];
        
        for (NSDictionary *object in jsonCompletedMission){
            NSLog(@"%@",object);
            [completedMissions addObject:object];
        }
        [_theTable reloadData];

    }];
    [download resume];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"number completed: %i", (int)[completedMissions count]);
    return [completedMissions count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* cellsID=@"nameGameMissionCell";
    TableViewCell* cell=(TableViewCell*)[self.theTable dequeueReusableCellWithIdentifier:cellsID];
    if(cell==nil){
        cell=[[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsID];
        [cell setBackgroundColor:[UIColor colorWithRed:53/255.0f green:77/255.0f blue:99/255.0f alpha:255/255.0f]];
    }

    [cell.missionImage setImage:[UIImage imageNamed:@"18449-small-green-check-mark-clip-art.png"]];
    [cell.missionText setText:[NSString stringWithFormat: @"You got %i points: %@", (int)[[[completedMissions objectAtIndex:indexPath.row] objectForKey:@"Points"] integerValue], [[completedMissions objectAtIndex:indexPath.row] objectForKey:@"Message"]]];
    
    
    return cell;
    
}

@end
