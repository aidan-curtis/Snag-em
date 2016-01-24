//
//  AddNote.m
//  Snag'em
//
//  Created by Aidan Curtis on 1/1/16.
//  Copyright © 2016 NCSU. All rights reserved.
//

#import "AddNote.h"
@interface AddNote ()

@end

@implementation AddNote

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
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

- (IBAction)addnote:(id)sender {
    NSString *post = [NSString stringWithFormat:@"to=%@&from=%@&subject=Note&message=%@&version=%@&isNote=true",[[NSUserDefaults standardUserDefaults] objectForKey:@"player_IDNUM"], _hid, _text.text,[[NSUserDefaults standardUserDefaults] objectForKey:@"VersionName"]];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"https://www.snagemgame.com/_db/messages/sendMessage.php"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSURLSession* mysession=[NSURLSession sharedSession];
    
    NSURLSessionUploadTask* task=[mysession uploadTaskWithRequest:request fromData:nil completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    
        dispatch_async(dispatch_get_main_queue(), ^{
            NSMutableArray* temp_array=  [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"notes%@", _hid]]];
            [temp_array addObject:_text.text];
            [[NSUserDefaults standardUserDefaults] setObject:(NSArray*)temp_array forKey:[NSString stringWithFormat:@"notes%@", _hid]];
             [self.navigationController popViewControllerAnimated:YES];
        });
       

        
    }];
    [task resume];
    
}



@end
