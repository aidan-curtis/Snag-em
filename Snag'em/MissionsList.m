//
//  MissionsList.m
//  Snag'em
//
//  Created by Aidan Curtis on 7/29/15.
//  Copyright (c) 2015 NCSU. All rights reserved.
//

#import "MissionsList.h"
#import "TableViewCell.h"
#import "MissionCells.h"

@implementation MissionsList
@synthesize table;


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section)
    {
        case 0:
            return 1;
            break;
        case 1:
            return 3;
            break;
        case 2:
            return 1;
            break;
        case 3:
            return 1;
            break;
        case 4:
            return 1;
            break;
        default:
            return 0;
            break;
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (section)
    {
        case 0:
            sectionName = @"Name Game Mission";
            break;
        case 1:
            sectionName = @"Random Missions";
            break;
            // ...
        case 2:
            sectionName =@"Hobbyist Misson";
            break;
        case 3:
            sectionName=@"Golden Mission";
            break;
        case 4:
            sectionName=@"Ultimate Networker Mission";
            break;
        default:
            sectionName = @"";
            break;
    }
    return sectionName;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* cellsID=@"nameGameMissionCell";
    TableViewCell* cell=(TableViewCell*)[table dequeueReusableCellWithIdentifier:cellsID];
    if(cell==nil){
        cell=[[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellsID];
        [cell setBackgroundColor:[UIColor colorWithRed:53/255.0f green:77/255.0f blue:99/255.0f alpha:255/255.0f]];
    }
    NSString* secondHalf;
    switch (indexPath.section) {
        case 0:
            [cell.missionText setText:formattedMission];
            [cell.missionImage setImage:[UIImage imageNamed:@"sniper_mission"]];
            return cell;
            break;
        case 1:
            secondHalf=[[randomMissionsArray objectAtIndex:indexPath.row] objectForKey:@"Description"];
            [cell.missionText setText:[NSString stringWithFormat:@"Find someone who %@",secondHalf]];
            [cell.missionImage setImage:[UIImage imageNamed:@"random_mission"]];
            return cell;
            break;
        case 2:
            [cell.missionText setText:hobbyistMission];
            [cell.missionImage setImage:[UIImage imageNamed:@"hobby_mission"]];
            return cell;
            break;
        case 3:
            [cell.missionText setText:goldenMission];
            [cell.missionImage setImage:[UIImage imageNamed:@"golden_mission"]];
            return cell;
            break;
        case 4:
            [cell.missionText setText:ultimateMission];
            [cell.missionImage setImage:[UIImage imageNamed:@"network_mission"]];
            return cell;
            break;
        default:
            return cell;
            break;
    }
    
}
-(int)sectionToint:(int)sect{
    if(sect==0)return 0;
    else if(sect==1)return 1;
    else if(sect==2)return 4;
    else if(sect==3)return 5;
    return 0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Mission* missionscreen=[self.storyboard instantiateViewControllerWithIdentifier:@"Mission"];
    missionscreen.titleStore=((TableViewCell*)[tableView cellForRowAtIndexPath:indexPath]).missionText.text;
    currentLoadedImage=[(TableViewCell*)[tableView cellForRowAtIndexPath:indexPath] missionImage].image;
    missionscreen.imageStore=currentLoadedImage;
    missionscreen.percentString=[arrayOfDifficultyStrings objectAtIndex:[self sectionToint:indexPath.section]+indexPath.row];
    missionscreen.missionID=[self sectionToint:indexPath.section]+indexPath.row;
    if(![missionscreen.titleStore isEqualToString:@"Locked"])[self.navigationController showViewController:missionscreen sender:nil];
    else{
        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"This mission is locked" message:@"Gain more experience and snag more people!" delegate:self cancelButtonTitle:@"OK!" otherButtonTitles:nil, nil];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [alert show];

    }
}
-(NSString*) formatMission:(NSDictionary*)jsonData{
    return [NSString stringWithFormat:@"Find someone whose %@ begins with %@",[jsonData objectForKey:@"myType"], [jsonData objectForKey:@"letter"]];
}
-(void) viewDidLoad{
    formattedMission=@"Loading...";
    arrayOfDifficultyStrings=[[NSMutableArray alloc] init];
    NSLog(@"starting missions loading");
    
    NSURLSession* task=[NSURLSession sharedSession];
    NSURLSessionDownloadTask* getNameGame=[task downloadTaskWithURL:[NSURL URLWithString:@"https://www.snagemgame.com/app_generate_name_game.php"] completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        NSLog(@"ending missions loading 1");
        NSDictionary *nameMissionDict=[NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:location] options:kNilOptions error:nil];
        formattedMission=[self formatMission:nameMissionDict];
        [arrayOfDifficultyStrings addObject:[NSString stringWithFormat:@"%@%@ of players have this tag", [nameMissionDict objectForKey:@"common"], @"%"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [table reloadData];
        });
        
    }];
    
    [getNameGame resume];
    
    NSURLSessionDownloadTask* getOtherMissions=[task downloadTaskWithURL:[NSURL URLWithString:@"https://www.snagemgame.com/app_random_missions.php"] completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        NSLog(@"ending missions loading 2");
        NSDictionary* json=[NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:location] options:kNilOptions error:nil];
        //random mission
        randomMissionsArray=[json objectForKey:@"Random Missions"];
        //random missions' percents
        for(int a=0; a< [randomMissionsArray count]; a++){
            NSString* randmissnum=[[randomMissionsArray objectAtIndex:a] objectForKey:@"Difficulty"];
            [arrayOfDifficultyStrings addObject:[NSString stringWithFormat:@"%@%@ of players have this tag", randmissnum, @"%"]];
        }
        //hobbymission
        hobbyistMission=[[json objectForKey:@"Hobbyist Mission"] objectForKey:@"Description"];
        //hobbymission difficulty
        NSString * hobbyNumber=[[json objectForKey:@"Hobbyist Mission"] objectForKey:@"Difficulty"];
        [arrayOfDifficultyStrings addObject:[NSString stringWithFormat:@"%@%@ of players have this tag", hobbyNumber, @"%"]];
        
        
        //gold mission
        goldenMission=[[json objectForKey:@"Golden Mission"] objectForKey:@"Name"];
        //gold mission difficulty
        [arrayOfDifficultyStrings addObject:@""];
        
        
        //ultimage mission
        if(![[[json objectForKey:@"Ultimate Networker"] objectForKey:@"First Person"] isEqualToString:@"Locked"]){
            ultimateMission=[NSString stringWithFormat:@"Connect %@ with %@",[[json objectForKey:@"Ultimate Networker"] objectForKey:@"First Person"], [[json objectForKey:@"Ultimate Networker"] objectForKey:@"Second Person"]];
        }
        else ultimateMission=@"Locked";
        
        //ultimate mission difficulty
        [arrayOfDifficultyStrings addObject:@""];
        
        
        //reload table data
        dispatch_async(dispatch_get_main_queue(), ^{
            [table reloadData];
        });
    }];
    [getOtherMissions resume];

}


@end
