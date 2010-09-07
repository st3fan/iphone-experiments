//  ScreenShotViewController.m

#import <QuartzCore/QuartzCore.h>
#import "ScreenShotViewController.h"

@implementation ScreenShotViewController

@synthesize scrollView = _scrollView;

- (void) viewDidLoad
{
	UIImageView* imageViewA = [[[UIImageView alloc] initWithImage: [UIImage imageNamed: @"ImageA.png"]] autorelease];
	imageViewA.frame = CGRectMake(0, 0*460, 320, 460);
	[_scrollView addSubview: imageViewA];
	
	UIImageView* imageViewB = [[[UIImageView alloc] initWithImage: [UIImage imageNamed: @"ImageB.png"]] autorelease];
	imageViewB.frame = CGRectMake(0, 1*460, 320, 460);
	[_scrollView addSubview: imageViewB];
	
	UIImageView* imageViewC = [[[UIImageView alloc] initWithImage: [UIImage imageNamed: @"ImageC.png"]] autorelease];
	imageViewC.frame = CGRectMake(0, 2*460, 320, 460);
	[_scrollView addSubview: imageViewC];

	_scrollView.contentSize = CGSizeMake(320, 3*460);
}

	- (IBAction) renderScrollViewToImage
	{
		UIImage* image = nil;

		UIGraphicsBeginImageContext(_scrollView.contentSize);
		{
			CGPoint savedContentOffset = _scrollView.contentOffset;
			CGRect savedFrame = _scrollView.frame;
		
			_scrollView.contentOffset = CGPointZero;
			_scrollView.frame = CGRectMake(0, 0, _scrollView.contentSize.width, _scrollView.contentSize.height);
		
			[_scrollView.layer renderInContext: UIGraphicsGetCurrentContext()];		
			image = UIGraphicsGetImageFromCurrentImageContext();
			
			_scrollView.contentOffset = savedContentOffset;
			_scrollView.frame = savedFrame;
		}
		UIGraphicsEndImageContext();

		if (image != nil) {
			[UIImagePNGRepresentation(image) writeToFile: @"/tmp/test.png" atomically: YES];
			system("open /tmp/test.png");
		}
	}

@end
