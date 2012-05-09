//
//  DCIContext.h
//  Money Transfer DCI
//
//  Created by Martin Pilkington on 08/05/2012.
//  Copyright (c) 2012 M Cubed Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCIRole.h"

@interface DCIContext : NSObject

- (id)playerFromObject:(id)aObject forRole:(DCIRole *)aRole;
- (void)execute:(void (^)(void))aBlock;

@end
