//
//  PixelAccessAppDelegate.m
//  PixelAccess
//
//  Created by Stefan Arentz on 10-02-26.
//  Copyright Apple Inc 2010. All rights reserved.
//

#import "PixelAccessAppDelegate.h"
#import "PixelAccessViewController.h"

@implementation PixelAccessAppDelegate

@synthesize window;
@synthesize viewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
	
	return YES;
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
