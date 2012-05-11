//
//  DCICloseAccountContext.m
//  Money Transfer DCI
//
//  Created by Martin Pilkington on 09/05/2012.
//  Copyright (c) 2012 M Cubed Software. All rights reserved.
//

#import "M3CloseAccountContext.h"
#import "M3ErrorFactory.h"

@protocol M3AccountCloserRole <NSObject>

- (BOOL)closeAccountWithError:(NSError **)aError;

@end

@implementation M3CloseAccountContext {
	M3Bank<M3AccountCloserRole> *bank;
	M3Account *closingAccount;
}

- (id)initWithBank:(M3Bank *)aBank closingAccount:(M3Account *)aAccount {
	if((self = [super init])) {
		bank = [self playerFromObject:aBank forRole:self.accountCloserRole];
		closingAccount = aAccount;
	}
	return self;
}

- (DCIRole *)accountCloserRole {
	DCIRole *role = [DCIRole roleWithProtocol:@protocol(M3AccountCloserRole)];

	role[@"closeAccountWithError:"] = ^(M3Bank *player, NSError **aError) {
		if (closingAccount.balance == 0) {
			[player removeAccount:closingAccount];
			return YES;
		}

		*aError = [M3ErrorFactory accountToCloseHasNonEmptyBalanceError];
		return NO;
	};

	return role;
}

- (BOOL)closeAccountWithError:(NSError **)aError {
	__block BOOL success = NO;
	[self execute:^{
		success = [bank closeAccountWithError:&*aError];
	}];
	return success;
}

@end
