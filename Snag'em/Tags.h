//
//  Tags.h
//  Snag'em
//
//  Created by Aidan Curtis on 11/4/15.
//  Copyright © 2015 NCSU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagsViewController.h"
#import "AddTagsViewController.h"

@interface Tags : UIViewController{
    TagsViewController* tag;
    AddTagsViewController * addtag;
    
    
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menu;
- (IBAction)mytags:(id)sender;
- (IBAction)addtags:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *mytags_button;
@property (weak, nonatomic) IBOutlet UIButton *addtags_button;
@property (weak, nonatomic) IBOutlet UIView *TagsContainerView;

@end
