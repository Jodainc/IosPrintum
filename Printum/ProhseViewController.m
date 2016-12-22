//
//  ProhseViewController.m
//  Printum
//
//  Created by JoyDa on 11/29/16.
//  Copyright © 2016 JoyDa. All rights reserved.
//
#import "ProhseViewController.h"
@interface ProhseViewController ()
@end
@implementation ProhseViewController
@synthesize webView;
@synthesize data;
   int i=0;
- (void)viewDidLoad {
      NSString *textOutput;
      NSLog(@"%d ii",i);
        NSLog(@"%@ ii",data);
            [super viewDidLoad];
    if (i<=0) {
        textOutput = [NSString stringWithFormat:@"http://printumsaa.zapto.org:8080/pRO_hsEG/PDF/%@", data];
        i++;
    }
    NSURL *websiteUrl = [NSURL URLWithString:textOutput];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:websiteUrl];
    [webView loadRequest:urlRequest];
    
}
-(void) datas:(NSString *)data1{
    data1 = data;
    NSLog(@"%@",data1);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
