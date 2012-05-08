//
//  M3MainWindowController.m
//  Money Transfer
//
//  Created by Martin Pilkington on 07/05/2012.
//  Copyright (c) 2012 M Cubed Software. All rights reserved.
//

#import "M3MainWindowController.h"

@interface M3MainWindowController ()

- (void)_updateSelection;

@end

@implementation M3MainWindowController
@synthesize accountTypePopup;

@synthesize transferDestinationPopup;
@synthesize transferAmountField;
@synthesize withdrawAmountField;
@synthesize accountBalanceField;
@synthesize depositAmountField;

- (id)init {
	if ((self = [super initWithWindowNibName:@"MainWindowController"])) {
		[self addObserver:self forKeyPath:@"accounts" options:0 context:NULL];
	}
	return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	[self.accountsTable reloadData];
	[self performSelector:@selector(_updateSelection) withObject:nil afterDelay:0];
}

- (void)presentError:(NSError *)aError {
	[NSApp presentError:aError modalForWindow:self.window delegate:nil didPresentSelector:NULL contextInfo:NULL];
}

- (M3Account *)selectedAccount {
	return self.accounts[self.accountsTable.selectedRow];
}


- (void)_updateSelection {
	[self.accountBalanceField setObjectValue:[NSNumber numberWithInteger:self.selectedAccount.balance]];
	[self.accountAvailableBalanceField setObjectValue:[NSNumber numberWithInteger:self.selectedAccount.availableBalance]];
	[self _updateTransferDestinations];
}


#pragma mark -
#pragma mark Accounts Table

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView {
	return self.accounts.count;
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex {
	return [self.accounts[rowIndex] description];
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification {
	[self _updateSelection];
}

- (IBAction)showOpenAccountSheet:(id)sender {
	[self.accountIDField setStringValue:@""];
	[NSApp beginSheet:self.openAccountSheet modalForWindow:self.window modalDelegate:nil didEndSelector:NULL contextInfo:NULL];
}

- (IBAction)closeAccount:(id)sender {
	[self.delegate controller:self closeAccount:self.selectedAccount];
	[self _updateSelection];
}



#pragma mark -
#pragma mark Open Account Sheet

- (IBAction)openAccount:(id)sender {
	[NSApp endSheet:self.openAccountSheet];
	[self.openAccountSheet orderOut:self];
	[self.delegate controller:self openAccountWithID:self.accountIDField.stringValue type:(M3AccountType)self.accountTypePopup.indexOfSelectedItem];
}

- (IBAction)cancelOpenAccount:(id)sender {
	[NSApp endSheet:self.openAccountSheet];
	[self.openAccountSheet orderOut:self];
}


#pragma mark -
#pragma mark Depositing

- (IBAction)deposit:(id)sender {
	[self.delegate controller:self
				depositAmount:self.depositAmountField.integerValue
				  intoAccount:self.selectedAccount];
	[self.accountsTable reloadData];
	[self _updateSelection];
}


#pragma mark -
#pragma mark Withdrawing

- (IBAction)withdraw:(id)sender {
	[self.delegate controller:self
			   withdrawAmount:self.withdrawAmountField.integerValue
				  fromAccount:self.selectedAccount];
	[self.accountsTable reloadData];
	[self _updateSelection];
}


#pragma mark -
#pragma mark Transfers

- (void)_updateTransferDestinations {
	[self.transferDestinationPopup removeAllItems];
	[self.transferDestinationPopup addItemWithTitle:@"Please select an account…"];
	[self.transferDestinationPopup.lastItem setEnabled:NO];

	for (M3Account *account in self.accounts) {
		if (![account isEqual:self.selectedAccount]) {
			[self.transferDestinationPopup addItemWithTitle:account.description];
			[self.transferDestinationPopup.lastItem setRepresentedObject:account];
		}
	}
}

- (IBAction)transfer:(id)sender {
	[self.delegate controller:self
			   transferAmount:self.transferAmountField.integerValue
				  fromAccount:self.selectedAccount
					toAccount:self.transferDestinationPopup.selectedItem.representedObject];
	[self.accountsTable reloadData];
	[self _updateSelection];
}

@end
