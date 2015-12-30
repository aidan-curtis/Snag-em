//
//  Tags.m
//  Snag'em
//
//  Created by Aidan Curtis on 11/4/15.
//  Copyright © 2015 NCSU. All rights reserved.
//

#import "Tags.h"
#import "SWRevealViewController.h"
@interface Tags ()

@end

@implementation Tags

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden=NO;
    self.menu.target=self.revealViewController;
    self.menu.action=@selector(revealToggle:);
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    // Do any additional setup after loading the view.
    
    tag=[self.storyboard instantiateViewControllerWithIdentifier:@"TagsList"];
    [self addChildViewController:tag];
    
    addtag=[self.storyboard instantiateViewControllerWithIdentifier:@"AddTags"];
    [self addChildViewController:addtag];
    
    addtag.tableView.frame=_TagsContainerView.frame;
    tag.tableView.frame=_TagsContainerView.frame;
    
    [_TagsContainerView addSubview:addtag.tableView];
    [_TagsContainerView addSubview:tag.tableView];
    
    
    
    [tag didMoveToParentViewController:self];
    [addtag didMoveToParentViewController:self];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)mytags:(id)sender {
    [UIView animateWithDuration:.1 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         _mytags_button.backgroundColor=[UIColor colorWithRed:43/255.0 green:62/255.0 blue:80/255.0 alpha:225/255.0];
                         _addtags_button.backgroundColor=[UIColor colorWithRed:23/255.0 green:42/255.0 blue:60/255.0 alpha:255/255.0];
                     }
                     completion:nil];
    [_TagsContainerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_TagsContainerView addSubview:tag.tableView];
}

- (IBAction)addtags:(id)sender {
    [UIView animateWithDuration:.1 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         _mytags_button.backgroundColor=[UIColor colorWithRed:23/255.0 green:42/255.0 blue:60/255.0 alpha:255/255.0];
                         _addtags_button.backgroundColor=[UIColor colorWithRed:43/255.0 green:62/255.0 blue:80/255.0 alpha:255/255.0];
                     }
                     completion:nil];
    [_TagsContainerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_TagsContainerView addSubview:addtag.tableView];
}
@end
