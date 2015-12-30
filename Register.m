//
//  Register.m
//  Snag'em
//
//  Created by Aidan Curtis on 6/22/15.
//  Copyright (c) 2015 NCSU. All rights reserved.
//

#import "Register.h"
#include <stdlib.h>
#include "FavoritesViewController.h"


@interface Register ()

@end

@implementation Register
@synthesize fnameEncoded;
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
    
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(pickerView==_positionPicker)return [_array_of_positions count];
    else if (pickerView==_locationPicker)return [_array_of_locations count];
    else return [_array_of_schools count];
   
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* label = (UILabel*)view;
    if (view == nil){
        label= [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 290, 44)];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor=[UIColor colorWithRed:92/255.0 green:184/255.0 blue:92/255.0 alpha:255/255];
        label.font=[UIFont systemFontOfSize:20];
    }
    if(pickerView==_schoolPicker)label.text = [_array_of_schools objectAtIndex:row];
    else if (pickerView==_positionPicker)label.text=[_array_of_positions objectAtIndex:row];
    else if (pickerView==_locationPicker)label.text=[_array_of_locations objectAtIndex:row];
    return label;
}
-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(pickerView==_schoolPicker)_currentPickedSchool=[_array_of_school_codes objectAtIndex:row];
    else if(pickerView==_locationPicker)_currentPickedLocation=[_vCode objectAtIndex:row];
    else _currentPickedPosition=[_array_of_position_codes objectAtIndex:row];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _vCode=@[@"49218",
             @"945239",
             @"945240"];
    _array_of_school_codes=@[@"00001264",
                             @"00001201",
                             @"00001295",
                             @"00001202",
                             @"00001203",
                             @"00001204",
                             @"00001296",
                             @"00001205",
                             @"00001297",
                             @"00001298",
                             @"00001299",
                             @"00001206",
                             @"00001207",
                             @"00001300",
                             @"00001271",
                             @"00001301",
                             @"00001302",
                             @"00001208",
                             @"00001209",
                             @"00001210",
                             @"00001303",
                             @"00001304",
                             @"00001211",
                             @"00001212",
                             @"00001305",
                             @"00001213",
                             @"00001306",
                             @"00001214",
                             @"00001307",
                             @"00001308",
                             @"00001309",
                             @"00001310",
                             @"00001311",
                             @"00001312",
                             @"00001313",
                             @"00001314",
                             @"00001215",
                             @"00001216",
                             @"00001217",
                             @"00001218",
                             @"00001219",
                             @"00001315",
                             @"00001316",
                             @"00001220",
                             @"00001221",
                             @"00001222",
                             @"00001317",
                             @"00001223",
                             @"00001318",
                             @"00001319",
                             @"00001320",
                             @"00001321",
                             @"00001322",
                             @"00001224",
                             @"00001225",
                             @"00001226",
                             @"00001323",
                             @"00001324",
                             @"00001325",
                             @"00001326",
                             @"00001327",
                             @"00001328",
                             @"00001329",
                             @"00001227",
                             @"00001228",
                             @"00001330",
                             @"00001331",
                             @"00001332",
                             @"00001422",
                             @"00001333",
                             @"00001334",
                             @"00001335",
                             @"00001229",
                             @"00001337",
                             @"00001336",
                             @"00001230",
                             @"00001338",
                             @"00001339",
                             @"00001231",
                             @"00001340",
                             @"00001341",
                             @"00001342",
                             @"00001232",
                             @"00001233",
                             @"00001343",
                             @"00001344",
                             @"00001234",
                             @"00001235",
                             @"00001345",
                             @"00001236",
                             @"00001237",
                             @"00001238",
                             @"00001239",
                             @"00001240",
                             @"00001241",
                             @"00001242",
                             @"00001346",
                             @"00001347",
                             @"00001348",
                             @"00001349",
                             @"00001243",
                             @"00001350",
                             @"00001244",
                             @"00001351",
                             @"00001352",
                             @"00001353",
                             @"00001245",
                             @"00001354",
                             @"00001355",
                             @"00001246",
                             @"00001356",
                             @"00001247",
                             @"00001248",
                             @"00001249",
                             @"00001357",
                             @"00001358",
                             @"00001359",
                             @"00001250",
                             @"00001360",
                             @"00001251",
                             @"00001361",
                             @"00001364",
                             @"00001365",
                             @"00001366",
                             @"00001252",
                             @"00001253",
                             @"00001367",
                             @"00001368",
                             @"00001369",
                             @"00001370",
                             @"00001371",
                             @"00001372",
                             @"00001254",
                             @"00001373",
                             @"00001374",
                             @"00001375",
                             @"00001376",
                             @"00001377",
                             @"00001378",
                             @"00001255",
                             @"00001362",
                             @"00001445",
                             @"00001379",
                             @"00001380",
                             @"00001381",
                             @"00001382",
                             @"00001256",
                             @"00001363",
                             @"00001383",
                             @"00001257",
                             @"00001258",
                             @"00001293",
                             @"00001437",
                             @"00001384",
                             @"00001385",
                             @"00001386",
                             @"00001259",
                             @"00001260",
                             @"00001387",
                             @"00001388",
                             @"00001261",
                             @"00001389",
                             @"00001390",
                             @"00001391",
                             @"00001392",
                             @"00001393",
                             @"00001262",
                             @"00001263"];
    _array_of_position_codes=@[@"00000102",
                             @"00000106",
                             @"00000107",
                             @"00000108"];
    _filePath=[NSString stringWithContentsOfFile:@"schools.txt" encoding:"UTF-8" error:nil];
    _array_of_positions=@[@"Undergrad",@"Greduate", @"Faculty or Staff",@"Industry Professional"];
    _array_of_locations=@[@"STARS Celebration 2014",
                          @"NCSU Global Village",
                          @"East Coast Gaming Conf."
                          ];
    _array_of_schools=@[@"*Not Listed",
                        @"A4RC",
                        @"aDeNu Research Group. UNED",
                        @"Alcatel-Lucent",
                        @"Anita Borg Institute",
                        @"Arizona State University",
                        @"Army Research Laboratory",
                        @"Auburn University",
                        @"Australian Council for Educational Research",
                        @"Ben Gurion University",
                        @"Beuth University of Applied Sciences Berlin",
                        @"Bowie State University",
                        @"Brownsville ISD",
                        @"Carnegie Learning",
                        @"Carnegie Mellon University",
                        @"CarneyLabs",
                        @"CCKF Limited",
                        @"Central Piedmont Community College",
                        @"Citizen Schools",
                        @"Clemson University",
                        @"Coburg University of Applied Sciences and Arts",
                        @"Columbia University",
                        @"Columbus State University",
                        @"Computing Research Association",
                        @"Cornelsen Schulverlage",
                        @"DePauw University",
                        @"DIPF",
                        @"Duke University",
                        @"EdGE @ TERC",
                        @"Eduworks",
                        @"ENS Cachan",
                        @"ETH Zurich",
                        @"ETS",
                        @"Ewha Womans University",
                        @"ExploreLearning",
                        @"Faculty of Informatics Masaryk University",
                        @"Florida A&amp;M University",
                        @"Florida International University",
                        @"Florida State College - Jacksonville",
                        @"Florida State University",
                        @"Fort Valley State University",
                        @"Fukui Prefectural University",
                        @"Geekie",
                        @"George Mason University",
                        @"Georgia Gwinnett College",
                        @"Georgia Institute of Technology",
                        @"Grupo Santillana",
                        @"Hampton University",
                        @"Hankuk Univ. of Foreign Studies(HUFS)",
                        @"Harvard University",
                        @"Hiroshima University",
                        @"Humboldt-Universitat zu Berlin",
                        @"IIIA-CSIC",
                        @"Illinois Institute of Technology",
                        @"Indiana University - Bloomington",
                        @"Indiana University - Purdue University",
                        @"Information Systems and Machine Learning Lab",
                        @"INRIA",
                        @"Institute for Intelligent Systems",
                        @"Institute of Technology Blanchardstown",
                        @"Instituto Superior Tecnico",
                        @"ISMLL University of Hildesheim",
                        @"IST - Univ. de Lisboa",
                        @"IT-oLogy",
                        @"Johnson C. Smith University",
                        @"Kaplan- Inc.",
                        @"KD Lab- FI MU Brno",
                        @"Kingston Education",
                        @"Kingston University",
                        @"Kisarazu National College of Technology",
                        @"Konan University",
                        @"Kyushu University",
                        @"Livingstone College",
                        @"London Knowledge Lab, University of London",
                        @"London Knowledge Lab- Birkbeck College",
                        @"Loyola University",
                        @"Masaryk University",
                        @"McGraw Hill Education",
                        @"Meredith College",
                        @"Metric Model- LLC",
                        @"Microsoft Research",
                        @"MIT",
                        @"Morehouse College",
                        @"NASA Langley Reserach Center",
                        @"National Institute of Informatics",
                        @"National Research Council of Canada",
                        @"NC A&amp;T University",
                        @"NC State University",
                        @"NMIT",
                        @"North Dakota State University",
                        @"Northern Virginia Community College",
                        @"Northwest Florida State College",
                        @"Oak Ridge National Laboratory",
                        @"Oklahoma State University",
                        @"Old Dominion University",
                        @"Oregon State College",
                        @"Otsuka America Pharmaceutical",
                        @"P. J. Safarik University in Kosice",
                        @"Pearson",
                        @"Polytechnique Montreal",
                        @"PricewaterhouseCoopers",
                        @"Purdue University",
                        @"R&amp;R Artwork",
                        @"Raytheon BBN Technologies",
                        @"Reasoning Mind",
                        @"Rice University",
                        @"Rutgers University",
                        @"Ryerson University",
                        @"School of Education- Sun Yat-sen University",
                        @"Seminole State College",
                        @"Simon Fraser University",
                        @"Solnect Consulting Group",
                        @"South Carolina State University",
                        @"Spelman College",
                        @"SRI International",
                        @"Stanford University",
                        @"Studiare",
                        @"Tallahassee Community College",
                        @"Teachers College- Columbia University",
                        @"TECH CORPS",
                        @"Tel Aviv University",
                        @"TU Darmstadt",
                        @"TU Eindhoven- NL",
                        @"UC Berkeley",
                        @"UNC Charlotte",
                        @"UNC Greensboro",
                        @"UNED",
                        @"Universidad de Malaga",
                        @"Universite Joseph Fourier",
                        @"University at Albany- State University of New York",
                        @"University East of Anglia",
                        @"University of Adelaide",
                        @"University of California - San Diego",
                        @"University of California- Berkeley",
                        @"University of California- Irvine",
                        @"University of Cantabria",
                        @"University of Central Florida",
                        @"University of Colorado",
                        @"University of Cordoba",
                        @"University of Delaware",
                        @"University of Edinburgh",
                        @"University of Florida",
                        @"University of Georgia",
                        @"University of Helsinki",
                        @"University of Jyvaskyla",
                        @"University of Luxembourg",
                        @"University of Massachusetts Amherst/CAITE",
                        @"University of Memphis",
                        @"University of Nevada- Las Vegas",
                        @"University of New Orleans",
                        @"University of North Texas",
                        @"University of Pittsburgh",
                        @"University of Puerto RIco Mayaguez",
                        @"University of Rijeka- Croatia",
                        @"University of Saskatchewan",
                        @"University of Skovde",
                        @"University of South Florida - Lakeland",
                        @"University of Texas at Austin",
                        @"University of Washington",
                        @"University of Waterloo",
                        @"University of Wisconsin Madison",
                        @"UNSW Australia",
                        @"Ursinus College",
                        @"Utah State University",
                        @"Vanderbilt University",
                        @"Vrije Universiteit Brussel",
                        @"Wilberforce University",
                        @"Winthrop University"];
    _currentPickedLocation=[_vCode objectAtIndex:0];
    _currentPickedPosition=[_array_of_position_codes objectAtIndex:0];
    _currentPickedSchool=[_array_of_school_codes objectAtIndex:0];
    self.tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    if ([[ver objectAtIndex:0] intValue] >= 7) {
        // iOS 7.0 or later
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:73.0/255.0 green:92.0/255.0 blue:110.0/255.0 alpha:255.0/255.0];
        self.navigationController.navigationBar.translucent = NO;
    }else {
        // iOS 6.1 or earlier
        self.navigationController.navigationBar.tintColor = [UIColor blueColor];
    }
     [[self navigationController] setNavigationBarHidden:NO animated:YES];
    self.title=@"Register";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData*)data{
    NSString* fullstring=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSRange   searchedRange = NSMakeRange(0, [fullstring length]);
    NSRegularExpression* regEx=[NSRegularExpression regularExpressionWithPattern:@"\\.*(\\d{4})" options:NSRegularExpressionCaseInsensitive error:nil];
    NSTextCheckingResult *match = [regEx firstMatchInString:fullstring options:0 range: searchedRange];
    _UID=[fullstring substringWithRange:[match rangeAtIndex:0]];
    
    
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{

    NSLog(@"%@", [error userInfo]);
    
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    FavoritesViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"DestinationController"];
    controller.UID=_UID;
    controller.fname=fnameEncoded;
    [self.navigationController pushViewController:controller animated:YES];
}

