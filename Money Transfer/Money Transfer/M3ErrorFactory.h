//
//  M3ErrorFactory.h
//  Money Transfer
//
//  Created by Martin Pilkington on 11/05/2012.
//  Copyright (c) 2012 M Cubed Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface M3ErrorFactory : NSObject

+ (NSError *)accountToCloseHasNonEmptyBalanceError;
+ (NSError *)insufficientFundsErrorWithAvailableBalance:(NSUInteger)aAvailableBalance;
+ (NSError *)accountDoesntSupportWithdrawlsError;
+ (NSError *)noTransferDestinationAccountSelectedError;

@end
