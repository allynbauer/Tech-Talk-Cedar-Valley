//
//  Voyager.h
//  SpacePort
//
//  Created by Allyn Bauer on 9/23/10.
//  Copyright 2010 T8 Webware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Craft.h"

@interface Voyager : NSObject <Craft> {
	BOOL docked;
	BOOL emergency;
	int dockStatus;
	NSString *callSign;
}

@property(nonatomic, getter=isDocked) BOOL docked;
@property(nonatomic, getter=hasEmergency) BOOL emergency;
@property(nonatomic) int dockStatus;
@property(nonatomic, copy, readonly) NSString *callSign;

-(id)initWithCallSign:(NSString *)_callSign;

@end
