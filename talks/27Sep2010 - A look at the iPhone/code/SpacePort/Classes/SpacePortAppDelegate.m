//
//  SpacePortAppDelegate.m
//  SpacePort
//
//  Created by Allyn Bauer on 9/23/10.
//  Copyright T8 Webware 2010. All rights reserved.
//

#import "SpacePortAppDelegate.h"
#import "SpacePortTable.h"
#import "SpacePort.h"
#import "Voyager.h"

@implementation SpacePortAppDelegate

@synthesize window;
@synthesize viewController;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
	viewController.spacePort = [self exampleData];
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];

    return YES;
}

- (SpacePort *)exampleData {
	SpacePort *spacePort = [[SpacePort alloc] initWithName:@"Neat Ship" maxDockedCraft:5];
	id<Craft> craft = nil;
	
	craft = [[Voyager alloc] initWithCallSign:@"Warrior A17"];
	[spacePort dockCraft:craft];
	[craft release];
	
	craft = [[Voyager alloc] initWithCallSign:@"Voyager 2t"];
	[spacePort dockCraft:craft];
	[craft release];
	
	craft = [[Voyager alloc] initWithCallSign:@"Red Beard 4"];
	[spacePort dockCraft:craft];
	[craft release];
	
	craft = [[Voyager alloc] initWithCallSign:@"Pallas Y1"];
	[spacePort dockCraft:craft];
	[craft release];
	
	craft = [[Voyager alloc] initWithCallSign:@"<classified>"];
	[spacePort dockCraft:craft];
	[craft release];
	
	craft = [[Voyager alloc] initWithCallSign:@"Void Ray"];
	[spacePort dockCraft:craft];
	[craft release];
	
	craft = [[Voyager alloc] initWithCallSign:@"Destroyer 7"];
	[spacePort dockCraft:craft];
	[craft release];
	
	return spacePort;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
