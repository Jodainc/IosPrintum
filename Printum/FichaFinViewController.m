//
//  FichaFinViewController.m
//  Printum
//
//  Created by JoyDa on 12/6/16.
//  Copyright © 2016 JoyDa. All rights reserved.
//

#import "FichaFinViewController.h"
#import "FichaViewController.h"

@interface FichaFinViewController ()

@end

@implementation FichaFinViewController
@synthesize refPro;
@synthesize jTextFiels;
@synthesize btonFind;
- (void)viewDidLoad {
    [super viewDidLoad];

}
- (IBAction)finDact:(id)sender {
    NSString *hol = jTextFiels.text;
    NSLog(@"%@ Holll", hol);
    [self passDataForward];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    
}
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    FichaViewController *pro10;
    pro10 = [segue destinationViewController];
    pro10.data1 = jTextFiels.text;
    
}
- (void)passDataForward
{
    FichaViewController *secondViewController = [[FichaViewController alloc] init];
    secondViewController.data1 = jTextFiels.text;
}
@end
