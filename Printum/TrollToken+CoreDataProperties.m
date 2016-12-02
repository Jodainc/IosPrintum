//
//  TrollToken+CoreDataProperties.m
//  Printum
//
//  Created by JoyDa on 12/2/16.
//  Copyright © 2016 JoyDa. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "TrollToken+CoreDataProperties.h"

@implementation TrollToken (CoreDataProperties)

+ (NSFetchRequest<TrollToken *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"TrollToken"];
}

@dynamic expires;
@dynamic expires_in;
@dynamic issued;
@dynamic token_type;
@dynamic trollTokens;
@dynamic userName;

@end
