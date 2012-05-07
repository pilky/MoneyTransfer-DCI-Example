//
//  M3MainWindowController.m
//  Money Transfer
//
//  Created by Martin Pilkington on 07/05/2012.
//  Copyright (c) 2012 M Cubed Software. All rights reserved.
//

#import "M3MainWindowController.h"

@interface M3MainWindowController ()

- (void)priv_updateSelection;

@end

@implementation M3MainWindowController {
	NSNumberFormatter *currencyFormatter;
}
@synthesize withdrawAmountField;
@synthesize accountBalanceField;
@synthesize depositAmountField;

- (id)init {
	if ((self = [super initWithWindowNibName:@"MainWindowController"])) {
		[self addObserver:self forKeyPath:@"accounts" options:0 context:NULL];
		currencyFormatter = [[NSNumberFormatter alloc] init];
		[currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
	}
	return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	[self.accountsTable reloadData];
	[self performSelector:@selector(priv_updateSelection) withObject:nil afterDelay:0];
}

- (void)presentError:(NSError *)aError {
	[NSApp presentError:aError modalForWindow:self.window delegate:nil didPresentSelector:NULL contextInfo:NULL];
}

- (M3Account *)selectedAccount {
	return self.accounts[self.accountsTable.selectedRow];
}


- (void)priv_updateSelection {
	[self.accountBalanceField setObjectValue:[NSNumber numberWithInteger:self.selectedAccount.balance]];
}


#pragma mark -
#pragma mark Accounts Table

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView {
	return self.accounts.count;
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex {
	M3Account *account = self.accounts[rowIndex];
	return [NSString stringWithFormat:@"%@ (%@)", account.accountID, [currencyFormatter stringForObjectValue:[NSNumber numberWithInteger:account.balance]]];
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification {
	[self priv_updateSelection];
}

- (IBAction)showOpenAccountSheet:(id)sender {
	[self.accountIDField setStringValue:@""];
	[NSApp beginSheet:self.openAccountSheet modalForWindow:self.window modalDelegate:nil didEndSelector:NULL contextInfo:NULL];
}

- (IBAction)closeAccount:(id)sender {
	[self.delegate controller:self closeAccount:self.selectedAccount];
	[self priv_updateSelection];
}



#pragma mark -
#pragma mark Open Account Sheet

- (IBAction)openAccount:(id)sender {
	[NSApp endSheet:self.openAccountSheet];
	[self.openAccountSheet orderOut:self];
	[self.delegate controller:self openAccountWithID:self.accountIDField.stringValue];
}

- (IBAction)cancelOpenAccount:(id)sender {
	[NSApp endSheet:self.openAccountSheet];
	[self.openAccountSheet orderOut:self];
}



#pragma mark -
#pragma mark Depositing

- (IBAction)deposit:(id)sender {
	[self.delegate controller:self depositAmount:self.depositAmountField.integerValue intoAccount:self.selectedAccount];
	[self.accountsTable reloadData];
	[self priv_updateSelection];
}


#pragma mark -
#pragma mark Withdrawing

- (IBAction)withdraw:(id)sender {
	[self.delegate controller:self withdrawAmount:self.withdrawAmountField.integerValue fromAccount:self.selectedAccount];
	[self.accountsTable reloadData];
	[self priv_updateSelection];
}

@end
