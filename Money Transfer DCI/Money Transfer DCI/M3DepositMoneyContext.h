//
//  DCIDepositMoneyContext.h
//  Money Transfer DCI
//
//  Created by Martin Pilkington on 09/05/2012.
//  Copyright (c) 2012 M Cubed Software. All rights reserved.
//

#import "DCIContext.h"
#import "M3Account.h"

@interface M3DepositMoneyContext : DCIContext

- (id)initWithDestinationAccount:(M3Account *)aAccount;

- (void)depositAmount:(NSUInteger)aAmount;

@end
