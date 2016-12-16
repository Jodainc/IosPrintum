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

@interface RegisViewController ()

@end

@implementation RegisViewController

@synthesize nit,nombes,cedul,apelli,direcc,telel,emails;
- (void)viewDidLoad {
    [super viewDidLoad];
   
    
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
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setValue:users1.UserName forKey:@"UserName"];
     [dictionary setValue:users1.FirtsName forKey:@"FirtsName"];
     [dictionary setValue:users1.LastName forKey:@"LastName"];
    [dictionary setObject:[NSNumber numberWithInt: users1.nit_Number]
                       forKey:@"nit_Number"];
    [dictionary setObject:[NSNumber numberWithInt: users1.cedula]
                   forKey:@"cedula"];
     [dictionary setValue:users1.UserAddress forKey:@"UserAddress"];
    [dictionary setValue:users1.UserPhone forKey:@"UserPhone"];
    [dictionary setValue:users1.User_Photo forKey:@"User_Photo"];

    RKObjectManager *obje =  [RKObjectManager sharedManager];
    [obje postObject: dictionary
                path:@"/Api/Users"
          parameters: nil
             success: ^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                 
                 NSLog(@"@%",@"Entroooo");
             }
             failure: ^(RKObjectRequestOperation *operation, NSError *error) {
                 RKLogError(@"Load failed with error: %@", error);
             }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
