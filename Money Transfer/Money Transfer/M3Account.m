//
//  M3Account.m
//  Money Transfer
//
//  Created by Martin Pilkington on 07/05/2012.
//  Copyright (c) 2012 M Cubed Software. All rights reserved.
//

#import "M3Account.h"

@implementation M3Account

- (id)initWithAccountID:(NSString *)aID {
	if ((self = [super init])) {
		_accountID = [aID copy];
	}
	return self;
}

- (BOOL)deposit:(NSUInteger)aAmount error:(NSError *__autoreleasing *)aError {
	return NO;
}

- (BOOL)withdraw:(NSUInteger)aAmount error:(NSError *__autoreleasing *)aError {
	return NO;
}

- (BOOL)transfer:(NSUInteger)aAmount toAccount:(M3Account *)aDestinationAccount error:(NSError *__autoreleasing *)aError {
	return NO;
}

@end
