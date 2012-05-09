//
//  DCIRole.h
//  Money Transfer DCI
//
//  Created by Martin Pilkington on 09/05/2012.
//  Copyright (c) 2012 M Cubed Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCIRole : NSObject

+ (instancetype)roleWithProtocol:(Protocol *)aProtocol;
- (id)initWithProtocol:(Protocol *)aProtocol;

- (void)addMethod:(id)aBlock withSelector:(SEL)aSelector;
- (id)methodForSelector:(SEL)aSelector;

- (id)objectForKeyedSubscript:(id)aKey;
- (void)setObject:(id)aObject forKeyedSubscript:(id<NSCopying>)key;

- (void)applyToObject:(id)aObject;

@end
