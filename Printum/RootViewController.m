//
//  RootViewController.m
//  Printum
//
//  Created by JoyDa on 11/30/16.
//  Copyright © 2016 JoyDa. All rights reserved.
//


#import "RootViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
@interface RootViewController ()
@end
@implementation RootViewController
@synthesize loginView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSError *error=nil;
    NSManagedObjectContext *context = [RKManagedObjectStore defaultStore].mainQueueManagedObjectContext;
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"TrollToken"];
    
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"userName" ascending:YES];
    fetchRequest.sortDescriptors = @[descriptor];
    
    NSUInteger count = [context countForFetchRequest:fetchRequest error:&error];
    NSLog(@"%lu  numero aut10",(unsigned long)count);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



- (IBAction)loginBtnPress:(id)sender {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginActionFinished:)
                                           name:@"loginActionFinished"
                                               object:loginView];
}

-(void) loginActionFinished:(NSNotification*)notification {
    
    AppDelegate *authObj = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    authObj.authenticated = YES;
    
    [self dismissLoginAndShowProfile];
}

- (void)dismissLoginAndShowProfile {
    [self dismissViewControllerAnimated:NO completion:^{
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UITabBarController *tabView = [storyboard instantiateViewControllerWithIdentifier:@"profileView"];
        [self presentViewController:tabView animated:YES completion:nil];
    }];
    
    
}

@end
