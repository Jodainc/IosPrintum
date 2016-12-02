//
//  TrollToken+CoreDataProperties.h
//  Printum
//
//  Created by JoyDa on 12/2/16.
//  Copyright © 2016 JoyDa. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "TrollToken+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface TrollToken (CoreDataProperties)

+ (NSFetchRequest<TrollToken *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *expires;
@property (nullable, nonatomic, copy) NSString *expires_in;
@property (nullable, nonatomic, copy) NSString *issued;
@property (nullable, nonatomic, copy) NSString *token_type;
@property (nullable, nonatomic, copy) NSString *trollTokens;
@property (nullable, nonatomic, copy) NSString *userName;

@end

NS_ASSUME_NONNULL_END
