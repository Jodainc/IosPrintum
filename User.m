//
//  User.m
//  Printum
//
//  Created by JoyDa on 11/30/16.
//  Copyright © 2016 JoyDa. All rights reserved.
//
#import <RestKit/RestKit.h>
#import <RestKit/CoreData.h>
#import "User.h"
#import "TrollToen.h"
@implementation User
@synthesize auth;
- (void)loginWithUsername:(NSString *)username andPassword:(NSString *)password{
    NSLog(@"Bool value: %d",auth);
    NSLog(@"%@ Name1",username);
    NSLog(@"%@ Password2",password);
    TrollToen *trol = [TrollToen new];
    trol.userName = username;
    trol.password = password;
    trol.token_type = @"password";
    NSLog(@"%@ Name",trol.userName);
    NSLog(@"%@ Password",trol.password);
    NSLog(@"%@ Name",trol.token_type);
    //[self postToken:trol];
    if (auth) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"loginActionFinished" object:self userInfo:nil];
        auth=true;
    }else{
        auth=false;
    }

}

- (void)postToken:(TrollToen *)trolltoken
{
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    RKObjectManager *manager = [RKObjectManager sharedManager];
    RKObjectMapping *responseMapping = [RKObjectMapping mappingForClass:[TrollToen class]];
    NSArray *mappingArray = @[@"username", @"password", @"token_type"];
    [responseMapping addAttributeMappingsFromArray:mappingArray];
    
    
    
    manager.requestSerializationMIMEType = RKMIMETypeJSON;
    
    NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful);
    RKResponseDescriptor *responseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:responseMapping
                                                 method:RKRequestMethodAny
                                            pathPattern:@"/token"
                                                keyPath:nil
                                            statusCodes:statusCodes];
    

    RKObjectMapping *requestMapping = [RKObjectMapping requestMapping];
    [requestMapping addAttributeMappingsFromArray:mappingArray];
    RKRequestDescriptor *requestDescriptor = [RKRequestDescriptor
                                              requestDescriptorWithMapping:requestMapping
                                              objectClass:[TrollToen class]
                                              rootKeyPath:nil
                                              method:RKRequestMethodAny];
    [manager addResponseDescriptor:responseDescriptor];
    [manager addRequestDescriptor:requestDescriptor];
    
    NSDictionary *params = @{
                             @"username":   trolltoken.userName,
                             @"password":  trolltoken.password,
                             @"token_type": trolltoken.token_type
                             };
    [manager postObject:trolltoken path:@"/token" parameters:params
                success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                    NSLog(@"SUCCESS: %@", mappingResult.array);
                } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                    NSLog(@"FAILED: %@", error);
                }];
}
- (void)logout{

}

- (BOOL)userAuthenticated {
    if (auth) {
        return YES;
    }
    return NO;
}

@end
