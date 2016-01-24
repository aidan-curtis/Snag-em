//
//  FavoritesViewController.m
//  Snag'em
//
//  Created by Aidan Curtis on 7/4/15.
//  Copyright (c) 2015 NCSU. All rights reserved.
//

#import "FavoritesViewController.h"

@interface FavoritesViewController ()

@end

@implementation FavoritesViewController
@synthesize UID, areasOfdStudy, fname;
- (void)viewDidLoad {
    [super viewDidLoad];
    _arrayOfCodes=@[@"00001478",
                    @"00001479",
                    @"00001480",
                    @"00001481",
                    @"00001482",
                    @"00001483",
                    @"00001484",
                    @"00001485",
                    @"00001486",
                    @"00001487",
                    @"00001488",
                    @"00001489",
                    @"00001490",
                    @"00001491",
                    @"00001492",
                    @"00001493",
                    @"00001494",
                    @"00001534",
                    @"00001537",
                    @"00001545",
                    @"00001546"
                    ];
    areasOfdStudy=[[NSMutableArray alloc] initWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];
    self.tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    if ([[ver objectAtIndex:0] intValue] >= 7) {
        // iOS 7.0 or later
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:73.0/255.0 green:92.0/255.0 blue:110.0/255.0 alpha:255.0/255.0];
        self.navigationController.navigationBar.translucent = NO;
    }else {
        // iOS 6.1 or earlier
        self.navigationController.navigationBar.tintColor = [UIColor blueColor];
    }
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    self.title=@"Area Of Study";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath   *)indexPath
{

    if([tableView cellForRowAtIndexPath:indexPath].accessoryType==UITableViewCellAccessoryCheckmark){
        [areasOfdStudy replaceObjectAtIndex:indexPath.row withObject:@"0"];
        [tableView cellForRowAtIndexPath:indexPath].accessoryType =UITableViewCellAccessoryNone;
    }
    else {
        [areasOfdStudy replaceObjectAtIndex:indexPath.row withObject:@"1"];
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData*)data{
     NSString* fullstring=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

    
    
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    


}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//
- (IBAction)signUp:(id)sender {
    NSMutableString* referenceString=[[NSMutableString alloc] init];
    [referenceString appendString:[NSString stringWithFormat:@"UID=%@", UID]];
    for(int a=0; a<sizeof(areasOfdStudy); a++){
        if([[areasOfdStudy objectAtIndex:a] isEqual:@"1"]){
            [referenceString appendString:[NSString stringWithFormat:@"&research[]=%@",[_arrayOfCodes objectAtIndex:a]]];
        }
    }
   
    //NSLog(@"%@", referenceString);
    NSString*referenceStringEncoded=[referenceString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    NSString *post2 = referenceStringEncoded;
    NSLog(@"%@", post2);
    NSData *postData2 = [post2 dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength2 = [NSString stringWithFormat:@"%d",[postData2 length]];
    NSMutableURLRequest *request2 = [[NSMutableURLRequest alloc] init];
    [request2 setURL:[NSURL URLWithString:@"https://snagemgame.com/app_reg_new2.php"]];
    [request2 setHTTPMethod:@"POST"];
    [request2 setValue:postLength2 forHTTPHeaderField:@"Content-Length"];
    [request2 setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request2 setHTTPBody:postData2];
    NSURLConnection *conn2 = [[NSURLConnection alloc] initWithRequest:request2 delegate:self];
    if(conn2) {
        NSLog(@"Connection Successful");
    } else {
        NSLog(@"Connection could not be made");
    }

}
@end
