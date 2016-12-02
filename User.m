//
//  User.m
//  Printum
//
//  Created by JoyDa on 11/30/16.
//  Copyright © 2016 JoyDa. All rights reserved.
#import <RestKit/RestKit.h>
#import <RestKit/CoreData.h>
#import "User.h"
#import "TrollToken+CoreDataClass.h"
@implementation User
@synthesize auth;
- (void)loginWithUsername:(NSString *)username andPassword:(NSString *)password{
    NSLog(@"Bool value: %d",auth);
    NSLog(@"%@ Name1",username);
  //  NSLog(@"%@ Name",trol.userName);
   // NSLog(@"%@ Password",trol.password);
   // NSLog(@"%@ Name",trol.token_type);
   // [self postToken:trol];
     NSString *textOutput;
    textOutput = [NSString  stringWithFormat:@"=%@&password=%@&grant_type=%@", username,password,@"password" ];
    NSLog(@"%@ Name",textOutput);
    RKObjectManager * obje =  [RKObjectManager sharedManager];
    //obje.requestSerializationMIMEType.stringByRemovingPercentEncoding;
    
    NSDictionary *dic = @{@"userName":username,@"password":password,@"grant_type":@"password"};
    [obje postObject: nil
           path:@"/token"
          parameters:dic
        success: ^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
            //articles have been saved in core data by now
            [self fetchArticlesFromContext : username];
            NSLog(@"@%",@"Entroooo");
        }
        failure: ^(RKObjectRequestOperation *operation, NSError *error) {
            RKLogError(@"Load failed with error: %@", error);
        }];
    
    /*
    [     [RKObjectManager sharedManager]
     postObject: nil
     path:@"/token"
     parameters:[NSString stringWithFormat:@"userName=%@&password=%@&grant_type=%@", username,password,@"password"]
     success: ^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
         //articles have been saved in core data by now
         [self fetchArticlesFromContext];
         NSLog(@"@%",@"Entroooo");
     }
     failure: ^(RKObjectRequestOperation *operation, NSError *error) {
         RKLogError(@"Load failed with error: %@", error);
     }];
*/
}

- (void)fetchArticlesFromContext:(NSString *)username{
        NSManagedObjectContext *context = [RKManagedObjectStore defaultStore].mainQueueManagedObjectContext;
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"UserList"];
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"userName" ascending:YES];
    fetchRequest.sortDescriptors = @[descriptor];
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    TrollToken *trolll = [fetchedObjects firstObject];
    
    NSLog(@"%@ Entrooo",trolll.userName);
    NSLog(@"%@ Entrooo",username);
    if ([trolll.userName isEqualToString:username]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"loginActionFinished" object:self userInfo:nil];
        auth=true;
    }else{
        auth=false;
    }
    //self.articles = [articleList.articles allObjects];
    
    //[self.tableView reloadData];
    
    
}

/*
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
                                              method:RKRequestMethodPOST];
    [manager addResponseDescriptor:responseDescriptor];
    [manager addRequestDescriptor:requestDescriptor];
    
    NSDictionary *params = @{
                             @"username":   trolltoken.userName,
                             @"password":  trolltoken.password,
                             @"token_type": trolltoken.token_type
                             };
    auth =true;
    [manager postObject:trolltoken path:@"/token" parameters:params
                success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                    NSLog(@"SUCCESS: %@", mappingResult.array);
                } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                    NSLog(@"FAILED: %@", error);
                }];
}
 */
- (void)logout{

}

- (BOOL)userAuthenticated {
    if (auth) {
        return YES;
    }
    return NO;
}

@end
