//
//  FlickerAppDelegate.m
//  Flicker
//
//  Created by Stefan Arentz on 10-01-23.
//  Copyright Arentz Consulting 2010. All rights reserved.
//

#import "FlickerAppDelegate.h"
#import "FlickerViewController.h"

@implementation FlickerAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
