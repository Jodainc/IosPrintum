//
//  UserList+CoreDataProperties.h
//  Printum
//
//  Created by JoyDa on 12/2/16.
//  Copyright © 2016 JoyDa. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "UserList+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface UserList (CoreDataProperties)

+ (NSFetchRequest<UserList *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *cities;
@property (nonatomic) int64_t cityId;
@property (nullable, nonatomic, copy) NSString *companies;
@property (nonatomic) int64_t companyId;
@property (nullable, nonatomic, copy) NSString *deparmentModels;
@property (nonatomic) int64_t departmentId;
@property (nullable, nonatomic, copy) NSString *firtsName;
@property (nullable, nonatomic, copy) NSString *lastName;
@property (nullable, nonatomic, copy) NSString *userAddress;
@property (nonatomic) int64_t userId;
@property (nullable, nonatomic, copy) NSString *userName;
@property (nullable, nonatomic, copy) NSString *userPhone;
@property (nullable, nonatomic, copy) NSString *userPhoto;
@property (nullable, nonatomic, copy) NSString *token_type;
@property (nullable, nonatomic, copy) NSString *trollTokens;
@property (nullable, nonatomic, retain) NSSet<TrollToken *> *trollToken;

@end

@interface UserList (CoreDataGeneratedAccessors)

- (void)addTrollTokenObject:(TrollToken *)value;
- (void)removeTrollTokenObject:(TrollToken *)value;
- (void)addTrollToken:(NSSet<TrollToken *> *)values;
- (void)removeTrollToken:(NSSet<TrollToken *> *)values;

@end

NS_ASSUME_NONNULL_END
