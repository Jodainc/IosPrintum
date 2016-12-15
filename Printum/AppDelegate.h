//
//  AppDelegate.h
//  Printum
//
//  Created by JoyDa on 11/29/16.
//  Copyright © 2016 JoyDa. All rights reserved.
//
#import <RestKit/CoreData.h>
#import <RestKit/RestKit.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic) BOOL authenticated;
@property (nonatomic, strong) NSPersistentContainer *persistentContainer;
@property (nonatomic, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (weak,nonatomic) NSString *exit112;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (void) deleteAllObjects:(NSString *) entityDescription2:(NSString *) entityDescription;
- (void) resetApplicationModel;
@end

