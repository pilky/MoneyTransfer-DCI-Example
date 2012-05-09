//
//  M3AppDelegate.m
//  Money Transfer
//
//  Created by Martin Pilkington on 07/05/2012.
//  Copyright (c) 2012 M Cubed Software. All rights reserved.
//

#import "M3AppDelegate.h"
#import "M3SavingsAccount.h"
#import "M3OverdraftAccount.h"
#import "M3WithdrawMoneyContext.h"
#import "M3DepositMoneyContext.h"
#import "M3CloseAccountContext.h"
#import "M3TransferMoneyContext.h"
#import "M3OpenAccountContext.h"

@implementation M3AppDelegate

@synthesize mainWindowController = _mainWindowController, bank = _bank;

- (M3MainWindowController *)mainWindowController {
	if (!_mainWindowController) {
		_mainWindowController = [M3MainWindowController new];
		[_mainWindowController setDelegate:self];
	}
	return _mainWindowController;
}

- (M3Bank *)bank {
	if (!_bank) {
		_bank = [M3Bank new];
	}
	return _bank;
}


#pragma mark -
#pragma mark App delegate stuff

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	[self.bank addAccount:[[M3Account alloc] initWithAccountID:@"1"]];
	[self.bank addAccount:[[M3SavingsAccount alloc] initWithAccountID:@"2"]];
	[self.bank addAccount:[[M3Account alloc] initWithAccountID:@"3"]];
	[self.bank addAccount:[[M3OverdraftAccount alloc] initWithAccountID:@"4"]];

	[self.mainWindowController setAccounts:self.bank.accounts];
	[self.mainWindowController showWindow:self];
}

- (BOOL)applicationShouldHandleReopen:(NSApplication *)sender hasVisibleWindows:(BOOL)flag {
	[self.mainWindowController showWindow:self];
	return NO;
}


#pragma mark -
#pragma mark Main Window Delegate Stuff

- (void)controller:(M3MainWindowController *)aController openAccountWithID:(NSString *)aAccountID type:(M3AccountType)aType {
	M3OpenAccountContext *context = [[M3OpenAccountContext alloc] initWithBank:self.bank];
	[context openAccountWithID:aAccountID type:aType];
	[self.mainWindowController setAccounts:self.bank.accounts];
}

- (void)controller:(M3MainWindowController *)aController closeAccount:(M3Account *)aAccount {
	NSError *error = nil;
	M3CloseAccountContext *context = [[M3CloseAccountContext alloc] initWithBank:self.bank closingAccount:aAccount];
	if ([context closeAccountWithError:&error]) {
		[self.mainWindowController setAccounts:self.bank.accounts];
	} else {
		[self.mainWindowController presentError:error];
	}
}

- (void)controller:(M3MainWindowController *)aController depositAmount:(NSUInteger)aAmount intoAccount:(M3Account *)aAccount {
	M3DepositMoneyContext *context = [[M3DepositMoneyContext alloc] initWithDestinationAccount:aAccount];
	[context depositAmount:aAmount];
}

- (void)controller:(M3MainWindowController *)aController withdrawAmount:(NSUInteger)aAmount fromAccount:(M3Account *)aAccount {
	NSError *error = nil;
	M3WithdrawMoneyContext *context = [[M3WithdrawMoneyContext alloc] initWithSourceAccount:aAccount];
	if (![context withdrawAmount:aAmount error:&error]) {
		[self.mainWindowController presentError:error];
	}
}

- (void)controller:(M3MainWindowController *)aController transferAmount:(NSUInteger)aAmount fromAccount:(M3Account *)aFromAccount toAccount:(M3Account *)aToAccount {
	NSError *error = nil;
	M3TransferMoneyContext *context = [[M3TransferMoneyContext alloc] initWithSourceAccount:aFromAccount destinationAccount:aToAccount];
	if (![context transferAmount:aAmount error:&error]) { //transfer with error
		[self.mainWindowController presentError:error];
	}
}

@end
