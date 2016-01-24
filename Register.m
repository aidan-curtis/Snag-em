//
//  Register.m
//  Snag'em
//
//  Created by Aidan Curtis on 6/22/15.
//  Copyright (c) 2015 NCSU. All rights reserved.
//

#import "Register.h"
#include <stdlib.h>
#include "FavoritesViewController.h"


@interface Register ()

@end

@implementation Register
@synthesize fnameEncoded, array_of_location_codes, array_of_locations, array_of_position_codes, array_of_positions, array_of_schools, array_of_version_codes, array_of_versions;

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
    
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(pickerView==_positionPicker)return [array_of_positions count];
    else if (pickerView==_locationPicker)return [array_of_locations count];
    else return [array_of_schools count];
   
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* label = (UILabel*)view;
    if (view == nil){
        label= [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 290, 44)];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor=[UIColor colorWithRed:92/255.0 green:184/255.0 blue:92/255.0 alpha:255/255];
        label.font=[UIFont systemFontOfSize:20];
    }
    if(pickerView==_schoolPicker)label.text = [array_of_schools objectAtIndex:row];
    else if (pickerView==_positionPicker)label.text=[array_of_positions objectAtIndex:row];
    else if (pickerView==_locationPicker)label.text=[array_of_locations objectAtIndex:row];
    return label;
}
-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(pickerView==_schoolPicker)_currentPickedSchool=[array_of_version_codes objectAtIndex:row];
    else if(pickerView==_locationPicker)_currentPickedLocation=[array_of_versions objectAtIndex:row];
    else _currentPickedPosition=[array_of_position_codes objectAtIndex:row];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    
    _currentPickedLocation=[array_of_versions objectAtIndex:0];
    _currentPickedPosition=[array_of_position_codes objectAtIndex:0];
    _currentPickedSchool=[array_of_version_codes objectAtIndex:0];
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
    self.title=@"Register";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData*)data{
    NSString* fullstring=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSRange   searchedRange = NSMakeRange(0, [fullstring length]);
    NSRegularExpression* regEx=[NSRegularExpression regularExpressionWithPattern:@"\\.*(\\d{4})" options:NSRegularExpressionCaseInsensitive error:nil];
    NSTextCheckingResult *match = [regEx firstMatchInString:fullstring options:0 range: searchedRange];
    _UID=[fullstring substringWithRange:[match rangeAtIndex:0]];
    
    
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{

    NSLog(@"%@", [error userInfo]);
    
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    FavoritesViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"DestinationController"];
    controller.UID=_UID;
    controller.fname=fnameEncoded;
    [self.navigationController pushViewController:controller animated:YES];
}

-(BOOL)isValidEmailAddress: (NSString*)myEmailAddress{
    if([myEmailAddress rangeOfString:@"@"].location==NSNotFound)return NO;
    if([myEmailAddress rangeOfString:@"@"].location==[myEmailAddress length]-1)return NO;
    else return YES;
}

-(void)submit{
    NSString* referenceString=@"email=%@&password=%@&fname=%@&lname=%@&gender=%@&sharing=%i&vcode=%@&class=%@&school=%@";
    NSString*emailEncoded=[_emailAddress.text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    fnameEncoded=[_firstName.text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    NSString*lnameEncoded=[_lastName.text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    NSString*passwordEncoded=[_password.text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    NSString*locationEncoded=[_currentPickedLocation stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    NSString*classEncoded=[_currentPickedPosition stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    NSString*schoolEncoded=[_currentPickedSchool stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    NSString *post1 = [NSString stringWithFormat:referenceString, emailEncoded, passwordEncoded, fnameEncoded, lnameEncoded,@[@"M",@"F"][_gender.selectedSegmentIndex], (int)((_share.selectedSegmentIndex-1)*-1), locationEncoded, classEncoded, schoolEncoded];
    NSLog(@"%@", post1);
    NSData *postData = [post1 dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"https://www.snagemgame.com/app_reg_new1.php"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(conn) NSLog(@"Connection Successful");
    else NSLog(@"Connection could not be made");
    
    
    
//    //temporary
//    FavoritesViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"DestinationController"];
//    controller.UID=_UID;
//    controller.fname=fnameEncoded;
//    [self.navigationController pushViewController:controller animated:YES];

}

-(void)alert:(NSString*)message{
    UIAlertView *emptyAlert=[[UIAlertView alloc] init];
    [emptyAlert addButtonWithTitle:@"OK"];
    [emptyAlert setTitle:message];
    [emptyAlert show];
}
- (IBAction)finished:(id)sender {

    if([_emailAddress.text length]==0|| [_password.text length]==0|| [_confirmPassword.text length]==0 ||[_firstName.text length]==0||[_lastName.text length]==0)[self alert:@"Please fill in all of the form"];
    else if(![self isValidEmailAddress:_emailAddress.text])[self alert:@"Please enter a valid email address"];
    else if(![_password.text isEqual:_confirmPassword.text])[self alert:@"Your passwords do not match"];
    else [self submit];
    
}
@end