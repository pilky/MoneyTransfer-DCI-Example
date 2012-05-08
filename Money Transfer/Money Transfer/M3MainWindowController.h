//
//  M3MainWindowController.h
//  Money Transfer
//
//  Created by Martin Pilkington on 07/05/2012.
//  Copyright (c) 2012 M Cubed Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "M3Account.h"
#import "M3Bank.h"

@protocol M3MainWindowControllerDelegate;
@interface M3MainWindowController : NSWindowController <NSTableViewDelegate>

@property (weak) id <M3MainWindowControllerDelegate>delegate;
@property (copy) NSArray *accounts;
@property (readonly) M3Account *selectedAccount;

- (void)presentError:(NSError *)aError;

//UI

@property (weak) IBOutlet NSTableView *accountsTable;
- (IBAction)showOpenAccountSheet:(id)sender;
- (IBAction)closeAccount:(id)sender;

@property (strong) IBOutlet NSWindow *openAccountSheet;
@property (weak) IBOutlet NSTextField *accountIDField;
@property (weak) IBOutlet NSPopUpButton *accountTypePopup;
- (IBAction)openAccount:(id)sender;
- (IBAction)cancelOpenAccount:(id)sender;

@property (weak) IBOutlet NSTextField *accountBalanceField;
@property (weak) IBOutlet NSTextField *accountAvailableBalanceField;

@property (weak) IBOutlet NSTextField *depositAmountField;
- (IBAction)deposit:(id)sender;

@property (weak) IBOutlet NSTextField *withdrawAmountField;
- (IBAction)withdraw:(id)sender;

@property (weak) IBOutlet NSPopUpButton *transferDestinationPopup;
@property (weak) IBOutlet NSTextField *transferAmountField;
- (IBAction)transfer:(id)sender;

@end


@protocol M3MainWindowControllerDelegate <NSObject>

@required
- (void)controller:(M3MainWindowController *)aController openAccountWithID:(NSString *)aAccountID type:(M3AccountType)aType;
- (void)controller:(M3MainWindowController *)aController closeAccount:(M3Account *)aAccount;
- (void)controller:(M3MainWindowController *)aController depositAmount:(NSUInteger)aAmount intoAccount:(M3Account *)aAccount;
- (void)controller:(M3MainWindowController *)aController withdrawAmount:(NSUInteger)aAmount fromAccount:(M3Account *)aAccount;
- (void)controller:(M3MainWindowController *)aController transferAmount:(NSUInteger)aAmount fromAccount:(M3Account *)aFromAccount toAccount:(M3Account *)aToAccount;

@end