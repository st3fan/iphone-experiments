//  PixelAccessViewController.h

#import <UIKit/UIKit.h>

@interface PixelAccessViewController : UIViewController {
	UILabel* label_;
}

@property (nonatomic,assign) IBOutlet UILabel* label;

- (IBAction) processImage;

@end

