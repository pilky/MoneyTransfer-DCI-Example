//
//  M3Bank.m
//  Money Transfer
//
//  Created by Martin Pilkington on 07/05/2012.
//  Copyright (c) 2012 M Cubed Software. All rights reserved.
//

#import "M3Bank.h"
#import "M3SavingsAccount.h"
#import "M3OverdraftAccount.h"

@implementation M3Bank {
	NSMutableArray *accounts;
}

- (id)init {
	if ((self = [super init])) {
		accounts = [NSMutableArray array];
	}
	return self;
}

- (NSArray *)accounts {
	return [accounts copy];
}

- (void)addAccount:(M3Account *)aAccount {
	[accounts addObject:aAccount];
}

- (void)removeAccount:(M3Account *)aAccount {
	[accounts removeObject:aAccount];
}

@end
