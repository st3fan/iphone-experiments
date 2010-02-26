//  PixelAccessViewController.mm

#import "PixelAccessViewController.h"

@implementation PixelAccessViewController

@synthesize label = label_;

/**
 * Structure to keep one pixel in RRRRRRRRGGGGGGGGBBBBBBBBAAAAAAAA format
 */

struct pixel {
    unsigned char r, g, b, a;
};

/**
 * Process the image and return the number of pure red pixels in it.
 */

- (NSUInteger) processImage: (UIImage*) image
{
	NSUInteger numberOfRedPixels = 0;

	// Allocate a buffer big enough to hold all the pixels

	struct pixel* pixels = (struct pixel*) calloc(1, image.size.width * image.size.height * sizeof(struct pixel));
	if (pixels != nil)
	{
		// Create a new bitmap

		CGContextRef context = CGBitmapContextCreate(
			(void*) pixels,
			image.size.width,
			image.size.height,
			8,
			image.size.width * 4,
			CGImageGetColorSpace(image.CGImage),
			kCGImageAlphaPremultipliedLast
		);
		
		if (context != NULL)
		{
			// Draw the image in the bitmap
		
			CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, image.size.width, image.size.height), image.CGImage);
		
			// Now that we have the image drawn in our own buffer, we can loop over the pixels to
			// process it. This simple case simply counts all pixels that have a pure red component.

			// There are probably more efficient and interesting ways to do this. But the important
			// part is that the pixels buffer can be read directly.
			
			NSUInteger numberOfPixels = image.size.width * image.size.height;

			while (numberOfPixels > 0) {
				if (pixels->r == 255) {
					numberOfRedPixels++;
				}
				pixels++;
				numberOfPixels--;
			}
			
			CGContextRelease(context);
		}

		free(pixels);
	}
	
	return numberOfRedPixels;
}

- (IBAction) processImage
{
	NSUInteger numberOfRedPixels = [self processImage: [UIImage imageNamed: @"DutchFlag.png"]];
	label_.text = [NSString stringWithFormat: @"There are %d red pixels in the image", numberOfRedPixels];
}

@end
