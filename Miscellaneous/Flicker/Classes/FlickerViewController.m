//  FlickerViewController.m

#import "FlickerViewController.h"

@implementation FlickerViewController

@synthesize imageView = imageView_;

- (void) flicker
{
	if ((random() % 10) > 5) {
		imageView_.alpha = (imageView_.alpha == 0.0) ? 1.0 : 0.0;
	}
}

- (void) viewDidAppear:(BOOL)animated
{
	timer_ = [[NSTimer scheduledTimerWithTimeInterval: 1.0 / 30.0 target: self selector: @selector(flicker) userInfo: nil repeats: YES] retain];
}

- (void) viewDidDisappear:(BOOL)animated
{
	[timer_ invalidate];
	[timer_ release];
}

@end
