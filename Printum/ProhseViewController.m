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
@synthesize data;
@synthesize webView;
   int i=0;
   NSString *textOutput;

- (void)viewDidLoad {
      NSLog(@"%d ii",i);
    if (i<=0) {
        textOutput = [NSString stringWithFormat:@"http://192.168.0.98:8080/pRO_hsEG/PDF/%@", data];
        i++;
    }
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