-(BOOL)isValidEmailAddress: (NSString*)myEmailAddress{
    if([myEmailAddress rangeOfString:@"@"].location==NSNotFound)return NO;
    if([myEmailAddress rangeOfString:@"@"].location==[myEmailAddress length]-1)return NO;
    else return YES;
}

-(void)submit{
    NSString* referenceString=@"email=%@&password=%@&fname=%@&lname=%@&gender=%@&sharing=%i&vcode=%@&class=%@&school=%@";
    NSString*emailEncoded=[_emailAddress.text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    fnameEncoded=[_firstName.text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    NSString*lnameEncoded=[_lastName.text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    NSString*passwordEncoded=[_password.text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    NSString*locationEncoded=[_currentPickedLocation stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    NSString*classEncoded=[_currentPickedPosition stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    NSString*schoolEncoded=[_currentPickedSchool stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    NSString *post1 = [NSString stringWithFormat:referenceString, emailEncoded, passwordEncoded, fnameEncoded, lnameEncoded,@[@"M",@"F"][_gender.selectedSegmentIndex], (int)((_share.selectedSegmentIndex-1)*-1), locationEncoded, classEncoded, schoolEncoded];
    NSLog(@"%@", post1);
    NSData *postData = [post1 dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"https://www.snagemgame.com/app_reg_new1.php"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(conn) NSLog(@"Connection Successful");
    else NSLog(@"Connection could not be made");

}

-(void)alert:(NSString*)message{
    UIAlertView *emptyAlert=[[UIAlertView alloc] init];
    [emptyAlert addButtonWithTitle:@"OK"];
    [emptyAlert setTitle:message];
    [emptyAlert show];
}
- (IBAction)finished:(id)sender {

    if([_emailAddress.text length]==0|| [_password.text length]==0|| [_confirmPassword.text length]==0 ||[_firstName.text length]==0||[_lastName.text length]==0)[self alert:@"Please fill in all of the form"];
    else if(![self isValidEmailAddress:_emailAddress.text])[self alert:@"Please enter a valid email address"];
    else if(![_password.text isEqual:_confirmPassword.text])[self alert:@"Your passwords do not match"];
    else [self submit];
    
}
@end