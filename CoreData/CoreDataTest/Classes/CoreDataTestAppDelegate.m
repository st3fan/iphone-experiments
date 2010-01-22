// CoreDataTestAppDelegate.m

#import "CoreDataTestAppDelegate.h"
#import "DataRepository.h"
#import "CountriesTableViewController.h"

@implementation CoreDataTestAppDelegate

@synthesize window;
@synthesize navigationController;

- (void) applicationDidFinishLaunching: (UIApplication*) application
{
	[[DataRepository sharedInstance] open];
	[[DataRepository sharedInstance] populate];
	
	[window addSubview: [navigationController view]];
    [window makeKeyAndVisible];
}

- (void) applicationWillTerminate: (UIApplication*) application
{
	[[DataRepository sharedInstance] close];
}

- (void) dealloc
{
	[navigationController release];
	[window release];
	[super dealloc];
}

@end