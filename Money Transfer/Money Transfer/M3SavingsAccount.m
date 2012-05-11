//
//  M3SavingsAccount.m
//  Money Transfer
//
//  Created by Martin Pilkington on 08/05/2012.
//  Copyright (c) 2012 M Cubed Software. All rights reserved.
//

#import "M3SavingsAccount.h"
#import "M3ErrorFactory.h"

@implementation M3SavingsAccount

- (BOOL)withdraw:(NSUInteger)aAmount error:(NSError *__autoreleasing *)aError {
	*aError = [M3ErrorFactory accountDoesntSupportWithdrawlsError];
	return NO;
}

- (NSString *)description {
	NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
	[currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
	return [NSString stringWithFormat:@"Savings %@ (%@)", self.accountID, [currencyFormatter stringForObjectValue:[NSNumber numberWithInteger:self.balance]]];
}

@end
