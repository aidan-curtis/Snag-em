//
//  Network.h
//  Snag'em
//
//  Created by Aidan Curtis on 12/27/15.
//  Copyright © 2015 NCSU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Network : UITableViewController{
    NSArray* snaggedArray;
    NSMutableArray * profileImageData, *backupImageData;
    
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menu;


@end
