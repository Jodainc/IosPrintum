//
//  Users.m
//  Printum
//
//  Created by JoyDa on 12/15/16.
//  Copyright © 2016 JoyDa. All rights reserved.
//

#import "Users.h"

@implementation Users
@synthesize UserId,UserName,User_Photo,UserAddress,UserPhone,cedula,nit_Number,DeparmentId,CityId,CompanyId,FirtsName,LastName;
-(id)init{
    self = [super init];
    UserId =0;
    UserName =@"Null";
    FirtsName  =@"Null";
    LastName =@"Null";
    UserPhone=@"Null";
    UserAddress =@"Null";
    User_Photo=@"Null";
    nit_Number=0;
    cedula=0;
    DeparmentId=1;
    CityId=1;
    CompanyId=1;
    return self;
}
@end
