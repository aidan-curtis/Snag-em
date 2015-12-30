//
//  Mission.h
//  Snag'em
//
//  Created by Aidan Curtis on 7/28/15.
//  Copyright (c) 2015 NCSU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Mission : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *user_input;
@property (weak, nonatomic) IBOutlet UILabel *missionName;
@property (weak, nonatomic) IBOutlet UIImageView *missionImage;
@property (weak, nonatomic) IBOutlet UILabel *percentLabel;
@property UIImage* imageStore;
@property int missionID;
@property NSString* titleStore;
@property NSString* percentString;
- (IBAction)go:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *actiongood;
- (IBAction)home:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *image_holder;

@end
