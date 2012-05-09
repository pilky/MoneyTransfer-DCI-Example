//
//  DCITransferMoneyContext.h
//  Money Transfer DCI
//
//  Created by Martin Pilkington on 09/05/2012.
//  Copyright (c) 2012 M Cubed Software. All rights reserved.
//

#import "DCIContext.h"
#import "M3Account.h"

@interface M3TransferMoneyContext : DCIContext

- (id)initWithSourceAccount:(M3Account *)aSourceAccount destinationAccount:(M3Account *)aDestinationAccount;

- (BOOL)transferAmount:(NSUInteger)aAmount error:(NSError **)aError;

@end
