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
        
        NSManagedObject *object = [NSEntityDescription insertNewObjectForEntityForName:@"UserList"
                                                                inManagedObjectContext:context];
        [object setValue:trolll.userName forKey:@"userName"];
        [object setValue:trolll.trollTokens forKey:@"trollTokens"];
        [object setValue:trolll.token_type forKey:@"token_type"];
        NSError *error;
        if (![context save:&error]) {
            NSLog(@"Failed to save - error: %@", [error localizedDescription]);
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"loginActionFinished" object:self userInfo:nil];
        auth=true;
    }else{
        auth=false;
    }
    
    
}

- (void)logout{

}

- (BOOL)userAuthenticated {
    NSError *error;
    NSManagedObjectContext *context1 = [RKManagedObjectStore defaultStore].mainQueueManagedObjectContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"UserList"];
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"userName" ascending:YES];
    fetchRequest.sortDescriptors = @[descriptor];
    NSInteger count = [context1 countForFetchRequest:fetchRequest error:&error];
    NSLog(@"%lu  numero autesyyy... ",(unsigned long)count);
    if (count>0) {
        return YES;
    }
    return NO;
}

@end
