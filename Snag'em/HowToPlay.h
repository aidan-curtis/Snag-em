//
//  HowToPlay.h
//  Snag'em
//
//  Created by Aidan Curtis on 6/18/15.
//  Copyright (c) 2015 NCSU. All rights reserved.
//

#import "ViewController.h"
#import "PageContentViewController.h"
@interface HowToPlay : UIViewController<UIPageViewControllerDataSource, UIPageViewControllerDelegate>{
    NSArray* missions;
}
@property (strong, nonatomic) UIPageViewController *pageViewController;

@end
