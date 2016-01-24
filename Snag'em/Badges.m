//
//  Badges.m
//  Snag'em
//
//  Created by Aidan Curtis on 12/26/15.
//  Copyright © 2015 NCSU. All rights reserved.
//

#import "Badges.h"

@implementation Badges
@synthesize image1, image2, image3, label1, label2, label3, images, carousel;
- (void)awakeFromNib {
    self.selectionStyle=
    carousel.type = iCarouselTypeCoverFlow;

}



@end
