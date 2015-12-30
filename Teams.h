//
//  Teams.h
//  Snag'em
//
//  Created by Aidan Curtis on 11/3/15.
//  Copyright © 2015 NCSU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Teams : UIViewController{
    NSDictionary* team_scores;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menu;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UILabel *ninjapoints;
@property (weak, nonatomic) IBOutlet UILabel *piratepoints;
@property (weak, nonatomic) IBOutlet UILabel *zombiepoints;

@end
