//
//  User.m
//  Printum
//
//  Created by JoyDa on 11/30/16.
//  Copyright © 2016 JoyDa. All rights reserved.
//

#import "User.h"

@implementation User
@synthesize auth;
- (void)loginWithUsername:(NSString *)username andPassword:(NSString *)password{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"loginActionFinished" object:self userInfo:nil];
    auth=true;
}

- (void)logout{
    // Here you can delete the account
}

- (BOOL)userAuthenticated {
    if (auth) {
        return YES;
    }
    
    return NO;
}

@end
