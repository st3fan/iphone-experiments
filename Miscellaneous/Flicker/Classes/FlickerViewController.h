//  FlickerViewController.h

#import <UIKit/UIKit.h>

@interface FlickerViewController : UIViewController {
  @private
	UIImageView* imageView_;
	NSTimer* timer_;
}

@property (nonatomic,assign) IBOutlet UIImageView* imageView;

@end

