//
//  DCITransferMoneyContext.m
//  Money Transfer DCI
//
//  Created by Martin Pilkington on 09/05/2012.
//  Copyright (c) 2012 M Cubed Software. All rights reserved.
//

#import "M3TransferMoneyContext.h"
#import "M3ErrorFactory.h"

/***************************
 We define a protocol for any methodful roles, in this case the transfer source acount. We only have one methods for this role
 **************************/
@protocol M3TransferSourceAccount <NSObject>

- (void)transferAmount:(NSUInteger)aAmount;

@end

@implementation M3TransferMoneyContext {
	M3Account<M3TransferSourceAccount> *sourceAccount;
	M3Account *destinationAccount;
	NSUInteger amount;
}

/***************************
 In this version we pass everything we need into the initialiser, roles and values.
 **************************/
- (id)initWithSourceAccount:(M3Account *)aSourceAccount destinationAccount:(M3Account *)aDestinationAccount amount:(NSUInteger)aAmount {
	if ((self = [super init])) {
		//Our methodful role player is passed through -[DCIContext playerFromObject:forRole:].
		//This informs the context that it needs to have the role methods injected into it at runtime
		sourceAccount = [self playerFromObject:aSourceAccount forRole:self.sourceAccountRole];

		//This is a methodless role, so we just assign it as needed
		destinationAccount = aDestinationAccount;
		
		amount = aAmount;
	}
	return self;
}

/***************************
 We encapsulate the definition of a role in  a method. This could be done in a class, but this is more lightweight and fully enforces the idea
 that role methods should be stateless
 **************************/
- (DCIRole *)sourceAccountRole {
	DCIRole *role = [DCIRole roleWithProtocol:@protocol(M3TransferSourceAccount)];

	role[@"transferAmount:error:"] = ^(M3Account *player, NSUInteger aAmount, NSError **aError) {
		if (!destinationAccount) {
			[self returnError:[M3ErrorFactory noTransferDestinationAccountSelectedError]];
			return;
		}
		
		if (player.availableBalance < aAmount) {
			[self returnError:[M3ErrorFactory insufficientFundsErrorWithAvailableBalance:player.availableBalance]];
			return;
		}
		
		player.balance -= aAmount;
		destinationAccount.balance += aAmount;
	};

	return role;
}

/***************************
 The context calls main when execution happens. Other contexts in this version pass the error back from the role method by reference,
 but in this context a different way of calling returnError: in the roles themselves is used.
 **************************/
- (void)main {
	[sourceAccount transferAmount:amount];
}

@end
