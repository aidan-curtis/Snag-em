//
//  SelectingTags.m
//  Snag'em
//
//  Created by Aidan Curtis on 12/20/15.
//  Copyright © 2015 NCSU. All rights reserved.
//

#import "SelectingTags.h"

@interface SelectingTags ()

@end

@implementation SelectingTags
@synthesize options;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor=[UIColor colorWithRed:53.0/255.0 green:77.0/255.0 blue:99.0/255.0 alpha:255.0/255.0];
    self.tableView.tintColor=[UIColor whiteColor];
    user_tags=[[NSMutableArray alloc] init];
    
    NSArray* temp_array=[[NSUserDefaults standardUserDefaults] objectForKey:@"User Tags"];
    for(int i =0 ; i<[temp_array count]; i++) [user_tags addObject:[[temp_array objectAtIndex:i] objectForKey:@"ID"]];
    



}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [options count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * reuse=@"Cellidentifierthing";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
    }
    NSString* temp=[[options objectAtIndex:indexPath.row] objectForKey:@"Name"];
    if([user_tags containsObject:[[options objectAtIndex:indexPath.row] objectForKey:@"ID"]]){
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    NSString* newtemp;
    if([temp containsString:@"_"])newtemp=[[temp componentsSeparatedByString:@"_"] objectAtIndex:0];
    else newtemp=temp;
    cell.textLabel.text=newtemp;
    cell.textLabel.textColor=[UIColor whiteColor];
    cell.backgroundColor= [UIColor colorWithRed:53.0/255.0 green:77.0/255.0 blue:99.0/255.0 alpha:255.0/255.0];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.tintColor=[UIColor whiteColor];
    return cell;
    
}
-(void)completedToggleTag: (UITableViewCell*)cell{
    if(cell.accessoryType==UITableViewCellAccessoryNone) [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    else [cell setAccessoryType:UITableViewCellAccessoryNone];
}

-(void)post_function:(NSString*) ID andLink:(NSString*)link withCell:(UITableViewCell*)cell andtempstring:(NSString*) tempString{
    NSString *post = [NSString stringWithFormat:tempString, ID];
    NSLog(@"post: %@",post);
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:link]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSURLSession* mysession=[NSURLSession sharedSession];
    
    NSURLSessionUploadTask* task=[mysession uploadTaskWithRequest:request fromData:nil completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString*thedata=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self completedToggleTag:cell];
        });
        
        NSLog(@"%@", thedata);
    }];
    [task resume];

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([tableView cellForRowAtIndexPath:indexPath].accessoryType==UITableViewCellAccessoryNone){
        [self post_function:[[options objectAtIndex:indexPath.row] objectForKey:@"ID"] andLink:@"https://www.snagemgame.com/app_add_tag.php" withCell:[tableView cellForRowAtIndexPath:indexPath] andtempstring:@"addMe=%@"];
    }
    else{
       [self post_function:[[options objectAtIndex:indexPath.row] objectForKey:@"ID"] andLink:@"https://www.snagemgame.com/_db/tags/removeTag.php" withCell:[tableView cellForRowAtIndexPath:indexPath] andtempstring:@"removeMe=%@"];
    }
    
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
