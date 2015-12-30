//
//  PageContentViewController.h
//  Snag'em
//
//  Created by Aidan Curtis on 6/18/15.
//  Copyright (c) 2015 NCSU. All rights reserved.
//

#import "ViewController.h"

@interface PageContentViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *titles;
- (IBAction)mybutton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *myButton;

@property (weak, nonatomic) IBOutlet UITextView *text;
@property NSUInteger pageIndex;
@end
