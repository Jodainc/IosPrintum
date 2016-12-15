//
//  ProfileViewController.m
//  Printum
//
//  Created by JoyDa on 11/30/16.
//  Copyright © 2016 JoyDa. All rights reserved.
//

#import "ProfileViewController.h"
#import "RootViewController.h"
#import "AppDelegate.h"
#import "User.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController
@synthesize authenticated2;
@synthesize ver;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        User *userObj = [[User alloc] init];
    authenticated2 = userObj.userAuthenticated;
    NSLog(@"Bool value: %d",[userObj userAuthenticated]);
    NSLog(@"bool %s", self.authenticated2 ? "true" : "false");

    if (authenticated2) {
        UIViewController* rootController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"profileView"];
        UINavigationController* navigation = [[UINavigationController alloc] initWithRootViewController:rootController];
    }else{
        AppDelegate *app = [[AppDelegate alloc]init];
        AppDelegate *authObj = (AppDelegate*)[[UIApplication sharedApplication] delegate];authObj.authenticated = YES;
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        RootViewController *initView =  (RootViewController*)[storyboard instantiateViewControllerWithIdentifier:@"initialView"];
        [initView setModalPresentationStyle:UIModalPresentationFullScreen];
        [self presentViewController:initView animated:NO completion:nil];
    }
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    User *userObj = [[User alloc] init];
    authenticated2 = userObj.userAuthenticated;
    NSLog(@"Bool value: %d",[userObj userAuthenticated]);
    NSLog(@"bool %s", self.authenticated2 ? "true" : "false");
    
    if (authenticated2) {
        UIViewController* rootController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"profileView"];
        UINavigationController* navigation = [[UINavigationController alloc] initWithRootViewController:rootController];
    }else{
        AppDelegate *app = [[AppDelegate alloc]init];
        AppDelegate *authObj = (AppDelegate*)[[UIApplication sharedApplication] delegate];authObj.authenticated = YES;
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        RootViewController *initView =  (RootViewController*)[storyboard instantiateViewControllerWithIdentifier:@"initialView"];
        [initView setModalPresentationStyle:UIModalPresentationFullScreen];
        [self presentViewController:initView animated:NO completion:nil];
    }
    
    
    /*
    if(![(AppDelegate*)[[UIApplication sharedApplication] delegate] authenticated]) {
        
        UIStoryboard *storyboard = self.storyboard;
        
        RootViewController *initView =  (RootViewController*)[storyboard instantiateViewControllerWithIdentifier:@"profileView"];
        [initView setModalPresentationStyle:UIModalPresentationFullScreen];
        [self presentViewController:initView animated:NO completion:nil];
    } else{
        // proceed with the profile view
    }
     */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}
- (IBAction)logoutAction:(id)sender {
           User *userObj = [[User alloc] init];
    AppDelegate *app = [[AppDelegate alloc]init];
    AppDelegate *authObj = (AppDelegate*)[[UIApplication sharedApplication] delegate];authObj.authenticated = NO;
    NSLog(@"Bool value: %d",[userObj userAuthenticated]);
    NSLog(@"bool %s", self.authenticated2 ? "true" : "false");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    RootViewController *initView =  (RootViewController*)[storyboard instantiateViewControllerWithIdentifier:@"initialView"];
    initView.val = @"esqul";
    [initView setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:initView animated:NO completion:nil];
    ver = @"ya";
    [app deleteAllObjects:@"UserList":@"salir"];
    [userObj logout];
    [app saveContext];
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate resetApplicationModel];
    [appDelegate managedObjectContext];
    }
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ( [ver isEqualToString:@"ya"]) {
        RootViewController *pro100;
        pro100 = [segue destinationViewController];
        pro100.val = @"esqul";
    }
}

@end
