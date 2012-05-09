//
//  DCIRole.m
//  Money Transfer DCI
//
//  Created by Martin Pilkington on 09/05/2012.
//  Copyright (c) 2012 M Cubed Software. All rights reserved.
//

#import "DCIRole.h"
#import <objc/runtime.h>

@implementation DCIRole {
	NSString *protocolName;
	NSMutableDictionary *protocolMethods;
	NSMutableDictionary *methods;
}

+ (instancetype)roleWithProtocol:(Protocol *)aProtocol {
	return [[self alloc] initWithProtocol:aProtocol];
}

- (id)initWithProtocol:(Protocol *)aProtocol {
	if ((self = [super init])) {
		protocolName = [NSString stringWithUTF8String:protocol_getName(aProtocol)];
		protocolMethods = [[self methodsFromProtocol:aProtocol] mutableCopy];
		methods = [NSMutableDictionary dictionary];
	}
	return self;
}

- (NSDictionary *)methodsFromProtocol:(Protocol *)aProtocol {
	NSMutableDictionary *methodsDict = [NSMutableDictionary dictionary];
	unsigned int outcount;
	struct objc_method_description *descriptions = protocol_copyMethodDescriptionList(NSProtocolFromString(@"M3MainWindowControllerDelegate"), YES, YES, &outcount);
	for (NSUInteger i = 0; i < outcount; i++) {
		struct objc_method_description description = descriptions[i];
		[methodsDict setObject:[NSString stringWithUTF8String:description.types] forKey:NSStringFromSelector(description.name)];
	}
	return [methodsDict copy];
}

- (void)addMethod:(id)aBlock withSelector:(SEL)aSelector {
	[self setObject:[aBlock copy] forKeyedSubscript:NSStringFromSelector(aSelector)];
}

- (id)methodForSelector:(SEL)aSelector {
	return [methods objectForKey:NSStringFromSelector(aSelector)];
}

- (id)objectForKeyedSubscript:(id)aKey {
	return [methods objectForKey:aKey];
}

- (void)setObject:(id)aObject forKeyedSubscript:(id<NSCopying>)key {
	if (![protocolMethods.allKeys containsObject:key]) {
		@throw [NSException exceptionWithName:@"DCIRoleSelectorNotFound"
									   reason:[NSString stringWithFormat:@"The selector %@ was not found in the protocol %@", key, protocolName]
									 userInfo:nil];
	}
	[methods setObject:aObject forKey:key];
}

- (void)applyToObject:(id)aObject {
	Class objectClass = [aObject class];
	[methods enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
		NSString *types = [protocolMethods objectForKey:key];
		IMP implementation = imp_implementationWithBlock(obj);
		class_addMethod(objectClass, NSSelectorFromString(key), implementation, types.UTF8String);
	}];
}

@end
