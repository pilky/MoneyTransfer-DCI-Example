//
//  DCIOpenAccountContext.h
//  Money Transfer DCI
//
//  Created by Martin Pilkington on 09/05/2012.
//  Copyright (c) 2012 M Cubed Software. All rights reserved.
//

#import "DCIContext.h"
#import "M3Bank.h"

typedef enum {
	M3AccountTypeBasic = 0,
	M3AccountTypeOverdraft = 1,
	M3AccountTypeSavings = 2
} M3AccountType;

@interface M3OpenAccountContext : DCIContext

- (id)initWithBank:(M3Bank *)aBank;

- (void)openAccountWithID:(NSString *)aID type:(M3AccountType)aType;

@end
