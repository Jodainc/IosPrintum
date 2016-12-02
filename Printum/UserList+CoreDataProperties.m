//
//  UserList+CoreDataProperties.m
//  Printum
//
//  Created by JoyDa on 12/2/16.
//  Copyright © 2016 JoyDa. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "UserList+CoreDataProperties.h"

@implementation UserList (CoreDataProperties)

+ (NSFetchRequest<UserList *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"UserList"];
}

@dynamic cities;
@dynamic cityId;
@dynamic companies;
@dynamic companyId;
@dynamic deparmentModels;
@dynamic departmentId;
@dynamic firtsName;
@dynamic lastName;
@dynamic userAddress;
@dynamic userId;
@dynamic userName;
@dynamic userPhone;
@dynamic userPhoto;
@dynamic token_type;
@dynamic trollTokens;
@dynamic trollToken;

@end
