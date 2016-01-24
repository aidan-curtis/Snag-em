//
//  ViewController.h
//  Snag'em
//
//  Created by Aidan Curtis on 6/17/15.
//  Copyright (c) 2015 NCSU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HowToPlay.h"
#import "MBProgressHUD.h"
@interface ViewController : UIViewController{
    NSString* post;
    MBProgressHUD * HUD;
}
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UILabel *error;
@property NSDictionary *recievedDictionary;
@property BOOL presentable;
-(void)connectLogIn;
- (IBAction)LogIn:(id)sender;
- (IBAction)HowToPlay:(id)sender;
- (IBAction)SignUp:(id)sender;




@property (weak, nonatomic) IBOutlet UIView *fullBoard;

@end

