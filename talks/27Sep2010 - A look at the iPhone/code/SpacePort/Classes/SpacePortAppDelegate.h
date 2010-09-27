//
//  SpacePortAppDelegate.h
//  SpacePort
//
//  Created by Allyn Bauer on 9/23/10.
//  Copyright T8 Webware 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SpacePortTable;
@class SpacePort;

@interface SpacePortAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    SpacePortTable *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet SpacePortTable *viewController;

- (SpacePort *)exampleData;

@end

