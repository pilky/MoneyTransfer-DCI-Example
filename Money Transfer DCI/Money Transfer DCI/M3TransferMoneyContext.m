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

- (BOOL)transferAmount:(NSUInteger)aAmount error:(NSError *__autoreleasing *)aError;

@end


@implementation M3TransferMoneyContext {
	M3Account<M3TransferSourceAccount> *sourceAccount;
	M3Account *destinationAccount;
}

/***************************
 We pass in the objects we want to play roles. In this version this is all we pass in at initialisation
 **************************/
- (id)initWithSourceAccount:(M3Account *)aSourceAccount destinationAccount:(M3Account *)aDestinationAccount {
	if ((self = [super init])) {
		//Our methodful role player is passed through -[DCIContext playerFromObject:forRole:].
		//This informs the context that it needs to have the role methods injected into it at runtime
		sourceAccount = [self playerFromObject:aSourceAccount forRole:self.sourceAccountRole];

		//This is a methodless role, so we just assign it as needed
		destinationAccount = aDestinationAccount;
	}
	return self;
}

/***************************
 We encapsulate the definition of a role in  a method. This could be done in a class, but this is more lightweight and fully enforces the idea
 that role methods should be stateless
 **************************/
- (DCIRole *)sourceAccountRole {
	//We create a role with the defined protocol. We need this to get type information for the runtime
	DCIRole *role = [DCIRole roleWithProtocol:@protocol(M3TransferSourceAccount)];

	//Here we create a role method. We are using the new subscripting format in Obj-C. This is equvalent to -[DCIRole addMethod:withSelector:].
	//We assign a block to contain the method body. The first argument is the object representing the player (if this method was in the
	//player's class it would be self). Any arguments for the method are added after this. Inside the block isn't that interesting, it's just a
	//standard method implementation.
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

/***************************
 This is what other objects call to start the context running. We pass in any non-role properties here in this version.
 **************************/
- (BOOL)transferAmount:(NSUInteger)aAmount error:(NSError **)aError {
	__block BOOL success = NO;
	//We run execute, which will set up the environment and then call the supplied block to kick off the context
	[self execute:^{
		success = [sourceAccount transferAmount:aAmount error:&*aError];
	}];
	return success;
}

@end
