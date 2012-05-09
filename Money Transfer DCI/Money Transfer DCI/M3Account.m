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
		_balance = 500;
	}
	return self;
}

- (NSUInteger)availableBalance {
	return self.balance;
}



- (NSString *)description {
	NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
	[currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
	return [NSString stringWithFormat:@"Basic %@ (%@)", self.accountID, [currencyFormatter stringForObjectValue:[NSNumber numberWithInteger:self.balance]]];
}

@end
