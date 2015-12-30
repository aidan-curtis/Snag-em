//
//  FavoritesViewController.h
//  Snag'em
//
//  Created by Aidan Curtis on 7/4/15.
//  Copyright (c) 2015 NCSU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoritesViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>
- (IBAction)signUp:(id)sender;
@property NSMutableArray* areasOfdStudy;
@property NSArray* arrayOfCodes;
@property NSString* UID;
@property NSString* fname;
@end
