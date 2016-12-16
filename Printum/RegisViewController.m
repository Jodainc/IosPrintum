//
//  RegisViewController.m
//  Printum
//
//  Created by JoyDa on 12/15/16.
//  Copyright © 2016 JoyDa. All rights reserved.
//
#import "RestKit/RestKit.h"
#import "RestKit/CoreData.h"
#import "RegisViewController.h"
#import "Users.h"
#import "ResponseUsers.h"

@interface RegisViewController ()

@end

@implementation RegisViewController

@synthesize nit,nombes,cedul,apelli,direcc,telel,emails,back;
- (void)viewDidLoad {
    [super viewDidLoad];
   
    
}
- (IBAction)back:(id)sender {
    UIViewController* rootController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"initialView"];
    UINavigationController* navigation = [[UINavigationController alloc] initWithRootViewController:rootController];
    
}
- (IBAction)regis:(id)sender {
   
  Users *users1 =[Users new];
    users1.UserName = emails.text;
    users1.LastName = apelli.text;
    users1.nit_Number = [nit.text integerValue];
    users1.FirtsName = nombes.text;
    users1.cedula = [cedul.text integerValue];
    users1.UserAddress= direcc.text;
    users1.UserPhone = telel.text;
    users1.User_Photo= @"(~/Content/StatePho/1.jpg";
    RKObjectManager *obje =  [RKObjectManager sharedManager];
    obje.requestSerializationMIMEType = RKMIMETypeJSON;
    [obje postObject: users1
                path:@"Api/Users"
          parameters: nil
             success: ^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                  ResponseUsers *result = [mappingResult firstObject];
                 NSLog(@"@%",@"Entroooo");
                 UIViewController* rootController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"Confir"];
                 UINavigationController* navigation = [[UINavigationController alloc] initWithRootViewController:rootController];
             }
             failure: ^(RKObjectRequestOperation *operation, NSError *error) {
                 RKLogError(@"Load failed with error: %@", error);
             }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
