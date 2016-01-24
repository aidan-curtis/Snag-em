//
//  Pre_Register.m
//  Snag'em
//
//  Created by Aidan Curtis on 1/5/16.
//  Copyright © 2016 NCSU. All rights reserved.
//

#import "Pre_Register.h"

@interface Pre_Register ()

@end

@implementation Pre_Register

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)next:(id)sender {
    //wrapping in nssession
    UIStoryboard * sb= [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    Pre_Register* reg=[sb instantiateViewControllerWithIdentifier:@"Pre_Register"];
    //add codes and names below
    [self.navigationController showViewController:reg sender:nil];
}
@end
