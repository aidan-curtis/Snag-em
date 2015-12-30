//
//  Avitar.h
//  Snag'em
//
//  Created by Aidan Curtis on 12/25/15.
//  Copyright © 2015 NCSU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Avitar : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *inbox;
@property UIImage* image_meta;
@property NSString* inbox_meta;


@end
