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
@synthesize val;
@synthesize authenticated22;
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSError *error=nil;
    if ([val isEqualToString:@"esqul"] ) {
        [self deleteAllObjectss:@"UserList" ];
    }
    User *userObj = [[User alloc] init];
    authenticated22 = userObj.userAuthenticated;
    NSLog(@"Bool valorrrrr: %d",[userObj userAuthenticated]);
    NSLog(@"bool %s", self.authenticated22 ? "true" : "false");
    if (authenticated22)
    {
        UIViewController* rootController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"profileView"];
        UINavigationController* navigation = [[UINavigationController alloc] initWithRootViewController:rootController];
    }else{
        UIViewController* rootController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"initialView"];
        UINavigationController* navigation = [[UINavigationController alloc] initWithRootViewController:rootController];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) deleteAllObjectss:(NSString *) entityDescription2  {
    NSManagedObjectContext *context = [RKManagedObjectStore defaultStore].mainQueueManagedObjectContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:entityDescription2];
    [fetchRequest setIncludesPropertyValues:YES];
    NSError *error;
    error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (NSManagedObject *object in fetchedObjects)
    {
        [context deleteObject:object];
    }
    NSFetchRequest *fetchRequest1 = [[NSFetchRequest alloc] initWithEntityName:@"UserList"];
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"userName" ascending:YES];
    fetchRequest1.sortDescriptors = @[descriptor];
    NSUInteger count = [context countForFetchRequest:fetchRequest1 error:&error];
    NSLog(@"%lu  numero aut12",(unsigned long)count);
    
    if (![context save:&error]) {
        NSLog(@"Save Failed! %@ %@", error, [error localizedDescription]);
    }
    NSPersistentStore *store = [self.persistentStoreCoordinatorr.persistentStores lastObject];
    NSURL *storeURL = store.URL;
    [self.persistentStoreCoordinatorr removePersistentStore:store error:&error];
    [[NSFileManager defaultManager] removeItemAtURL:storeURL error:&error];
    NSLog(@"Data Reset");
    
    //Make new persistent store for future saves   (Taken From Above Answer)
    if (![self.persistentStoreCoordinatorr addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // do something with the error
    }
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
