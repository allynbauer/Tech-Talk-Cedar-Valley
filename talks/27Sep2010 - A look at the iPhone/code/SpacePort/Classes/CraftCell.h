//
//  CraftCell.h
//  SpacePort
//
//  Created by Allyn Bauer on 9/23/10.
//  Copyright 2010 T8 Webware. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Craft.h"

@interface CraftCell : UITableViewCell {
	id<Craft> craft;
	
	UILabel *callSignLabel;
	UILabel *dockStatusLabel;
}

@property(nonatomic, retain) id<Craft> craft;
@property(nonatomic, retain, readonly) UILabel *callSignLabel;
@property(nonatomic, retain, readonly) UILabel *dockStatusLabel;

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@end
