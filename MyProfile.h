//
//  MyProfile.h
//  Snag'em
//
//  Created by Aidan Curtis on 12/25/15.
//  Copyright © 2015 NCSU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Avitar.h"
#import "Badges.h"
#import "Event.h"
#import "Info.h"


@interface MyProfile : UITableViewController <iCarouselDataSource, iCarouselDelegate>{
    NSDictionary * profileDictionary;
    NSArray * badgeImages;
    NSData * profileImage;
    

    
}
@property (weak, nonatomic) IBOutlet iCarousel *carousel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menu;
- (IBAction)edit:(id)sender;

@end
