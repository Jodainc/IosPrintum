//
//  User.h
//  Printum
//
//  Created by JoyDa on 11/30/16.
//  Copyright © 2016 JoyDa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

- (void)loginWithUsername:(NSString *)username andPassword:(NSString *)password;
- (void)logout;
- (BOOL)userAuthenticated;
@property (nonatomic,assign) BOOL auth;

@end
