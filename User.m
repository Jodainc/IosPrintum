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
            [self fetchArticlesFromContext :username];
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
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"TrollToken"];
    
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"userName" ascending:YES];
    fetchRequest.sortDescriptors = @[descriptor];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    TrollToken *trolll = [fetchedObjects firstObject];
    
    NSManagedObject *transaction = [NSEntityDescription insertNewObjectForEntityForName:@"TrollToken" inManagedObjectContext:context];
    [transaction setValue:trolll.userName forKey:@"userName"];
    [transaction setValue:trolll.trollTokens forKey:@"trollTokens"];
    [transaction setValue:trolll.token_type forKey:@"token_type"];
    
    // Save the context
    if (![context save:&error]) {
        NSLog(@"Save Failed! %@ %@", error, [error localizedDescription]);
    }
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
- (void)logout{

}

- (BOOL)userAuthenticated {
    
    NSManagedObjectContext *context = [RKManagedObjectStore defaultStore].mainQueueManagedObjectContext;
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"TrollToken"];
    
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"userName" ascending:YES];
    fetchRequest.sortDescriptors = @[descriptor];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    TrollToken *trolll = [fetchedObjects firstObject];
    NSUInteger count = [context countForFetchRequest:fetchRequest error:&error];
     NSLog(@"%lu  numero aut",(unsigned long)count);
    if (count>1) {
        return YES;
    }
    return NO;
}

@end
