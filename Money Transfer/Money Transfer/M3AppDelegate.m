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
	[self.mainWindowController setAccounts:self.bank.accounts];
	[self.mainWindowController showWindow:self];
}

- (BOOL)applicationShouldHandleReopen:(NSApplication *)sender hasVisibleWindows:(BOOL)flag {
	[self.mainWindowController showWindow:self];
	return NO;
}


#pragma mark -
#pragma mark Main Window Delegate Stuff

- (void)controller:(M3MainWindowController *)aController openAccountWithID:(NSString *)aAccountID {
	[self.bank openAccountWithID:aAccountID];
	[self.mainWindowController setAccounts:self.bank.accounts];
}

- (void)controller:(M3MainWindowController *)aController closeAccount:(M3Account *)aAccount {
	[self.bank closeAccount:aAccount error:NULL];
}

@end
