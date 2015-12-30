//
//  Network.m
//  Snag'em
//
//  Created by Aidan Curtis on 12/27/15.
//  Copyright © 2015 NCSU. All rights reserved.
//

#import "Network.h"
#import "SWRevealViewController.h"
#import "Network_List.h"
@interface Network ()
@end
@implementation Network
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.menu.target=self.revealViewController;
    self.menu.action=@selector(revealToggle:);
    snaggedArray=[[NSUserDefaults standardUserDefaults] objectForKey:@"snaggedArray"];
    profileImageData=[[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"profileImageData"]];
    NSURLSession* task=[NSURLSession sharedSession];
    NSString *stringURL=[NSString stringWithFormat:@"https://www.snagemgame.com/app_network_list.php"];
    NSURLSessionDataTask *jsonData = [task dataTaskWithURL:[NSURL URLWithString:stringURL]
                                         completionHandler:^(NSData *data,
                                                             NSURLResponse *response,
                                                             NSError *error) {

                                             snaggedArray=[NSJSONSerialization JSONObjectWithData:data options: kNilOptions error:nil];
                                             
                                             for(int a=0; a<[snaggedArray count]; a++){
                                                 NSData* temp_data=[NSData dataWithContentsOfURL:
                                                                    [NSURL URLWithString:
                                                                     [NSString stringWithFormat:@"https://www.snagemgame.com/%@",
                                                                      [[snaggedArray objectAtIndex:a]
                                                                       objectForKey:@"image"]]]];
                                                 if(temp_data==nil)temp_data=UIImagePNGRepresentation([UIImage imageNamed:@"no_avatar.png"]);
                                                 [profileImageData addObject:temp_data];
                                             }
                                             [[NSUserDefaults standardUserDefaults] setObject:(NSArray*)profileImageData forKey:@"profileImageData"];
                                             [[NSUserDefaults standardUserDefaults] setObject:snaggedArray forKey:@"snaggedArray"];
                                             dispatch_async(dispatch_get_main_queue(), ^{
                                                 [self.tableView reloadData];
                                             });
                                         }];
    [jsonData resume];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [snaggedArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* TagReuseIdentifier=@"Network_List";
    Network_List* cell=(Network_List*)[self.tableView dequeueReusableCellWithIdentifier:TagReuseIdentifier];
    if(cell==nil){
        cell = [[Network_List alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TagReuseIdentifier];
    }
    if([profileImageData count]!=0 && [snaggedArray count]!=0)
    {
    [cell.image setImage:[UIImage imageWithData:[profileImageData objectAtIndex:indexPath.row]] ];
    [cell.name setText:[[snaggedArray objectAtIndex:indexPath.row]
                        objectForKey:@"name"]];
    [cell.school setText:[NSString stringWithFormat:@"School: %@",
                          [[snaggedArray objectAtIndex:indexPath.row]
                           objectForKey:@"school"]]];
    if([[snaggedArray objectAtIndex:indexPath.row] objectForKey:@"reason"]){
        NSString * temp_string=[[snaggedArray objectAtIndex:indexPath.row] objectForKey:@"reason"];
        [cell.reason1 setText: temp_string];
    }
    else [cell.reason2 setText:@"Not Snagged"];
    if([[snaggedArray objectAtIndex:indexPath.row] objectForKey:@"reason2"])[cell.reason2 setText:[[snaggedArray objectAtIndex:indexPath.row] objectForKey:@"reason2"]];
    
    else [cell.reason2 setText:@"Not Snagged"];
    [cell.email setText:[NSString stringWithFormat:@"Email: %@", [[snaggedArray objectAtIndex:indexPath.row] objectForKey:@"email"]]];
    }
    return cell;
}
@end
