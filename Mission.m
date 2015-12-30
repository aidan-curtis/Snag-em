//
//  Mission.m
//  Snag'em
//
//  Created by Aidan Curtis on 7/28/15.
//  Copyright (c) 2015 NCSU. All rights reserved.
//

#import "Mission.h"

@implementation Mission

@synthesize missionImage, missionName, imageStore, titleStore, percentString, percentLabel, missionID;
-(void) viewDidLoad{
    [super viewDidLoad];
    NSLog(@"%i", missionID);
    missionName.text=titleStore;
    missionImage.image=imageStore;
    percentLabel.text=percentString;
}


- (IBAction)go:(id)sender {
    [self.view endEditing:YES];
    NSLog(@"pressed go %@", _user_input.text);
    if(_user_input.text.length!=4){
        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"Must be 4 digits long" message:@"please enter a valid snag'em ID so you don't lose points" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else{
        NSString *post = [NSString stringWithFormat:@"action=snag&missionID=%i&targetID=%@", missionID, _user_input.text];
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:@"https://www.snagemgame.com/app_do_mission.php"]];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
        NSURLSession* mysession=[NSURLSession sharedSession];
        
        NSURLSessionUploadTask* task=[mysession uploadTaskWithRequest:request fromData:nil completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSString*thedata=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            dispatch_async(dispatch_get_main_queue(), ^{

                NSLog(@"%@", thedata);
                
                if([thedata isEqualToString:@"CHEATER"]){
                    self.actiongood.backgroundColor=[UIColor redColor];
                    self.image_holder.image=[UIImage imageNamed:@"filthyFace"];
                }
                self.actiongood.hidden=NO;
            });
            
            NSLog(@"%@", thedata);
        }];
        [task resume];
    
    }
}
- (IBAction)home:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
