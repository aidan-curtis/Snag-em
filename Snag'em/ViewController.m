//
//  ViewController.m
//  Snag'em
//
//  Created by Aidan Curtis on 6/17/15.
//  Copyright (c) 2015 NCSU. All rights reserved.
//

#import "ViewController.h"
#import "SignInViewController.h"
#import "Register.h"
#import "Pre_Register.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    post=[[NSUserDefaults standardUserDefaults] objectForKey:@"Logged In"];
    if(post){
        
        HUD=[[MBProgressHUD alloc] initWithView:self.view];
        HUD.labelText=@"Attempting to Log In";
        HUD.mode=MBProgressHUDModeAnnularDeterminate;
        [self.view addSubview:HUD];
        [HUD showWhileExecuting:@selector(connectLogIn) onTarget:self withObject:nil animated:YES];
        
    }
    else{
        _fullBoard.hidden=NO;
    
    }
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewDidAppear:(BOOL)animated{
    if(_presentable){
        _fullBoard.hidden=NO;
    }
        [[self navigationController] setNavigationBarHidden:YES animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)LogIn:(id)sender {
}


- (IBAction)HowToPlay:(id)sender {
     HowToPlay *loginController=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HowToPlay"];
    [self presentViewController:loginController animated:YES completion:nil];
}

- (IBAction)SignUp:(id)sender {
    NSURLSession* task=[NSURLSession sharedSession];
    NSString *stringURL=[NSString stringWithFormat:@"https://www.snagemgame.com/app_get_inbox.php"];
    NSURLSessionDataTask *jsonData = [task dataTaskWithURL:[NSURL URLWithString:stringURL]
                                         completionHandler:^(NSData *data,
                                                             NSURLResponse *response,
                                                             NSError *error) {
                                             
                                             
                                             
                                             dispatch_async(dispatch_get_main_queue(), ^{
                                                 
                                                 UIStoryboard * sb= [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                                 Pre_Register* reg=[sb instantiateViewControllerWithIdentifier:@"Pre_Register"];
                                                 //add codes and names below
                                                 [self.navigationController showViewController:reg sender:nil];
                                                 
                                             });
                                             
                                             
                                             
                                         }];
    [jsonData resume];
}
-(void)connectLogIn{
    
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
                NSLog(@"%@ : %@",key,[_recievedDictionary objectForKey:key]);
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
            self.presentable=YES;
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

@end
