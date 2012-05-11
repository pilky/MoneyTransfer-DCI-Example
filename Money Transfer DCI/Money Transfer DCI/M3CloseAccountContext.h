//
//  DCICloseAccountContext.h
//  Money Transfer DCI
//
//  Created by Martin Pilkington on 09/05/2012.
//  Copyright (c) 2012 M Cubed Software. All rights reserved.
//

#import "DCIContext.h"
#import "M3Bank.h"
#import "M3Account.h"

@interface M3CloseAccountContext : DCIContext

- (id)initWithBank:(M3Bank *)aBank closingAccount:(M3Account *)aAccount;

@end
