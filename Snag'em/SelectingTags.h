//
//  SelectingTags.h
//  Snag'em
//
//  Created by Aidan Curtis on 12/20/15.
//  Copyright © 2015 NCSU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectingTags : UITableViewController{
    NSMutableArray* user_tags;
}
@property (weak, nonatomic) NSArray *options;

@end
