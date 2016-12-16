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
@synthesize userName;
@synthesize trollPass,back12;
- (IBAction)back123:(id)sender {
    UIViewController* rootController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"initialView"];
    UINavigationController* navigation = [[UINavigationController alloc] initWithRootViewController:rootController];
}

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
    NSString *username = userName.text;
    NSString *password = trollPass.text;
    NSLog(@"%@ nombre::: ",username);
     NSLog(@"%@ npass::: ",password);
    [userObj loginWithUsername:username andPassword:password];
}
@end
