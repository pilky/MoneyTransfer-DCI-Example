//
//  M3Bank.h
//  Money Transfer
//
//  Created by Martin Pilkington on 07/05/2012.
//  Copyright (c) 2012 M Cubed Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "M3Account.h"



@interface M3Bank : NSObject

@property (readonly) NSArray *accounts;

- (void)addAccount:(M3Account *)aAccount;
- (void)removeAccount:(M3Account *)aAccount;

@end
