//
//  AppDelegate.m
//  Printum
//
//  Created by JoyDa on 11/29/16.
//  Copyright © 2016 JoyDa. All rights reserved.
//
#import <RestKit/RestKit.h>
#import <RestKit/CoreData.h>
#import "AppDelegate.h"
#import "User.h"

@interface AppDelegate ()
@end
@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    User *userObj = [[User alloc] init];
    self.authenticated = [userObj userAuthenticated];
    NSLog(@"Bool value: %d",[userObj userAuthenticated]);
    NSLog(@"bool %s", self.authenticated ? "true" : "false");
    
    NSURL *baseURL = [NSURL URLWithString:@"http://192.168.0.98:8080"];
    RKObjectManager *objectManager = [RKObjectManager managerWithBaseURL:baseURL];
    
    
    NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
    objectManager.managedObjectStore = managedObjectStore;
    
    RKLogConfigureByName("RestKit/Network", RKLogLevelTrace);
    RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelTrace);
    
    [managedObjectStore createPersistentStoreCoordinator];
    NSString *storePath = [RKApplicationDataDirectory() stringByAppendingPathComponent:@"PrintumDB.sqlite"];
    NSString *seedPath = [[NSBundle mainBundle] pathForResource:@"RKSeedDatabase" ofType:@"sqlite"];
    NSError *error;
    NSPersistentStore *persistentStore = [managedObjectStore addSQLitePersistentStoreAtPath:storePath fromSeedDatabaseAtPath:seedPath withConfiguration:nil options:nil error:&error];
    NSAssert(persistentStore, @"Failed to add persistent store with error: %@", error);
    
    // Create the managed object contexts
    [managedObjectStore createManagedObjectContexts];
    
    // Configure a managed object cache to ensure we do not create duplicate objects
    managedObjectStore.managedObjectCache = [[RKInMemoryManagedObjectCache alloc] initWithManagedObjectContext:managedObjectStore.persistentStoreManagedObjectContext];

    RKEntityMapping *articleListMapping = [RKEntityMapping mappingForEntityForName:@"UserList" inManagedObjectStore:managedObjectStore];
    articleListMapping.identificationAttributes = @[ @"userName" ];
    
    [articleListMapping
     addAttributeMappingsFromDictionary:
     @{
       @"userName" : @"userName",
       @"token_type" : @"token_type",
       @"access_token" : @"trollTokens"
       }
     ];
    
    RKEntityMapping *articleMapping = [RKEntityMapping mappingForEntityForName:@"TrollToken" inManagedObjectStore:managedObjectStore];
    articleMapping.identificationAttributes = @[ @"userName" ];
    [articleMapping addAttributeMappingsFromArray:@[@"cities", @"cityId", @"companies", @"companyId", @"deparmentModels", @"departmentId", @"firtsName", @"lastName", @"userAddress" , @"userId" , @"userPhone" , @"userPhoto" ,@"token_type"]];
    
    [articleListMapping addPropertyMapping:
     [RKRelationshipMapping relationshipMappingFromKeyPath:@"trollToken"
                                                 toKeyPath:@"trollTokenr"
                                               withMapping:articleMapping]
     ];

    RKResponseDescriptor *articleListResponseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:articleListMapping
                                                 method:RKRequestMethodPOST
                                            pathPattern:@"/token"
                                                keyPath:nil
                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)
     
     ];
    
    [objectManager addResponseDescriptor:articleListResponseDescriptor];
    
    // Enable Activity Indicator Spinner
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    NSManagedObjectContext *context = [RKManagedObjectStore defaultStore].mainQueueManagedObjectContext;
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"TrollToken"];
    
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"userName" ascending:YES];
    fetchRequest.sortDescriptors = @[descriptor];
    
    NSUInteger count = [context countForFetchRequest:fetchRequest error:&error];
    NSLog(@"%lu  numero aut1",(unsigned long)count);
    if (count>0)
    {
        self.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
    }
    else
    {
        UIViewController* rootController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"initialView"];
        UINavigationController* navigation = [[UINavigationController alloc] initWithRootViewController:rootController];
        
        self.window.rootViewController = navigation;
    }
    
    
    
    return YES;
}


- (void)setupRestKit
{
    // initiate Object Manager, Model & Store
    RKObjectManager *manager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:@"http://192.168.0.98:8080"]];
    NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
    manager.managedObjectStore = managedObjectStore;
    
    // define Entity mapping to core data
    RKEntityMapping *userMapping = [RKEntityMapping mappingForEntityForName:@"TrollToken" inManagedObjectStore:managedObjectStore];
    userMapping.identificationAttributes = @[ @"userName" ];
    NSArray *mappingArray = @[@"userName", @"trollToken", @"token_type"];
    [userMapping addAttributeMappingsFromArray:mappingArray];
    
    // Core Data stack initialization
    [managedObjectStore createPersistentStoreCoordinator];
    NSString *storePath = [RKApplicationDataDirectory() stringByAppendingPathComponent:@"Printum.sqlite"];
    NSError *error;
    NSPersistentStore *persistentStore =
    [managedObjectStore addSQLitePersistentStoreAtPath:storePath
                                fromSeedDatabaseAtPath:nil
                                     withConfiguration:nil
                                               options:@{
                                                         NSMigratePersistentStoresAutomaticallyOption:@YES,
                                                         NSInferMappingModelAutomaticallyOption:@YES
                                                         }
                                                 error:&error];
    NSAssert(persistentStore, @"Failed to add persistent store with error: %@", error);
    
    // Create the managed object contexts
    [managedObjectStore createManagedObjectContexts];
    // Configure a managed object cache to ensure we do not create duplicate objects
    managedObjectStore.managedObjectCache = [[RKInMemoryManagedObjectCache alloc]
                                             initWithManagedObjectContext:managedObjectStore.persistentStoreManagedObjectContext];
}

- (void)applicationWillResignActive:(UIApplication *)application {

}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {

}


- (void)applicationDidBecomeActive:(UIApplication *)application {

}


- (void)applicationWillTerminate:(UIApplication *)application {

    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Printum"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
