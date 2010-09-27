//
//  SpacePortTable.h
//  SpacePort
//
//  Created by Allyn Bauer on 9/23/10.
//  Copyright 2010 T8 Webware. All rights reserved.
//
@class SpacePort;
#import <UIKit/UIKit.h>

@interface SpacePortTable : UITableViewController {
	SpacePort *spacePort;
}

@property(nonatomic, retain) SpacePort *spacePort;

- (void)refresh;

@end
