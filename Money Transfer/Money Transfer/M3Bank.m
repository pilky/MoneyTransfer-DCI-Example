//
//  M3Bank.m
//  Money Transfer
//
//  Created by Martin Pilkington on 07/05/2012.
//  Copyright (c) 2012 M Cubed Software. All rights reserved.
//

#import "M3Bank.h"

@implementation M3Bank {
	NSMutableArray *accounts;
}

- (id)init {
	if ((self = [super init])) {
		accounts = [NSMutableArray array];
	}
	return self;
}

- (NSArray *)accounts {
	return [accounts copy];
}

- (M3Account *)openAccountWithID:(NSString *)aAccountID {
	M3Account *account = [[M3Account alloc] initWithAccountID:aAccountID];
	[accounts addObject:account];
	return account;
}

- (BOOL)closeAccount:(M3Account *)aAccount error:(NSError *__autoreleasing *)aError {
	return NO;
}

@end
