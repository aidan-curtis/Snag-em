//
//  MyProfile.m
//  Snag'em
//
//  Created by Aidan Curtis on 12/25/15.
//  Copyright © 2015 NCSU. All rights reserved.
//

#import "MyProfile.h"
#import "SWRevealViewController.h"
#import "TableViewCell.h"
@interface MyProfile (){    
    NSArray * reuseIdentifiers;
}


@end

@implementation MyProfile

- (void)viewDidLoad {
    [super viewDidLoad];
    reuseIdentifiers= @[@"Avitar",@"Badges", @"Info", @"Stats", @"RecentActivity"];
    profileDictionary=[[NSUserDefaults standardUserDefaults] objectForKey:@"profileDictionary"];
    
    self.navigationController.navigationBar.hidden=NO;
    self.menu.target=self.revealViewController;
    self.menu.action=@selector(revealToggle:);
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.title=@"My Profile";
    badgeImages=[[NSUserDefaults standardUserDefaults] objectForKey:@"badgeImages"];
    profileImage=[[NSUserDefaults standardUserDefaults] objectForKey:@"profileImage"];
 //loading info
    NSURLSession* task=[NSURLSession sharedSession];
    NSString *stringURL=[NSString stringWithFormat:@"https://www.snagemgame.com/app_my_profile.php"];
    NSURLSessionDataTask *jsonData = [task dataTaskWithURL:[NSURL URLWithString:stringURL]
                                         completionHandler:^(NSData *data,
                                                             NSURLResponse *response,
                                                             NSError *error) {
                                             
                                             
                                             profileDictionary=[NSJSONSerialization JSONObjectWithData:data options: kNilOptions error:nil];
                                             profileImage=[NSData dataWithContentsOfURL:
                                                            [NSURL URLWithString:
                                                             [NSString stringWithFormat:@"https://www.snagemgame.com/%@", [profileDictionary objectForKey:@"Avitar"]]]];
                                             //[profileDictionary setValue:profileImage forKey:@"Avitar"];
                                             badgeImages=@[[NSData dataWithContentsOfURL:
                                                                      [NSURL URLWithString:
                                                                       [NSString stringWithFormat:@"https://www.snagemgame.com/%@", [[[profileDictionary objectForKey:@"badges"] objectAtIndex:0] objectForKey:@"image"]]]],
                                  
                                                                     [NSData dataWithContentsOfURL:
                                                                      [NSURL URLWithString:
                                                                       [NSString stringWithFormat:@"https://www.snagemgame.com/%@", [[[profileDictionary objectForKey:@"badges"] objectAtIndex:1] objectForKey:@"image"]]]],
                                      
                                                                     [NSData dataWithContentsOfURL:
                                                                      [NSURL URLWithString:
                                                                       [NSString stringWithFormat:@"https://www.snagemgame.com/%@", [[[profileDictionary objectForKey:@"badges"] objectAtIndex:2] objectForKey:@"image"]]]]];
                                             

                                             [[NSUserDefaults standardUserDefaults] setObject:badgeImages forKey:@"badgeImages"];
                                             [[NSUserDefaults standardUserDefaults] setObject:profileImage forKey:@"profileImage"];
                                             [[NSUserDefaults standardUserDefaults] setObject:profileDictionary forKey:@"profileDictionary"];
                                             
                                            
                                             dispatch_async(dispatch_get_main_queue(), ^{
                                                 [self.tableView reloadData];
                                             });
                                         }];

    
    [jsonData resume];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 5;
    //return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==2)return 4;
    else return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSString *reuse=[reuseIdentifiers objectAtIndex:indexPath.section];
    
    if(indexPath.section==0){
        
       
        Avitar * cell= (Avitar*)[self.tableView dequeueReusableCellWithIdentifier:reuse];
        if(cell==nil) cell= [[Avitar alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
        //cell properties
        [cell.image setImage:[UIImage imageWithData: profileImage]];
        [cell.inbox setText:[NSString stringWithFormat:@"Inbox: %@", [profileDictionary objectForKey:@"Inbox_Count"]]];
        return cell;
    }
    
    
    if(indexPath.section==1){
        Badges * cell= (Badges*)[self.tableView dequeueReusableCellWithIdentifier:reuse];
        if(cell==nil) cell = [[Badges alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
        NSLog(@"%@", [NSString stringWithFormat:@"https://www.snagemgame.com/%@", [[[profileDictionary objectForKey:@"badges"] objectAtIndex:0] objectForKey:@"image"]]);
        if([badgeImages count]!=0){
        cell.image1.image=[UIImage imageWithData:[badgeImages objectAtIndex:0]];
        cell.image2.image=[UIImage imageWithData:[badgeImages objectAtIndex:1]];
        cell.image3.image=[UIImage imageWithData:[badgeImages objectAtIndex:2]];
        cell.label1.text=[[[profileDictionary objectForKey:@"badges"] objectAtIndex:0] objectForKey:@"name"];
        cell.label2.text=[[[profileDictionary objectForKey:@"badges"] objectAtIndex:1] objectForKey:@"name"];
        cell.label3.text=[[[profileDictionary objectForKey:@"badges"] objectAtIndex:2] objectForKey:@"name"];
        }
        return cell;
    }
    if(indexPath.section==2){
        Info* cell= (Info*)[self.tableView dequeueReusableCellWithIdentifier:reuse];
        if(cell==nil) cell = [[Info alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
        if (indexPath.row==0)cell.InfoPiece.text=[NSString stringWithFormat:@"Snagem ID: %@",[profileDictionary objectForKey:@"ID"]];
        else if(indexPath.row==1)cell.InfoPiece.text=[NSString stringWithFormat:@"Name: %@",[profileDictionary objectForKey:@"Name"]];
        else if(indexPath.row==2)cell.InfoPiece.text=[NSString stringWithFormat:@"Email: %@",[profileDictionary objectForKey:@"Email"]];
        else if(indexPath.row==3)cell.InfoPiece.text=[NSString stringWithFormat:@"Change Password"];
        return cell;
    }
    if(indexPath.section==3){
        Stats * cell= (Stats*)[self.tableView dequeueReusableCellWithIdentifier:reuse];
        if(cell==nil) cell = [[Stats alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
       
        cell.points.text= [NSString stringWithFormat:@"Points: %@", [profileDictionary objectForKey:@"Points"]];
        cell.rank.text= [NSString stringWithFormat:@"Rank: %@", [profileDictionary objectForKey:@"Rank"]];
        cell.bonus.text= [NSString stringWithFormat:@"Bonus: %@", [profileDictionary objectForKey:@"Bonus"]];
        cell.tags.text= [NSString stringWithFormat:@"Tags: %@", [profileDictionary objectForKey:@"Current_Tags"]];
        cell.level.text= [NSString stringWithFormat:@"Game Level: %@", [profileDictionary objectForKey:@"Game_Level"]];
        cell.team.text=[NSString stringWithFormat:@"Team: %@", [profileDictionary objectForKey:@"Team"]];
        return cell;
        
    }
    if(indexPath.section==4){
        RecentActivity * cell= (RecentActivity*)[self.tableView dequeueReusableCellWithIdentifier:reuse];
        if(cell==nil) cell = [[RecentActivity alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
        
        cell.event1.text=[[[profileDictionary objectForKey:@"Recent_Activity"] objectAtIndex:0] objectForKey:@"event"];
        cell.time1.text=[[[profileDictionary objectForKey:@"Recent_Activity"] objectAtIndex:0] objectForKey:@"time"];
        
        cell.event2.text=[[[profileDictionary objectForKey:@"Recent_Activity"] objectAtIndex:1] objectForKey:@"event"];
        cell.time2.text=[[[profileDictionary objectForKey:@"Recent_Activity"] objectAtIndex:1] objectForKey:@"time"];
        
        cell.event3.text=[[[profileDictionary objectForKey:@"Recent_Activity"] objectAtIndex:2] objectForKey:@"event"];
        cell.time3.text=[[[profileDictionary objectForKey:@"Recent_Activity"] objectAtIndex:2] objectForKey:@"time"];
        
        cell.event4.text=[[[profileDictionary objectForKey:@"Recent_Activity"] objectAtIndex:3] objectForKey:@"event"];
        cell.time4.text=[[[profileDictionary objectForKey:@"Recent_Activity"] objectAtIndex:3] objectForKey:@"time"];
        
        cell.event5.text=[[[profileDictionary objectForKey:@"Recent_Activity"] objectAtIndex:4] objectForKey:@"event"];
        cell.time5.text=[[[profileDictionary objectForKey:@"Recent_Activity"] objectAtIndex:4] objectForKey:@"time"];
        return cell;
    }
    else return nil;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0)return 91;
    else if(indexPath.section==1)return 186;
    else if(indexPath.section==2)return 61;
    else if(indexPath.section==3) return 199;
    else if(indexPath.section==4) return 243;
    return 0;
    
    
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
