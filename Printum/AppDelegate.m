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
#import "RootViewController.h"
#import "User.h"

@interface AppDelegate ()
@end
@implementation AppDelegate
@synthesize exit112;
@synthesize authenticated;
NSUInteger count;
    NSInteger *i1 = 0;
User *userObj;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSError *error;
    if (i1==0) {
        userObj = [[User alloc] init];
    }
    
    //authenticated = [userObj userAuthenticated];
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
        NSPersistentStore *persistentStore = [managedObjectStore addSQLitePersistentStoreAtPath:storePath fromSeedDatabaseAtPath:seedPath withConfiguration:nil options:nil error:&error];
        NSAssert(persistentStore, @"Failed to add persistent store with error: %@", error);
        [managedObjectStore createManagedObjectContexts];
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
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
        authenticated = userObj.auth;
    NSManagedObjectContext *context1 = [RKManagedObjectStore defaultStore].mainQueueManagedObjectContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"UserList"];
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"userName" ascending:YES];
    fetchRequest.sortDescriptors = @[descriptor];
    NSInteger count = [context1 countForFetchRequest:fetchRequest error:&error];
    NSLog(@"%lu  numero autesyyy... ",(unsigned long)count);
    
    if (count>0)

        
    {
        self.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"profileView"];
        i1++;
    }
    else
    {
          self.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"initialView"];
         i1++;
    }
         
        return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {

}
- (void) deleteAllObjects:(NSString *) entityDescription2 :(NSString *) entityDescription {
    exit112 = entityDescription;
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
    NSPersistentStore *store = [self.persistentStoreCoordinator.persistentStores lastObject];
    NSURL *storeURL = store.URL;
    [self.persistentStoreCoordinator removePersistentStore:store error:&error];
    [[NSFileManager defaultManager] removeItemAtURL:storeURL error:&error];
    NSLog(@"Data Reset");
    
    //Make new persistent store for future saves   (Taken From Above Answer)
    if (![self.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // do something with the error
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application {

}
-(void)resetApplicationModel{
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"PrintumDB.sqlite"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtURL:storeURL error:NULL];
    
    NSError* error = nil;
    
    if([fileManager fileExistsAtPath:[NSString stringWithContentsOfURL:storeURL encoding:NSASCIIStringEncoding error:&error]]){
        [fileManager removeItemAtURL:storeURL error:nil];
    }
    self.managedObjectContext = nil;
    self.persistentStoreCoordinator = nil;
}

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}


- (void)applicationDidBecomeActive:(UIApplication *)application {

}


- (void)applicationWillTerminate:(UIApplication *)application {
    if ([exit112 isEqualToString:@"salir"]) {
        NSManagedObjectContext *context = [RKManagedObjectStore defaultStore].mainQueueManagedObjectContext;
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"UserList"];
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
        NSPersistentStore *store = [self.persistentStoreCoordinator.persistentStores lastObject];
        NSURL *storeURL = store.URL;
        [self.persistentStoreCoordinator removePersistentStore:store error:&error];
        [[NSFileManager defaultManager] removeItemAtURL:storeURL error:&error];
    }
    //[self saveContext];
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
