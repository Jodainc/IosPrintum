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
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if(![(AppDelegate*)[[UIApplication sharedApplication] delegate] authenticated]) {
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        RootViewController *initView =  (RootViewController*)[storyboard instantiateViewControllerWithIdentifier:@"initialView"];
        [initView setModalPresentationStyle:UIModalPresentationFullScreen];
        [self presentViewController:initView animated:NO completion:nil];
    } else{
        // proceed with the profile view
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}


- (IBAction)logoutAction:(id)sender {
    User *userObj = [[User alloc] init];
    [userObj logout];
    AppDelegate *authObj = (AppDelegate*)[[UIApplication sharedApplication] delegate];authObj.authenticated = YES;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    RootViewController *initView =  (RootViewController*)[storyboard instantiateViewControllerWithIdentifier:@"initialView"];
    [initView setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:initView animated:NO completion:nil];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"TrollToken"];
    [fetchRequest setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    NSManagedObjectContext *context = [RKManagedObjectStore defaultStore].mainQueueManagedObjectContext;
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (NSManagedObject *object in fetchedObjects)
    {
        [context deleteObject:object];
    }
    error = nil;
    [context save:&error];
}

@end
