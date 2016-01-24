//
//  Pre_Register.h
//  Snag'em
//
//  Created by Aidan Curtis on 1/5/16.
//  Copyright © 2016 NCSU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Pre_Register : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *email_address;
@property (weak, nonatomic) IBOutlet UIPickerView *location;

- (IBAction)next:(id)sender;

@end
