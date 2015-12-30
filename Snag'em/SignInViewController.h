//
//  SignInViewController.h
//  Snag'em
//
//  Created by Aidan Curtis on 6/20/15.
//  Copyright (c) 2015 NCSU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"




@interface SignInViewController : UIViewController{
    MBProgressHUD * HUD;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
- (IBAction)signIn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *forgotYourPasswordButton;
- (IBAction)forgotYourPassword:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UILabel *error;
@property NSDictionary *recievedDictionary;
-(void)connectLogIn;
@end
