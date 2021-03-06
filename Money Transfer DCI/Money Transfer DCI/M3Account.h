//
//  M3Account.h
//  Money Transfer
//
//  Created by Martin Pilkington on 07/05/2012.
//  Copyright (c) 2012 M Cubed Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface M3Account : NSObject

- (id)initWithAccountID:(NSString *)aID;

@property (readonly) NSString *accountID;
@property (assign) NSUInteger balance;
@property (readonly) NSUInteger availableBalance;

@end
