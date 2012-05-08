//
//  M3OverdraftAccount.m
//  Money Transfer
//
//  Created by Martin Pilkington on 08/05/2012.
//  Copyright (c) 2012 M Cubed Software. All rights reserved.
//

#import "M3OverdraftAccount.h"

@implementation M3OverdraftAccount

- (NSUInteger)availableBalance {
	return self.balance + 300;
}

- (NSString *)description {
	NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
	[currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
	return [NSString stringWithFormat:@"Overdraft %@ (%@)", self.accountID, [currencyFormatter stringForObjectValue:[NSNumber numberWithInteger:self.balance]]];
}

@end
