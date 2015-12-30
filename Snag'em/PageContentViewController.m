//
//  PageContentViewController.m
//  Snag'em
//
//  Created by Aidan Curtis on 6/18/15.
//  Copyright (c) 2015 NCSU. All rights reserved.
//

#import "PageContentViewController.h"

@interface PageContentViewController ()

@end

@implementation PageContentViewController
@synthesize  pageIndex, image, titles, text;
- (void)viewDidLoad {
    [super viewDidLoad];
    if(pageIndex!=6){
        image.hidden=NO;
        _myButton.hidden=YES;
    NSArray *listOfTitles=@[@"1.Register", @"2.Add Tags", @"3.Get Missions", @"4.Snag Someone", @"5.Work Together",@"6.Expand Your Network"];
    NSArray *listOfTexts=@[@"Click on Register in the top right, then fill out the registration form. If someone recruited you to the game, enter their Snag'Em ID to score them some points!",@"Head to the Tags page and give yourself some tags! Tags describe you and allow others to connect with you over those attributes. Are you a freshman, do you love sports? Let us know! You must have at least 5 tags before you can start a mission.",@"Visit the Missions page to see what missions are available. At first, you have 4 missions to choose from; complete a lot of missions to level up and unlock more!",@"Start talking to people! Ask questions, initiate conversations, do a little investigation and light stalking until you find someone to satisfy a mission. Enter their four digit SnagID on the Missions page to complete the missions and gain points!",@"When you join Snag'em, you'll be added to one of three teams: Ninjas, Pirates, and Zombies. These teams are competing to build the best fortress. Every point earned by team members increases the size of your fortress, and your team can score awesome additions to your fortress by completing Team Achievement missions. Visit the Team Achievements page to see how your team is doing!",@"Keep it up! Meet new people! Get extra points for recruiting new players. See if you can make it to the top of the leaderboard. Most importantly, make valuable connections with the many people you meet playing Snag'em; you never know when a contact will come in handy!"];
    NSArray *listOfImages=@[@"register",@"tag",@"mission",@"snag",@"team",@"network"];
    titles.text=listOfTitles[pageIndex];
    text.text=listOfTexts[pageIndex];
    image.image=[UIImage imageNamed:(listOfImages[pageIndex])];
    text.editable=NO;
    }
    else{
        titles.hidden=YES;
        text.hidden=YES;
        image.hidden=YES;
        _myButton.hidden=NO;
        
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)mybutton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
