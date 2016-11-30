//
//  HseFinViewController.m
//  Printum
//
//  Created by JoyDa on 11/29/16.
//  Copyright © 2016 JoyDa. All rights reserved.
//

#import "HseFinViewController.h"
#import "ProhseViewController.h"

@interface HseFinViewController ()
@end

@implementation HseFinViewController
  @synthesize labelJa;
@synthesize findButton;
@synthesize label;
- (void)viewDidLoad {
    [super viewDidLoad];
    
}
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"continue"]){
        //ProhseViewController *prohse =
        NSString *hol = labelJa.text;
        NSLog(@"%@ Holll", hol);
        [self passDataForward];
        
    }
}
- (void)passDataForward
{
    ProhseViewController *secondViewController = [[ProhseViewController alloc] init];
    secondViewController.data = labelJa.text; // Set the exposed property
    [self.navigationController pushViewController:secondViewController animated:YES];
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

- (IBAction)find:(id)sender {
    NSString *hol = labelJa.text;
    label.text = hol;


    
    
}
@end
