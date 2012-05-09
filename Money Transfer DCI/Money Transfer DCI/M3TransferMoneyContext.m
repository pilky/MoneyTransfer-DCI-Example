//
//  DCITransferMoneyContext.m
//  Money Transfer DCI
//
//  Created by Martin Pilkington on 09/05/2012.
//  Copyright (c) 2012 M Cubed Software. All rights reserved.
//

#import "M3TransferMoneyContext.h"

@protocol M3TransferSourceAccount <NSObject>

- (BOOL)transferAmount:(NSUInteger)aAmount error:(NSError *__autoreleasing *)aError;

@end

@implementation M3TransferMoneyContext {
	M3Account<M3TransferSourceAccount> *sourceAccount;
	M3Account *destinationAccount;
}

- (id)initWithSourceAccount:(M3Account *)aSourceAccount destinationAccount:(M3Account *)aDestinationAccount {
	if ((self = [super init])) {
		sourceAccount = [self playerFromObject:aSourceAccount forRole:self.sourceAccountRole];
		destinationAccount = aDestinationAccount;
	}
	return self;
}

- (DCIRole *)sourceAccountRole {
	DCIRole *role = [DCIRole roleWithProtocol:@protocol(M3TransferSourceAccount)];

	role[@"transferAmount:error:"] = ^(M3Account *player, NSUInteger aAmount, NSError **aError) {
		if (!destinationAccount) {
			*aError = [NSError errorWithDomain:@"com.mcubedsw.moneytransfer" code:2 userInfo:@{
				NSLocalizedDescriptionKey : @"No account selected",
				NSLocalizedRecoverySuggestionErrorKey : @"Please select an account to transfer to."
			}];
			return NO;
		}
		
		if (player.availableBalance >= aAmount) {
			player.balance -= aAmount;
			destinationAccount.balance += aAmount;
			return YES;
		}

		NSNumberFormatter *formatter = [NSNumberFormatter new];
		[formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
		
		*aError = [NSError errorWithDomain:@"com.mcubedsw.moneytransfer" code:2 userInfo:@{
			NSLocalizedDescriptionKey : @"Insufficient funds to withdraw",
			NSLocalizedRecoverySuggestionErrorKey : [NSString stringWithFormat:@"You can only withdraw up to %@ from this account", [formatter stringForObjectValue:[NSNumber numberWithInteger:player.availableBalance]]]
		}];
		return NO;
	};

	return role;
}

- (BOOL)transferAmount:(NSUInteger)aAmount error:(NSError **)aError {
	__block BOOL success = NO;
	[self execute:^{
		success = [sourceAccount transferAmount:aAmount error:&*aError];
	}];
	return success;
}

@end
