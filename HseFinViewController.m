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

- (IBAction)next:(id)sender {
    NSString *hol = labelJa.text;
    [self passDataForward :hol];
}
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    ProhseViewController *pro;
    pro = [segue destinationViewController];
    pro.data = labelJa.text;
    
}
- (void)passDataForward:(NSString *)username
{
    ProhseViewController *secondViewController = [[ProhseViewController alloc] init];
    secondViewController.data = username;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
