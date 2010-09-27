//
//  CraftCell.m
//  SpacePort
//
//  Created by Allyn Bauer on 9/23/10.
//  Copyright 2010 T8 Webware. All rights reserved.
//

#import "CraftCell.h"

@implementation CraftCell

@synthesize craft, callSignLabel, dockStatusLabel;

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier])) {
		callSignLabel = [[UILabel alloc] init];
		dockStatusLabel = [[UILabel alloc] init];
		callSignLabel.backgroundColor = [UIColor clearColor];
		dockStatusLabel.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:callSignLabel];
		[self.contentView addSubview:dockStatusLabel];
    }
    return self;
}

- (void)dealloc {
	[craft release];
	[callSignLabel release];
	[dockStatusLabel release];
    [super dealloc];
}

- (void)setCraft:(id <Craft>)_craft {
	[_craft retain];
	[craft release];
	craft = _craft;
	callSignLabel.text = [craft callSign];
	dockStatusLabel.text = [NSString stringWithFormat:@"%d", [craft dockStatus], nil];
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	CGRect contextRect = self.contentView.bounds;
	int width_3 = contextRect.size.width / 3;
	callSignLabel.frame = CGRectMake(10, 0, width_3*2, 40);
	dockStatusLabel.frame = CGRectMake(width_3*2+10, 0, width_3-10, 40);
	
	if ([craft hasEmergency]) {
		callSignLabel.textColor = [UIColor redColor];
	} else {
		callSignLabel.textColor = [UIColor blackColor];
	}
}


@end
