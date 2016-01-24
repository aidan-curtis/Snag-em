//
//  AddTagsViewController.m
//  Snag'em
//
//  Created by Aidan Curtis on 12/20/15.
//  Copyright © 2015 NCSU. All rights reserved.
//

#import "AddTagsViewController.h"
#import "SelectingTags.h"
@interface AddTagsViewController ()

@end

@implementation AddTagsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    choices=[[NSMutableArray alloc] init];
    images=[[NSMutableArray alloc] init];
    choices_subfield=[[NSMutableArray alloc] init];
    
    
    
    NSURLSession* task=[NSURLSession sharedSession];
    NSString *stringURL=[NSString stringWithFormat:@"https://www.snagemgame.com/app_display_tags.php"];
    NSURLSessionDataTask *jsonData = [task dataTaskWithURL:[NSURL URLWithString:stringURL]
                                         completionHandler:^(NSData *data,
                                                             NSURLResponse *response,
                                                             NSError *error) {
                                             
                                             
                        
                                             NSDictionary * jsondictionary=[NSJSONSerialization JSONObjectWithData:data options: kNilOptions error:nil];
                                             for( NSDictionary* dict in [jsondictionary objectForKey:@"Names"]){
                                                 for(NSString* name in dict){
                                                     if([name containsString:@"_"]){
                                                     [choices addObject:[[name componentsSeparatedByString:@"_"] objectAtIndex:0]];
                                                     [images addObject:[NSString stringWithFormat:@"%@.png",[name componentsSeparatedByString:@"_"][1]]];
                                                     }
                                                     else [choices addObject:name];
                                                     
                                                  
                                                     [choices_subfield addObject:dict[name]];
                                                 }
                                                 
                                             }
                                            
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
    return [choices count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString* TagReuseIdentifier=@"nameGameMissionCell";
    TableViewCell* cell=(TableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:TagReuseIdentifier];
    
    
    if(cell==nil){
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TagReuseIdentifier];
        
    }
    [cell.missionText setText:[choices objectAtIndex:indexPath.row]];
    [cell.missionImage setImage:[UIImage imageNamed:[images objectAtIndex:indexPath.row]]];

    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SelectingTags * vc=[[SelectingTags alloc] init];
    vc.options=(NSArray*)[choices_subfield objectAtIndex:indexPath.row];
    [self showViewController:vc sender:nil];
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
