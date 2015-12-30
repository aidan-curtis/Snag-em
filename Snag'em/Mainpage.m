//
//  Mainpage.m
//  Snag'em
//
//  Created by Aidan Curtis on 7/19/15.
//  Copyright (c) 2015 NCSU. All rights reserved.
//

#import "Mainpage.h"
#import "SWRevealViewController.h"
@interface Mainpage()


@end
@implementation Mainpage
@synthesize AvatarImage, MissionListContainer;

- (void)viewDidLoad {
    self.menu.target=self.revealViewController;
    self.menu.action=@selector(revealToggle:);
    [super viewDidLoad];
    NSString* firstName=[[NSUserDefaults standardUserDefaults] objectForKey:@"firstname"];
    NSString* lastName=[[NSUserDefaults standardUserDefaults] objectForKey:@"lastname"];
    NSString* num=[[NSUserDefaults standardUserDefaults] objectForKey:@"player_IDNUM"];
    _IDNum.text=[NSString stringWithFormat:@"ID: %@", num];
    _Name.text=[NSString stringWithFormat:@"%@ %@", firstName, lastName];
    _Team.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"TeamName"];
    _Avitar.image=[UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"Avitar"]];
    
    
    list=[self.storyboard instantiateViewControllerWithIdentifier:@"MissionsList"];
    [self addChildViewController:list];
    
    completedList=[self.storyboard instantiateViewControllerWithIdentifier:@"MissionsListCompleted"];
    [self addChildViewController:completedList];
    
    completedList.tableView.frame=MissionListContainer.frame;
    list.tableView.frame=MissionListContainer.frame;
    
    [MissionListContainer addSubview:completedList.tableView];
    [MissionListContainer addSubview:list.tableView];
    
    
    
    [list didMoveToParentViewController:self];
    [completedList didMoveToParentViewController:self];
    

    

    
}
-(void)viewDidAppear:(BOOL)animated{
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//go to new page for more info
    
}
- (IBAction)Missions:(id)sender {
    
    [UIView animateWithDuration:.1 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         _missions_button.backgroundColor=[UIColor colorWithRed:43/255.0 green:62/255.0 blue:80/255.0 alpha:225/255.0];
                         _completed_button.backgroundColor=[UIColor colorWithRed:23/255.0 green:42/255.0 blue:60/255.0 alpha:255/255.0];
                     }
                     completion:nil];
    [MissionListContainer.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [MissionListContainer addSubview:list.tableView];
   
}

- (IBAction)Completed:(id)sender {
    [UIView animateWithDuration:.1 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         _missions_button.backgroundColor=[UIColor colorWithRed:23/255.0 green:42/255.0 blue:60/255.0 alpha:255/255.0];
                         _completed_button.backgroundColor=[UIColor colorWithRed:43/255.0 green:62/255.0 blue:80/255.0 alpha:255/255.0];
                     }
                     completion:nil];
    [MissionListContainer.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [MissionListContainer addSubview:completedList.tableView];

    

}

@end
