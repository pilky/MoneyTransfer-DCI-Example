//
//  DCIOpenAccountContext.m
//  Money Transfer DCI
//
//  Created by Martin Pilkington on 09/05/2012.
//  Copyright (c) 2012 M Cubed Software. All rights reserved.
//

#import "M3OpenAccountContext.h"
#import "M3Account.h"
#import "M3OverdraftAccount.h"
#import "M3SavingsAccount.h"

@protocol M3AccountOpenerRole <NSObject>

- (void)openAccountWithID:(NSString *)aID type:(M3AccountType)aType;

@end


@implementation M3OpenAccountContext {
	M3Bank<M3AccountOpenerRole> *bank;
	NSString *accountID;
	M3AccountType type;
}

- (id)initWithBank:(M3Bank *)aBank accountID:(NSString *)aID type:(M3AccountType)aType {
	if ((self = [super init])) {
		bank = [self playerFromObject:aBank forRole:self.accountOpenerRole];
		accountID = aID;
		type = aType;
	}
	return self;
}

- (DCIRole *)accountOpenerRole {
	DCIRole *role = [DCIRole roleWithProtocol:@protocol(M3AccountOpenerRole)];

	role[@"openAccountWithID:type:"] = ^(M3Bank *player, NSString *aAccountID, M3AccountType aType) {
		NSArray *classes = @[ [M3Account class], [M3OverdraftAccount class], [M3SavingsAccount class] ];
		M3Account *account = [[classes[aType] alloc] initWithAccountID:aAccountID];
		[player addAccount:account];
	};

	return role;
}

- (void)main {
	[bank openAccountWithID:accountID type:type];
}

@end
