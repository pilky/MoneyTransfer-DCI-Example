//
//  M3Account.m
//  Money Transfer
//
//  Created by Martin Pilkington on 07/05/2012.
//  Copyright (c) 2012 M Cubed Software. All rights reserved.
//

#import "M3Account.h"
#import "M3ErrorFactory.h"

@implementation M3Account

- (id)initWithAccountID:(NSString *)aID {
	if ((self = [super init])) {
		_accountID = [aID copy];
		_balance = 500;
	}
	return self;
}

- (NSUInteger)availableBalance {
	return self.balance;
}

- (void)deposit:(NSUInteger)aAmount {
	_balance += aAmount;
}

- (BOOL)withdraw:(NSUInteger)aAmount error:(NSError *__autoreleasing *)aError {
	if (aAmount <= self.availableBalance) {
		_balance -= aAmount;
		return YES;
	}

	*aError = [M3ErrorFactory insufficientFundsErrorWithAvailableBalance:self.availableBalance];
	return NO;
}

- (BOOL)transfer:(NSUInteger)aAmount toAccount:(M3Account *)aDestinationAccount error:(NSError *__autoreleasing *)aError {
	if (!aDestinationAccount) {
		*aError = [M3ErrorFactory noTransferDestinationAccountSelectedError];
		return NO;
	}

	if (self.availableBalance >= aAmount) {
		_balance -= aAmount;
		[aDestinationAccount deposit:aAmount];
		return YES;
	}

	*aError = [M3ErrorFactory insufficientFundsErrorWithAvailableBalance:self.availableBalance];
	return NO;
}

- (NSString *)description {
	NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
	[currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
	return [NSString stringWithFormat:@"Basic %@ (%@)", self.accountID, [currencyFormatter stringForObjectValue:[NSNumber numberWithInteger:self.balance]]];
}

@end
