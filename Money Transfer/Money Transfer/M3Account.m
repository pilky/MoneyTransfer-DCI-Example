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
		_balance = 10;
	}
	return self;
}

- (void)deposit:(NSUInteger)aAmount {
	_balance += aAmount;
}

- (BOOL)withdraw:(NSUInteger)aAmount error:(NSError *__autoreleasing *)aError {
	if (aAmount <= self.balance) {
		_balance -= aAmount;
		return YES;
	}

	NSNumberFormatter *formatter = [NSNumberFormatter new];
	[formatter setNumberStyle:NSNumberFormatterCurrencyStyle];

	*aError = [NSError errorWithDomain:@"com.mcubedsw.moneytransfer" code:2 userInfo:@{
		NSLocalizedDescriptionKey : @"Insufficient funds to withdraw",
		NSLocalizedRecoverySuggestionErrorKey : [NSString stringWithFormat:@"You can only withdraw up to %@ from this account", [formatter stringForObjectValue:[NSNumber numberWithInteger:self.balance]]]
	}];
	return NO;
}

- (BOOL)transfer:(NSUInteger)aAmount toAccount:(M3Account *)aDestinationAccount error:(NSError *__autoreleasing *)aError {
	return NO;
}

@end
