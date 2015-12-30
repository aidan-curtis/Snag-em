//
//  TagsViewController.m
//  Snag'em
//
//  Created by Aidan Curtis on 12/20/15.
//  Copyright © 2015 NCSU. All rights reserved.
//

#import "TagsViewController.h"

@interface TagsViewController ()

@end

@implementation TagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURLSession* task=[NSURLSession sharedSession];
    NSString *stringURL=[NSString stringWithFormat:@"https://www.snagemgame.com/app_user_tags.php"];
    NSURLSessionDataTask *jsonData = [task dataTaskWithURL:[NSURL URLWithString:stringURL]
                                         completionHandler:^(NSData *data,
                                                             NSURLResponse *response,
                                                             NSError *error) {
                                             
                                             
                                             NSLog(@"testing");
                                             NSDictionary * jsondictionary=[NSJSONSerialization JSONObjectWithData:data options: kNilOptions error:nil];
                                             NSLog(@"%@", jsondictionary);
                                             tags=[jsondictionary objectForKey:@"UserTags"];
                                             [[NSUserDefaults standardUserDefaults] setObject:tags forKey:@"User Tags"];
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



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [tags count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString* TagReuseIdentifier=@"nameGameMissionCell";
    TableViewCell* cell=(TableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:TagReuseIdentifier];
    
    
    if(cell==nil){
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TagReuseIdentifier];
        
    }
    [cell.missionText setText:[[tags objectAtIndex:indexPath.row] objectForKey:@"Name"]];
    [cell.missionImage setImage:[UIImage imageNamed:@"snaglogo2.png"]];
    
    
    return cell;

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
