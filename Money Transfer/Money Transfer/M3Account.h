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
@property (readonly) NSUInteger balance;
@property (readonly) NSUInteger availableBalance;

- (void)deposit:(NSUInteger)aAmount;
- (BOOL)withdraw:(NSUInteger)aAmount error:(NSError **)aError;
- (BOOL)transfer:(NSUInteger)aAmount toAccount:(M3Account *)aDestinationAccount error:(NSError **)aError;

@end
