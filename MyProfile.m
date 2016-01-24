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
#import "Events.h"
#import "Inbox.h"
@interface MyProfile (){    
    NSArray * reuseIdentifiers;
}


@end

@implementation MyProfile

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight=UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight=160;
    reuseIdentifiers= @[@"Avitar",@"Badges", @"Info", @"Info", @"Recent_Activity"];
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
    else if(section==3)return 6;
    else if(section==4)return 5;
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
//        NSLog(@"%@", [NSString stringWithFormat:@"https://www.snagemgame.com/%@", [[[profileDictionary objectForKey:@"badges"] objectAtIndex:0] objectForKey:@"image"]]);
//        if([badgeImages count]!=0){
//            cell.images = [[NSArray alloc] initWithObjects:[UIImage imageWithData:[badgeImages objectAtIndex:0]], [UIImage imageWithData:[badgeImages objectAtIndex:0]],[UIImage imageWithData:[badgeImages objectAtIndex:0]], nil];
//            ;
//
//        cell.label1.text=[[[profileDictionary objectForKey:@"badges"] objectAtIndex:0] objectForKey:@"name"];
//        cell.label2.text=[[[profileDictionary objectForKey:@"badges"] objectAtIndex:1] objectForKey:@"name"];
//        cell.label3.text=[[[profileDictionary objectForKey:@"badges"] objectAtIndex:2] objectForKey:@"name"];
//        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    if(indexPath.section==2){
        Info* cell= (Info*)[self.tableView dequeueReusableCellWithIdentifier:reuse];
        if(cell==nil) cell = [[Info alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
        if (indexPath.row==0){
            
        cell.InfoPiece.text=[NSString stringWithFormat:@"Snagem ID: %@",[profileDictionary objectForKey:@"ID"]];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        else if(indexPath.row==1){
            
        cell.InfoPiece.text=[NSString stringWithFormat:@"Name: %@",[profileDictionary objectForKey:@"Name"]];
           //[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        
        else if(indexPath.row==2){
            
        cell.InfoPiece.text=[NSString stringWithFormat:@"Email: %@",[profileDictionary objectForKey:@"Email"]];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        else if(indexPath.row==3){
        cell.InfoPiece.text=[NSString stringWithFormat:@"Change Password"];
        //[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        
        return cell;
    }
    if(indexPath.section==3){
        
        Info * cell= (Info*)[self.tableView dequeueReusableCellWithIdentifier:reuse];
        if(cell==nil) cell = [[Info alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
        if(indexPath.row==0)cell.InfoPiece.text= [NSString stringWithFormat:@"Points: %@", [profileDictionary objectForKey:@"Points"]];
        if(indexPath.row==1)cell.InfoPiece.text= [NSString stringWithFormat:@"Rank: %@", [profileDictionary objectForKey:@"Rank"]];
        if(indexPath.row==2)cell.InfoPiece.text= [NSString stringWithFormat:@"Bonus: %@", [profileDictionary objectForKey:@"Bonus"]];
        if(indexPath.row==3)cell.InfoPiece.text= [NSString stringWithFormat:@"Tags: %@", [profileDictionary objectForKey:@"Current_Tags"]];
        if(indexPath.row==4)cell.InfoPiece.text= [NSString stringWithFormat:@"Game Level: %@", [profileDictionary objectForKey:@"Game_Level"]];
        if(indexPath.row==5)cell.InfoPiece.text=[NSString stringWithFormat:@"Team: %@", [profileDictionary objectForKey:@"Team"]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
        
    }
    if(indexPath.section==4){
        Event * cell= (Event*)[self.tableView dequeueReusableCellWithIdentifier:reuse];
        if(cell==nil) cell = [[Event alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
        cell.title.text=[[[profileDictionary objectForKey:@"Recent_Activity"] objectAtIndex:indexPath.row] objectForKey:@"event"];
        cell.subtitle.text=[[[profileDictionary objectForKey:@"Recent_Activity"] objectAtIndex:indexPath.row] objectForKey:@"time"];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        return cell;
    }
    else return nil;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0)return 91;
    else if(indexPath.section==1)return 186;
    else if(indexPath.section==2)return 61;
    else if(indexPath.section==3) return 61;
    return UITableViewAutomaticDimension;
    
    
}

//iCarousel
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        NSURLSession* task=[NSURLSession sharedSession];
        NSString *stringURL=[NSString stringWithFormat:@"https://www.snagemgame.com/app_get_inbox.php"];
        NSURLSessionDataTask *jsonData = [task dataTaskWithURL:[NSURL URLWithString:stringURL]
                                             completionHandler:^(NSData *data,
                                                                 NSURLResponse *response,
                                                                 NSError *error) {
        
                                                 dispatch_async(dispatch_get_main_queue(), ^{
                                                     UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                                     Inbox * e = [sb instantiateViewControllerWithIdentifier:@"Inbox"];
                                                     e.messages=[NSJSONSerialization JSONObjectWithData:data options: kNilOptions error:nil];
                                                     [self.navigationController showViewController:e sender:nil];
                                                     
                                                 });

                                                 
                                                 
        }];
        [jsonData resume];
        
    }
    if(indexPath.section==4){
        UIStoryboard * sb= [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        Events * e=[sb instantiateViewControllerWithIdentifier:@"Events"];
        e.eventDictionary=[profileDictionary objectForKey:@"Recent_Activity"];
        [self.navigationController showViewController:e sender:nil];
        
    }
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section==0) return @"Avatar";
    else if(section==1)return @"Badges";
    else if(section==2)return @"Info";
    else if(section==3)return @"Stats";
    else return @"Recent Activity";
}

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [badgeImages count];
}

- (NSUInteger)numberOfVisibleItemsInCarousel:(iCarousel *)carousel
{
    //limit the number of items views loaded concurrently (for performance reasons)
    return 7;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index
{
    //create a numbered view
    UIView *view = [[UIImageView alloc] initWithImage:[UIImage imageWithData:[badgeImages objectAtIndex:index]]];
    return view;
}
-(UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    UIImageView * imagething=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 130, 130)];
    imagething.image=[UIImage imageWithData:[badgeImages objectAtIndex:index]];
    
    UIView* totalView= [[UIView alloc] initWithFrame: CGRectMake(0, 0, 130, 160)];
    UILabel * description=[[UILabel alloc] initWithFrame:CGRectMake(0, 130, 130, 30)];
    description.text=[[[profileDictionary objectForKey:@"badges"] objectAtIndex:index] objectForKey:@"name"];
    description.textColor=[UIColor whiteColor];
    description.textAlignment=NSTextAlignmentCenter;
    [totalView addSubview:imagething];
    [totalView addSubview:description];
    return totalView;
}
-(UIView *)carousel:(iCarousel *)carousel placeholderViewAtIndex:(NSInteger)index reusingView:(UIView *)view{
    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"messages"]];
}

- (NSInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel
{
    //note: placeholder views are only displayed on some carousels if wrapping is disabled
    return 0;
}


- (CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    //usually this should be slightly wider than the item views
    return 240;
}

- (BOOL)carouselShouldWrap:(iCarousel *)carousel
{
    //wrap all carousels
    return YES;
}

- (void)carouselDidEndScrollingAnimation:(iCarousel *)aCarousel
{
    
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

- (IBAction)edit:(id)sender {
    UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"Edit Avitar" message:@"Please go to the website version to edit your avitar" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
    
}
@end
