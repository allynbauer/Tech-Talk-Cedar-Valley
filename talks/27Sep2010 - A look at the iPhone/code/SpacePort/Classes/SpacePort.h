//
//  SpacePort.h
//  SpacePort
//
//  Created by Allyn Bauer on 9/23/10.
//  Copyright 2010 T8 Webware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Craft.h"

@interface SpacePort : NSObject {
	NSString *name;
	NSMutableArray *dockedCrafts;
	NSMutableArray *undockedCrafts;
	int maxDockedCraft;
}

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, assign, readonly) int maxDockedCraft;
@property (retain) NSMutableArray *dockedCrafts;
@property (retain) NSMutableArray *undockedCrafts;
@property (nonatomic, retain, readonly) NSArray *allCrafts;

- (BOOL)dockCraft:(id<Craft>)craft;
- (id)initWithName:(NSString *)_name maxDockedCraft:(int)_maxDockedCraft;

@end
