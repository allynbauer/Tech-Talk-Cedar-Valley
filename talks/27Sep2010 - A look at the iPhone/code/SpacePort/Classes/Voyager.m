//
//  Voyager.m
//  SpacePort
//
//  Created by Allyn Bauer on 9/23/10.
//  Copyright 2010 T8 Webware. All rights reserved.
//

#import "Voyager.h"

@implementation Voyager

@synthesize emergency, docked, dockStatus, callSign;

-(id)initWithCallSign:(NSString *)_callSign {
	if (self = [super init]) {
		callSign = _callSign;
		dockStatus = 0;
		docked = NO;
		emergency = NO;
	}
	return self;
}

- (void)dealloc {
	[callSign release];
	[super dealloc];
}

// overrides @synthesize of property so we can customize handling
- (void)setDockStatus:(int)_dockStatus {
	if (_dockStatus >= 100) {
		dockStatus = 100;
		[self undockWithPriority:LowPriority];
		[self setEmergency:NO];
		// this.dockStatus = 100; // infinite recursion
	} else dockStatus = _dockStatus;
	[[NSNotificationCenter defaultCenter] postNotificationName:NOTE_EMERGENCY_REMOVE_AVAILABLE object:self];
		
}

- (void)undockWithPriority:(PriorityLevel)priority {
	/*
	 * do undocking sequence - doubleTime if priority == EmergencyPriority
	 *   gather crew
	 *   fuel up
	 *   engines on
	 *   gtfo
	 * 
	 */
	
	self.docked = NO;
	[[NSNotificationCenter defaultCenter] postNotificationName:NOTE_UNDOCK object:self];
}

@end
