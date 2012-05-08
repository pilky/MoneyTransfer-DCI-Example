//
//  M3Bank.h
//  Money Transfer
//
//  Created by Martin Pilkington on 07/05/2012.
//  Copyright (c) 2012 M Cubed Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "M3Account.h"

typedef enum {
	M3AccountTypeBasic = 0,
	M3AccountTypeOverdraft = 1,
	M3AccountTypeSavings = 2
} M3AccountType;

@interface M3Bank : NSObject

@property (readonly) NSArray *accounts;

- (void)openAccountWithID:(NSString *)aAccountID type:(M3AccountType)aType;
- (BOOL)closeAccount:(M3Account *)aAccount error:(NSError **)aError;

@end
