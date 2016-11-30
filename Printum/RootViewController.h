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

@property (nonatomic, weak) id <LoginViewProtocol> delegate;
@property (nonatomic, retain) LoginViewController *loginView;
@end
