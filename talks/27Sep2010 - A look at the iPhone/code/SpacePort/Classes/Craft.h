//
//  Craft.h
//  SpacePort
//
//  Created by Allyn Bauer on 9/23/10.
//  Copyright 2010 T8 Webware. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
	LowPriority,
	MediumPriority,
	HighPriority,
	EmergencyPriority
} PriorityLevel;

@protocol Craft <NSObject>

- (void)setEmergency:(BOOL)_emergency;
- (BOOL)hasEmergency;
- (int)dockStatus; // how close is this craft to being undockable?
- (void)setDockStatus:(int)_dockStatus;
- (void)setDocked:(BOOL)_isDocked;
- (void)undockWithPriority:(PriorityLevel)priority;
- (NSString *)callSign;

@end
