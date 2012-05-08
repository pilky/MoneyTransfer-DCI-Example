//
//  M3AppDelegate.h
//  Money Transfer
//
//  Created by Martin Pilkington on 07/05/2012.
//  Copyright (c) 2012 M Cubed Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "M3MainWindowController.h"
#import "M3Bank.h"

@interface M3AppDelegate : NSObject <NSApplicationDelegate, M3MainWindowControllerDelegate>

@property (readonly, strong) M3MainWindowController *mainWindowController;
@property (readonly, strong) M3Bank *bank;

@end
