// TestViewController.m

#import <QuartzCore/QuartzCore.h>
#import "TestViewController.h"

@implementation TestViewController

- (void) viewDidAppear:(BOOL)animated
{
	_layer = [CALayer layer];

	//_layer.backgroundColor = [UIColor redColor].CGColor;
	_layer.position = CGPointMake(160, 200);
	_layer.bounds = CGRectMake(0, 0, 120, 120);
	
	CGMutablePathRef path = CGPathCreateMutable();

	CGPathAddArc(path, NULL, 60, 60, 50, 0, 3.14, true);
	CGPathAddArc(path, NULL, 60, 60, 50, 3.14, 0, true);
	
	CAShapeLayer* shapeLayer = [CAShapeLayer layer];
	shapeLayer.bounds = CGRectMake(0, 0, 120, 120);
	shapeLayer.position = CGPointMake(60, 60);
	shapeLayer.path = path;
	shapeLayer.lineWidth = 3.0;
	shapeLayer.fillColor = nil;
	shapeLayer.strokeColor = [UIColor blackColor].CGColor;
	[_layer addSublayer: shapeLayer];

	CALayer* top = [CALayer layer];
	top.backgroundColor = [UIColor blueColor].CGColor;
	top.position = CGPointMake(60, 10);
	top.bounds = CGRectMake(0, 0, 20, 20);
	[_layer addSublayer: top];

	CALayer* bottom = [CALayer layer];
	bottom.backgroundColor = [UIColor cyanColor].CGColor;
	bottom.position = CGPointMake(60, 110);
	bottom.bounds = CGRectMake(0, 0, 20, 20);
	[_layer addSublayer: bottom];
	
	CALayer* left = [CALayer layer];
	left.backgroundColor = [UIColor greenColor].CGColor;
	left.position = CGPointMake(10, 60);
	left.bounds = CGRectMake(0, 0, 20, 20);
	[_layer addSublayer: left];

	CALayer* right = [CALayer layer];
	right.backgroundColor = [UIColor yellowColor].CGColor;
	right.position = CGPointMake(110,60);
	right.bounds = CGRectMake(0, 0, 20, 20);
	[_layer addSublayer: right];
	
	[self.view.layer addSublayer: _layer];

	//

}

- (IBAction) rotateLeft
{
	CATransform3D transform = _layer.transform;
	_layer.transform = CATransform3DConcat(transform, CATransform3DMakeRotation(-0.5 * M_PI, 0.0f, 0.0f, 1.0f));

	CAKeyframeAnimation* rotation = [CAKeyframeAnimation animation];

	rotation.values = [NSArray arrayWithObjects:
		[NSValue valueWithCATransform3D: transform],
		[NSValue valueWithCATransform3D: _layer.transform],
		nil];
		
	rotation.duration = 0.25;
	rotation.delegate = self;	
	
	[_layer addAnimation: rotation forKey: @"transform"];
}

- (IBAction) rotateRight
{
	CATransform3D transform = _layer.transform;
	_layer.transform = CATransform3DConcat(transform, CATransform3DMakeRotation(0.5 * M_PI, 0.0f, 0.0f, 1.0f));

	CAKeyframeAnimation* rotation = [CAKeyframeAnimation animation];

	rotation.values = [NSArray arrayWithObjects:
		[NSValue valueWithCATransform3D: transform],
		[NSValue valueWithCATransform3D: _layer.transform],
		nil];
		
	rotation.duration = 0.25;
	rotation.delegate = self;	
	
	[_layer addAnimation: rotation forKey: @"transform"];
}

@end
