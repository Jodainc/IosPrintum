//
//  LoginViewController.m
//  Printum
//
//  Created by JoyDa on 11/30/16.
//  Copyright © 2016 JoyDa. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}
- (IBAction)submitBtnPressed:(id)sender {
    User *userObj = [[User alloc] init];
    NSString *username = @"username retrieved through login form";
    NSString *password = @"password retrieved through login form";
    [userObj loginWithUsername:username andPassword:password];
}
@end
