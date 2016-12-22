//
//  FichaViewController.m
//  Printum
//
//  Created by JoyDa on 12/6/16.
//  Copyright © 2016 JoyDa. All rights reserved.
//

#import "FichaViewController.h"

@interface FichaViewController ()

@end

@implementation FichaViewController
@synthesize webUp;
@synthesize data1;
int ii=0;
NSString *textOutput20;

- (void)viewDidLoad {
    [super viewDidLoad];
    if (ii<=0) {
        textOutput20 = [NSString stringWithFormat:@"http://printumsaa.zapto.org:8080/PRO1_Productos/PDF/%@", data1];
        ii++;
    }
    NSURL *websiteUrl = [NSURL URLWithString:textOutput20];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:websiteUrl];
    [webUp loadRequest:urlRequest];
    
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

@end
