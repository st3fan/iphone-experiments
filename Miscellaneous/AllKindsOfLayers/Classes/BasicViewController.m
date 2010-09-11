// BasicViewController.m

#import <QuartzCore/QuartzCore.h>
#import "BasicViewController.h"

@implementation BasicViewController

- (CGPoint) randomPosition
{
	return CGPointMake(
		64 + (random() % (int) (self.view.frame.size.width - 128)),
		64 + (random() % (int) (self.view.frame.size.height - 128))
	);
}

- (void) animationDidStop: (CAAnimation*) animation finished: (BOOL) flag
{
	CALayer* layer = [animation valueForKey: @"layer"];

	CGPoint position = layer.position;
	layer.position = [self randomPosition];

	{
		CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath: @"position"];
		animation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];
		animation.fromValue = [NSValue valueWithCGPoint: position];
		animation.toValue = [NSValue valueWithCGPoint: layer.position];
		animation.duration = 1.0 + (random() % 3);
		animation.delegate = self;

		[animation setValue: layer forKey: @"layer"];

		[layer addAnimation: animation forKey: @"position"];
	}
}

- (void) viewDidLoad
{
	// Add a gradient background layer
	
	CAGradientLayer* gradientLayer = [CAGradientLayer layer];
	gradientLayer.colors = [NSArray arrayWithObjects: [UIColor grayColor].CGColor, [UIColor whiteColor].CGColor, [UIColor grayColor].CGColor, nil];
	gradientLayer.bounds = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
	gradientLayer.position = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
	
	[self.view.layer addSublayer: gradientLayer];

	// Make the text appear
	
	CATextLayer* textLayer = [CATextLayer layer];
	textLayer.string = @"Icons from the Star Trek TOS icon set\nAvailable from http://theiconfactory.com";
	textLayer.fontSize = 24.0;
	textLayer.alignmentMode = kCAAlignmentCenter;
	textLayer.bounds = CGRectMake(0, 0, 600, 200);
	textLayer.position = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
	textLayer.foregroundColor = [UIColor blackColor].CGColor;
	[self.view.layer addSublayer: textLayer];

	CGFloat savedOpacity = textLayer.opacity;
	textLayer.opacity = 0.05;

	CABasicAnimation* textAnimation = [CABasicAnimation animationWithKeyPath: @"opacity"];
	textAnimation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];
	textAnimation.fromValue = [NSNumber numberWithFloat: savedOpacity];
	textAnimation.toValue = [NSNumber numberWithFloat: textLayer.opacity];
	textAnimation.repeatCount = HUGE_VALF;
	textAnimation.autoreverses = YES;
	textAnimation.duration = 2.0;
	[textLayer addAnimation: textAnimation forKey: @"opacity"];

	// Create layers and set their initial position

	NSArray* imagePaths = [[NSBundle mainBundle] pathsForResourcesOfType: @"png" inDirectory: nil];

	srandom(time(NULL));

	_iconLayers = [NSMutableArray new];
	
	for (NSString* imagePath in imagePaths)
	{
		UIImage* image = [UIImage imageWithContentsOfFile: imagePath];
	
		CALayer* layer = [CALayer layer];
		layer.contents = (id) image.CGImage;
		layer.bounds = CGRectMake(0, 0, 128, 128);
		layer.position = [self randomPosition];
		[self.view.layer addSublayer: layer];
		
		[_iconLayers addObject: layer];
	}
}

- (void) viewDidAppear:(BOOL)animated
{
	// Move them to new places
	
	for (CALayer* layer in _iconLayers)
	{
		CGPoint position = layer.position;
		layer.position = [self randomPosition];
		
		CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath: @"position"];
		animation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];
		animation.fromValue = [NSValue valueWithCGPoint: position];
		animation.toValue = [NSValue valueWithCGPoint: layer.position];
		animation.duration = 1.0 + (random() % 3);
		animation.delegate = self;
		
		[animation setValue: layer forKey: @"layer"];
		
		[layer addAnimation: animation forKey: @"position"];
	}
}

@end
