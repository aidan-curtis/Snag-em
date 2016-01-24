//
//  Notes.m
//  Snag'em
//
//  Created by Aidan Curtis on 12/29/15.
//  Copyright © 2015 NCSU. All rights reserved.
//

#import "Notes.h"
#import "AddNote.h"
@interface Notes ()

@end

@implementation Notes
@synthesize  hid;
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"here");
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
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"contains"]){
      
    
    NotesTableViewController* vc= [segue destinationViewController];
        vc.hid=self.hid;
    }
    if([segue.identifier isEqualToString:@"addnote"]){
        AddNote * note= [segue destinationViewController];
        note.hid=self.hid;
        
    }
    
    
}




@end
