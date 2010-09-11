// TestViewController.h

#import <UIKit/UIKit.h>

@interface TestViewController : UIViewController {
	CALayer* _layer;
}

- (IBAction) rotateLeft;
- (IBAction) rotateRight;

@end