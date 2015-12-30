//
//  Teams.m
//  Snag'em
//
//  Created by Aidan Curtis on 11/3/15.
//  Copyright © 2015 NCSU. All rights reserved.
//

#import "Teams.h"
#import "SWRevealViewController.h"
@interface Teams ()

@end

@implementation Teams

- (void)viewDidLoad {
   
    [super viewDidLoad];
    
    
    self.title=@"Teams";
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.menu.target=self.revealViewController;
    self.menu.action=@selector(revealToggle:);
    [_ninjapoints setText:[[NSUserDefaults standardUserDefaults] objectForKey:@"ninja"]];
    
    [_piratepoints setText:[[NSUserDefaults standardUserDefaults] objectForKey:@"pirate"]];
    [_zombiepoints setText:[[NSUserDefaults standardUserDefaults] objectForKey:@"zombie"]];
    
    NSURLSession* task=[NSURLSession sharedSession];
    NSString *stringURL=[NSString stringWithFormat:@"https://www.snagemgame.com/app_team_scores.php"];
    NSURLSessionDataTask *jsonData = [task dataTaskWithURL:[NSURL URLWithString:stringURL]
                                         completionHandler:^(NSData *data,
                                                             NSURLResponse *response,
                                                             NSError *error) {
                                             NSLog(@"here");
                                             team_scores=[NSJSONSerialization JSONObjectWithData:data options: kNilOptions error:nil];
                                             NSLog(@"%@", [team_scores objectForKey:@"ninja"]);
                                             dispatch_async(dispatch_get_main_queue(), ^{
                                          
                                             
                                             [_ninjapoints setText:[team_scores objectForKey:@"ninja"]];
                                             [_piratepoints setText:[team_scores objectForKey:@"pirate"]];
                                             [_zombiepoints setText:[team_scores objectForKey:@"zombie"]];
                                            });
                                             [[NSUserDefaults standardUserDefaults] setObject:[team_scores objectForKey:@"ninja"] forKey:@"ninja"];
                                             [[NSUserDefaults standardUserDefaults] setObject:[team_scores objectForKey:@"pirate"] forKey:@"pirate"];
                                             [[NSUserDefaults standardUserDefaults] setObject:[team_scores objectForKey:@"zombie"] forKey:@"zombie"];
                                         }];
    
    
    [jsonData resume];
  
    
    
    
    
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated{
    [_scrollview setContentSize:CGSizeMake(_scrollview.contentSize.width, [_scrollview subviews][0].frame.size.height+50)];
    
    NSLog(@"%f", _scrollview.contentSize.height);
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

@end
