//
//  M3ErrorFactory.m
//  Money Transfer
//
//  Created by Martin Pilkington on 11/05/2012.
//  Copyright (c) 2012 M Cubed Software. All rights reserved.
//

#import "M3ErrorFactory.h"

@implementation M3ErrorFactory

+ (NSError *)accountToCloseHasNonEmptyBalanceError {
	return [NSError errorWithDomain:@"com.mcubedsw.moneytransfer" code:1 userInfo:@{
		NSLocalizedDescriptionKey : @"Could not close account",
		NSLocalizedRecoverySuggestionErrorKey : @"Please empty the account's balance before closing it."
	}];
}

+ (NSError *)insufficientFundsErrorWithAvailableBalance:(NSUInteger)aAvailableBalance {
	NSNumberFormatter *formatter = [NSNumberFormatter new];
	[formatter setNumberStyle:NSNumberFormatterCurrencyStyle];

	NSString *available = [formatter stringForObjectValue:[NSNumber numberWithInteger:aAvailableBalance]];
	NSString *recoverySuggestion = [NSString stringWithFormat:@"You can only withdraw up to %@ from this account", available];

	return [NSError errorWithDomain:@"com.mcubedsw.moneytransfer" code:2 userInfo:@{
		NSLocalizedDescriptionKey : @"Insufficient funds to withdraw",
		NSLocalizedRecoverySuggestionErrorKey : recoverySuggestion
	}];
}

+ (NSError *)accountDoesntSupportWithdrawlsError {
	return [NSError errorWithDomain:@"com.mcubedsw.moneytransfer" code:3 userInfo:@{
		NSLocalizedDescriptionKey : @"You cannot directly withdraw from this account",
		NSLocalizedRecoverySuggestionErrorKey : @"Please transfer to another account before withdrawing"
	}];
}

+ (NSError *)noTransferDestinationAccountSelectedError {
	return [NSError errorWithDomain:@"com.mcubedsw.moneytransfer" code:4 userInfo:@{
		NSLocalizedDescriptionKey : @"No account selected",
		NSLocalizedRecoverySuggestionErrorKey : @"Please select an account to transfer to."
	}];
}

@end
