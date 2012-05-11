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
	BOOL failed;
	NSError *error;
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

- (BOOL)start:(NSError **)aError {
	for (NSDictionary *player in players) {
		[player[DCIPlayerRole] applyToObject:player[DCIPlayerObject]];
	}

	[self main];

	if(failed && aError != NULL) {
		*aError = error;
		return NO;
	}
	return YES;
}

- (void)returnError:(NSError *)aError {
	failed = YES;
	error = aError;
}

- (void)main {
	@throw [NSException exceptionWithName:@"DCIContextMainNotImplemented" reason:@"You need to override the -main method" userInfo:nil];
}
@end
