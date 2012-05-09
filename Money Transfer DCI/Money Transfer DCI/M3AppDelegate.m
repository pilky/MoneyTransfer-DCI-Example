//
//  M3AppDelegate.m
//  Money Transfer
//
//  Created by Martin Pilkington on 07/05/2012.
//  Copyright (c) 2012 M Cubed Software. All rights reserved.
//

#import "M3AppDelegate.h"

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

	[self.bank openAccountWithID:@"1" type:M3AccountTypeBasic];
	[self.bank openAccountWithID:@"2" type:M3AccountTypeSavings];
	[self.bank openAccountWithID:@"3" type:M3AccountTypeBasic];
	[self.bank openAccountWithID:@"4" type:M3AccountTypeOverdraft];


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
	[self.bank openAccountWithID:aAccountID type:aType];
	[self.mainWindowController setAccounts:self.bank.accounts];
}

- (void)controller:(M3MainWindowController *)aController closeAccount:(M3Account *)aAccount {
	NSError *error = nil;
	if ([self.bank closeAccount:aAccount error:&error]) {
		[self.mainWindowController setAccounts:self.bank.accounts];
	} else {
		[self.mainWindowController presentError:error];
	}
}

- (void)controller:(M3MainWindowController *)aController depositAmount:(NSUInteger)aAmount intoAccount:(M3Account *)aAccount {
	[aAccount deposit:aAmount];
}

- (void)controller:(M3MainWindowController *)aController withdrawAmount:(NSUInteger)aAmount fromAccount:(M3Account *)aAccount {
	NSError *error = nil;
	if (![aAccount withdraw:aAmount error:&error]) {
		[self.mainWindowController presentError:error];
	}
}

- (void)controller:(M3MainWindowController *)aController transferAmount:(NSUInteger)aAmount fromAccount:(M3Account *)aFromAccount toAccount:(M3Account *)aToAccount {
	NSError *error = nil;
	if (![aFromAccount transfer:aAmount toAccount:aToAccount error:&error]) {
		[self.mainWindowController presentError:error];
	}
}

@end
