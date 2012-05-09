//
//  DCIContext.m
//  Money Transfer DCI
//
//  Created by Martin Pilkington on 08/05/2012.
//  Copyright (c) 2012 M Cubed Software. All rights reserved.
//

#import "DCIContext.h"

NSString *DCIPlayerObject = @"DCIPlayerObject";
NSString *DCIPlayerRole = @"DCIPlayerRole";

@implementation DCIContext {
	NSMutableArray *players;
}

- (id)init {
	if ((self = [super init])) {
		players = [NSMutableArray array];
	}
	return self;
}

- (id)playerFromObject:(id)aObject forRole:(DCIRole *)aRole {
	[players addObject:@{ DCIPlayerObject : aObject, DCIPlayerRole : aRole }];
	return aObject;
}

- (void)excute:(void (^)(void))aBlock {
	for (NSDictionary *player in players) {
		[player[DCIPlayerRole] applyToObject:player[DCIPlayerObject]];
	}
	aBlock();
}

@end
