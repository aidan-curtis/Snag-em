//
//  Register.h
//  Snag'em
//
//  Created by Aidan Curtis on 6/22/15.
//  Copyright (c) 2015 NCSU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Register : UITableViewController<UIPickerViewDelegate, UIPickerViewDataSource>

- (IBAction)finished:(id)sender;
@property NSArray* array_of_schools;
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *emailAddress;
@property (weak, nonatomic) IBOutlet UISegmentedControl *share;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *confirmPassword;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *playedBefore;
@property (weak, nonatomic) IBOutlet UIPickerView *schoolPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *locationPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *positionPicker;
@property NSString* currentPickedSchool;
@property NSString* currentPickedPosition;
@property NSString* currentPickedLocation;
@property NSString* filePath;
@property NSArray* array_of_positions;
@property NSArray* array_of_locations;
@property NSArray* array_of_versions;
@property NSArray* array_of_position_codes;
@property NSArray* array_of_location_codes;
@property NSArray* array_of_version_codes;


@property NSString* UID;
@property NSString* fnameEncoded;
@end


