//
//  AddNote.h
//  Snag'em
//
//  Created by Aidan Curtis on 1/1/16.
//  Copyright © 2016 NCSU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddNote : UIViewController
- (IBAction)addnote:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *text;
@property NSString * hid;

@end
