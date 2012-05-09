//
//  DCIWithdrawMoneyContext.m
//  Money Transfer DCI
//
//  Created by Martin Pilkington on 09/05/2012.
//  Copyright (c) 2012 M Cubed Software. All rights reserved.
//

#import "M3WithdrawMoneyContext.h"
#import "M3OverdraftAccount.h"

//1. Select account
//2. Select amount
//3. Withdraw
	//3.1 Check if account supports withdrawls
	//3.2 Check if we have enough in account
	//Withdraw

@protocol M3WithdrawlSource <NSObject>

- (BOOL)withdrawAmount:(NSUInteger)aAmount error:(NSError **)aError;

@end



@implementation M3WithdrawMoneyContext {
	M3Account<M3WithdrawlSource> *sourceAccount;
}

- (id)initWithSourceAccount:(M3Account *)aSourceAccount {
	if ((self = [super init])) {
		sourceAccount = [self playerFromObject:aSourceAccount forRole:self.sourceAccountRole];
	}
	return self;
}

- (DCIRole *)sourceAccountRole {
	DCIRole *role = [DCIRole roleWithProtocol:@protocol(M3WithdrawlSource)];

	role[@"withdrawAmount:error:"] = ^(M3Account *player, NSUInteger aAmount, NSError **aError) {
		NSArray *allowedAccountTypes = @[ [M3Account class], [M3OverdraftAccount class] ];
		if (![allowedAccountTypes containsObject:player.class]) {
			*aError = [NSError errorWithDomain:@"com.mcubedsw.moneytransfer" code:3 userInfo:@{
				NSLocalizedDescriptionKey : @"You cannot directly withdraw from this account",
				NSLocalizedRecoverySuggestionErrorKey : @"Please transfer to another account before withdrawing"
			}];
			return NO;
		}

		if (aAmount > player.availableBalance) {
			NSNumberFormatter *formatter = [NSNumberFormatter new];
			[formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
		
			*aError = [NSError errorWithDomain:@"com.mcubedsw.moneytransfer" code:2 userInfo:@{
				NSLocalizedDescriptionKey : @"Insufficient funds to withdraw",
				NSLocalizedRecoverySuggestionErrorKey : [NSString stringWithFormat:@"You can only withdraw up to %@ from this account", [formatter stringForObjectValue:[NSNumber numberWithInteger:player.availableBalance]]]
			}];
			return NO;
		}
		
		player.balance -= aAmount;
		return YES;
	};

	return role;
}

- (BOOL)withdrawAmount:(NSUInteger)aAmount error:(NSError **)aError {
	__block BOOL success = NO;
	[self execute:^{
		success = [sourceAccount withdrawAmount:aAmount error:&*aError];
	}];
	return success;
}

@end
