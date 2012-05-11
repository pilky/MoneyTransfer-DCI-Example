//
//  DCIDepositMoneyContext.m
//  Money Transfer DCI
//
//  Created by Martin Pilkington on 09/05/2012.
//  Copyright (c) 2012 M Cubed Software. All rights reserved.
//

#import "M3DepositMoneyContext.h"

@protocol M3DepositingAccountRole <NSObject>

- (void)depositAmount:(NSUInteger)aAmount;

@end

@implementation M3DepositMoneyContext {
	M3Account<M3DepositingAccountRole> *destinationAccount;
	NSUInteger amount;
}

- (id)initWithDestinationAccount:(M3Account *)aAccount amount:(NSUInteger)aAmount {
	if ((self = [super init])) {
		destinationAccount = [self playerFromObject:aAccount forRole:self.destinationAccountRole];
		amount = aAmount;
	}
	return self;
}

- (DCIRole *)destinationAccountRole {
	DCIRole *role = [DCIRole roleWithProtocol:@protocol(M3DepositingAccountRole)];

	role[@"depositAmount:"] = ^(M3Account *player, NSUInteger aAmount) {
		player.balance += aAmount;
	};

	return role;
}

- (void)main {
	[destinationAccount depositAmount:amount];
}

@end
