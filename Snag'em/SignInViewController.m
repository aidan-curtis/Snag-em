//
//  SignInViewController.m
//  Snag'em
//
//  Created by Aidan Curtis on 6/20/15.
//  Copyright (c) 2015 NCSU. All rights reserved.
//

#import "SignInViewController.h"

@interface SignInViewController ()

@end

@implementation SignInViewController


- (void)registerForKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}

- (void)deregisterFromKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidHideNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
}
- (void)keyboardWasShown:(NSNotification *)notification {
    
    NSDictionary* info = [notification userInfo];
    
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGPoint buttonOrigin =CGPointMake(self.signInButton.frame.origin.x, self.signInButton.frame.origin.y-20);
    
    
    CGFloat buttonHeight = self.signInButton.frame.size.height;
    
    CGRect visibleRect = self.view.frame;
    
    visibleRect.size.height -= keyboardSize.height;
    
    if (!CGRectContainsPoint(visibleRect, buttonOrigin)){
        
        CGPoint scrollPoint = CGPointMake(0.0, buttonOrigin.y - visibleRect.size.height + buttonHeight);
        
        [self.scrollView setContentOffset:scrollPoint animated:YES];
        
    }
    
}

- (void)keyboardWillBeHidden:(NSNotification *)notification {
    
    [self.scrollView setContentOffset:CGPointZero animated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self registerForKeyboardNotifications];
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
   
    
    [self deregisterFromKeyboardNotifications];
    
    [super viewWillDisappear:animated];

    
}


- (void)viewDidLoad {
    [super viewDidLoad];
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
    self.title=@"Login";
    _error.hidden=YES;
    
    
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







- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}
-(void)connectLogIn{
    
    NSString * emailEncoded=[_email.text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    NSString * passwordEncoded=[_password.text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    NSString *post = [NSString stringWithFormat:@"email=%@&password=%@&ismobileapp=%@",emailEncoded,passwordEncoded,@"True"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    
    [request setURL:[NSURL URLWithString:@"https://www.snagemgame.com/login2.php"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    HUD.progress=0.1;
    NSURLSession* task=[NSURLSession sharedSession];
    NSURLSessionUploadTask* maintask =[task uploadTaskWithRequest:request fromData:nil completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        
        NSLog(@"%@", error);
        @try {
            _recievedDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            
        }
        @catch (NSException * e) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                    _error.text=@"Server error :(";
            });
            
            NSLog(@"Exception: %@", e);
        }
        
            
    


        HUD.progress=0.6;

        if (_recievedDictionary){
                NSLog(@"Login Successful");
                //handle dictions with NSUSERdata
                [[NSUserDefaults standardUserDefaults] setObject:post forKey:@"Logged In"];
                for(id key in _recievedDictionary){
                    NSLog(@"%@",key);
                    NSLog(@"%@",[_recievedDictionary objectForKey:key]);
                    [[NSUserDefaults standardUserDefaults] setObject:[_recievedDictionary objectForKey:key] forKey:[NSString stringWithFormat:@"%@",key]];
                }
                NSString *URL=[NSString stringWithFormat:@"https://snagemgame.com/images/players/%@.png", (NSString*)[[NSUserDefaults standardUserDefaults] objectForKey:@"player_IDNUM"]];
                NSData* imageData=[[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: URL]];
            
                HUD.progress=0.8;
   
                if([imageData length]==0){
                    NSString *URL=@"https://snagemgame.com/images/players/no_avatar.png";
                    imageData=[[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: URL]];
                }

                HUD.progress=1.0;
                [[NSUserDefaults standardUserDefaults] setObject:imageData forKey:@"Avitar"];
                UIViewController * page=[self.storyboard instantiateViewControllerWithIdentifier:@"swreveal"];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self presentViewController:page animated:YES completion:nil];
                });
                dispatch_semaphore_signal(semaphore);
            }
            else{
                dispatch_async(dispatch_get_main_queue(), ^{
                _error.hidden=NO;
                NSLog(@"Login Unsuccessful or server is down");
                dispatch_semaphore_signal(semaphore);
                });
                               
            }
       
        
        }];
    [maintask resume];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    // Schedule your connection to run on threads runLoop.
}
- (IBAction)signIn:(id)sender {
    HUD=[[MBProgressHUD alloc] initWithView:self.view];
    HUD.labelText=@"Attempting to Log In";
    HUD.mode=MBProgressHUDModeAnnularDeterminate;
    [self.view addSubview:HUD];
    NSLog(@"%@", @"attempting to log in");
    [HUD showWhileExecuting:@selector(connectLogIn) onTarget:self withObject:nil animated:YES];
    
//    [self connectLogIn];
    
}
- (IBAction)forgotYourPassword:(id)sender {
}
@end
