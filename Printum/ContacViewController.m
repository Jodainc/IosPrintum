//
//  ContacViewController.m
//  Printum
//
//  Created by JoyDa on 12/6/16.
//  Copyright © 2016 JoyDa. All rights reserved.
//

#import "ContacViewController.h"

@interface ContacViewController ()

@end

@implementation ContacViewController
@synthesize weApi;
- (void)viewDidLoad {
    NSString *textOutput2;
    [super viewDidLoad];
    textOutput2 = @"http://www.printum-uv.com/contactenos";
    NSURL *websiteUrl = [NSURL URLWithString:@"http://www.printum-uv.com/contactenos"];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:websiteUrl];
    [weApi loadRequest:urlRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
