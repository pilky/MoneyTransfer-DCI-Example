//
//  M3MainWindowController.m
//  Money Transfer
//
//  Created by Martin Pilkington on 07/05/2012.
//  Copyright (c) 2012 M Cubed Software. All rights reserved.
//

#import "M3MainWindowController.h"

@interface M3MainWindowController ()

@end

@implementation M3MainWindowController {
	NSNumberFormatter *currencyFormatter;
}

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

- (IBAction)showOpenAccountSheet:(id)sender {
	[self.accountIDField setStringValue:@""];
	[NSApp beginSheet:self.openAccountSheet modalForWindow:self.window modalDelegate:nil didEndSelector:NULL contextInfo:NULL];
}

- (IBAction)closeAccount:(id)sender {
	[self.delegate controller:self closeAccount:nil];
}

- (IBAction)openAccount:(id)sender {
	[NSApp endSheet:self.openAccountSheet];
	[self.openAccountSheet orderOut:self];
	[self.delegate controller:self openAccountWithID:self.accountIDField.stringValue];
}

- (IBAction)cancelOpenAccount:(id)sender {
	[NSApp endSheet:self.openAccountSheet];
	[self.openAccountSheet orderOut:self];
}
@end
