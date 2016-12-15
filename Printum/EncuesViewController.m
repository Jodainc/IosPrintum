//
//  EncuesViewController.m
//  Printum
//
//  Created by JoyDa on 12/6/16.
//  Copyright © 2016 JoyDa. All rights reserved.
//
#import "EncuesViewController.h"
@interface EncuesViewController ()
@end
@implementation EncuesViewController
@synthesize webApi;
- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *fileName= @"http://www.printum-uv.com";
    NSURL *url = [NSURL URLWithString:fileName];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webApi setScalesPageToFit:YES];
    [webApi loadRequest:request];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
