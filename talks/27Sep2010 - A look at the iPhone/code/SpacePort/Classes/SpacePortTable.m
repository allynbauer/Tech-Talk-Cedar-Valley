//
//  SpacePortTable.m
//  SpacePort
//
//  Created by Allyn Bauer on 9/23/10.
//  Copyright 2010 T8 Webware. All rights reserved.
//

#import "SpacePortTable.h"
#import "SpacePort.h"
#import "CraftCell.h"

@implementation SpacePortTable

@synthesize spacePort;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)refresh {
	[self.tableView	reloadData];
}

- (void)setSpacePort:(SpacePort *)_spacePort {
	[_spacePort retain];
	[spacePort release];
	spacePort = _spacePort;
	[self refresh];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return [[spacePort allCrafts] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[spacePort allCrafts] objectAtIndex:section] count];
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if (section == 0) {
		return @"Docked Spacecrafts";
	} else return @"Undocked Spacecrafts";
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 42;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CraftCell";
    
    CraftCell *cell = (CraftCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		cell = [[[CraftCell alloc] initWithReuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.craft = [[[spacePort allCrafts] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	id<Craft> craft = [[[spacePort allCrafts] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
	if (indexPath.section == 0) {
		srand ( time(NULL) );
		[craft setDockStatus:(random() % 100) + 1];
	} else {
		[craft setEmergency:YES];
		[[NSNotificationCenter defaultCenter] postNotificationName:NOTE_CRAFT_HAS_EMERGENCY object:craft];
	}
	[self refresh];
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
	[spacePort release];
    [super dealloc];
}


@end

