//
//  DCITransferMoneyContext.m
//  Money Transfer DCI
//
//  Created by Martin Pilkington on 09/05/2012.
//  Copyright (c) 2012 M Cubed Software. All rights reserved.
//

#import "M3TransferMoneyContext.h"
#import "M3ErrorFactory.h"

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
			*aError = [M3ErrorFactory noTransferDestinationAccountSelectedError];
			return NO;
		}
		
		if (player.availableBalance >= aAmount) {
			player.balance -= aAmount;
			destinationAccount.balance += aAmount;
			return YES;
		}
		
		*aError = [M3ErrorFactory insufficientFundsErrorWithAvailableBalance:player.availableBalance];
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
