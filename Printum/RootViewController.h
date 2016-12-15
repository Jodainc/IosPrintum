//
//  RootViewController.h
//  Printum
//
//  Created by JoyDa on 11/30/16.
//  Copyright © 2016 JoyDa. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "LoginViewController.h"

@protocol LoginViewProtocol <NSObject>

- (void)dismissAndLoginView;

@end

@interface RootViewController : UIViewController
- (void) deleteAllObjectss:(NSString *) entityDescription22:(NSString *) entityDescription11;
@property (nonatomic, weak) id <LoginViewProtocol> delegate;
@property (nonatomic, retain) LoginViewController *loginView;
@property (nonatomic,weak) NSString *val;
@property (nonatomic) BOOL authenticated22;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinatorr;
@end
