//
//  SpacePort.m
//  SpacePort
//
//  Created by Allyn Bauer on 9/23/10.
//  Copyright 2010 T8 Webware. All rights reserved.
//

#import "SpacePort.h"

@implementation SpacePort

@synthesize dockedCrafts, maxDockedCraft, name, undockedCrafts, allCrafts;

- (id)initWithName:(NSString *)_name maxDockedCraft:(int)_maxDockedCraft {
	if (self = [super init]) {
		name = _name;
		dockedCrafts = [[NSMutableArray alloc] init]; // try commenting out one of these and see the fun.
		undockedCrafts = [[NSMutableArray alloc] init];
		maxDockedCraft = _maxDockedCraft; // direct assignment to variable
		// self.maxDockedCraft = _maxDockedCraft; // will not work - uses setter which was not generated cause property is readonly
		[[NSNotificationCenter defaultCenter] addObserver:self 
												 selector:@selector(craftEmergency:) 
													 name:NOTE_CRAFT_HAS_EMERGENCY 
												   object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self 
												 selector:@selector(canRemove:) 
													 name:NOTE_EMERGENCY_REMOVE_AVAILABLE 
												   object:nil];
	}
	return self;
}
	
- (void)dealloc {
	[dockedCrafts release];
	[undockedCrafts release];
	[name release];
	[super dealloc];
}

- (NSArray *)allCrafts {
	NSMutableArray *_allCrafts = [NSMutableArray array];
	[_allCrafts addObject:dockedCrafts];
	[_allCrafts addObject:undockedCrafts];
	return _allCrafts;
}

// find all the crafts that can undock if there is a remote emergency requiring a foreign craft to dock
- (NSArray *)undockableCrafts {
	NSMutableArray *undockables = [NSMutableArray array]; // autoreleased (count=1 soon to be =0)
	for (id<Craft> craft in dockedCrafts) {
		if (![craft hasEmergency] && [craft dockStatus] > 50) {
			[undockables addObject:craft];
		}
	}
	return undockables;
}

// return the undocked craft that has an onboard emergency or nil if there isn't one
- (id<Craft>)emergencyCraft {
	for (id<Craft> craft in undockedCrafts) {
		if ([craft hasEmergency]) {
			return craft;
		}
	}
	return nil;
}

// note callbacks
- (void)canRemove:(NSNotification *)note {
	id<Craft> emergencyCraft = nil;
	for (id<Craft> _emergencyCraft in undockedCrafts) {
		if ([emergencyCraft hasEmergency]) {
			emergencyCraft = _emergencyCraft;
			break;
		}
	}
	
	[self dockCraft:emergencyCraft];
}

- (void)craftEmergency:(NSNotification *)note {
	id <Craft> emergencyCraft = (id<Craft>)[note object];
	[self dockCraft:emergencyCraft];
}

- (void)undockNotification:(NSNotification *)note {
	id <Craft> undockingCraft = (id<Craft>)[note object];
	[undockedCrafts addObject:undockingCraft];
	undockingCraft.emergency = NO;
	[dockedCrafts removeObjectIdenticalTo:undockingCraft];
	[[NSNotificationCenter defaultCenter] removeObserver:self 
													name:NOTE_UNDOCK 
												  object:undockingCraft]; // we don't care anymore
	[self dockCraft:[self emergencyCraft]];
}

- (BOOL)dockCraft:(id<Craft>)craft {
	BOOL success = NO;
	if (!craft) return success;
	if ([dockedCrafts count] < maxDockedCraft) {
		[undockedCrafts removeObjectIdenticalTo:craft];
		[dockedCrafts addObject:craft];
		[craft setDocked:YES];
		[craft setDockStatus:0];
		success = YES;
	} else if ([craft hasEmergency]) {
		NSArray *undockables = [self undockableCrafts];
		if ([undockables count] > 0) { // something can be undocked
			id<Craft> undockingCraft = [undockables lastObject];
			[[NSNotificationCenter defaultCenter] addObserver:self 
													 selector:@selector(undockNotification:) 
														 name:NOTE_UNDOCK 
													   object:undockingCraft];
			[undockingCraft undockWithPriority:EmergencyPriority];
		} else { // there's an emergency and none of the docked crafts may be undocked early. whattodo
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Good Luck" 
															message:@"You are probably screwed." 
														   delegate:nil 
												  cancelButtonTitle:@"Noted" 
												  otherButtonTitles:nil];
			[alert show];
			[alert release];
		}
	} else {
		[craft setDockStatus:0];
		[undockedCrafts addObject:craft];
	}
	
	return success;
}

@end

