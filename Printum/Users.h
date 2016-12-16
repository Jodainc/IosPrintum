//
//  Users.h
//  Printum
//
//  Created by JoyDa on 12/15/16.
//  Copyright © 2016 JoyDa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Users : NSObject
@property (nonatomic,readwrite) int UserId;
 @property (nonatomic,readwrite)   NSString *UserName;
  @property (nonatomic,readwrite)      NSString *FirtsName;
     @property (nonatomic,readwrite)   NSString *LastName;
        @property (nonatomic,readwrite)NSString *UserPhone;
       @property (nonatomic,readwrite) NSString *UserAddress;
     @property (nonatomic,readwrite) int nit_Number;
    @property (nonatomic,readwrite)  int cedula;
  @property (nonatomic,readwrite)  NSString *User_Photo;
    @property (nonatomic,readwrite)  int DeparmentId;
    @property (nonatomic,readwrite)  int CityId;
    @property (nonatomic,readwrite)  int CompanyId;
    



@end
