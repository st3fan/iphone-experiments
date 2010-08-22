// ScreenShotViewController.h

#import <UIKit/UIKit.h>

@interface ScreenShotViewController : UIViewController {
	UIScrollView* _scrollView;
}

@property (nonatomic,retain) IBOutlet UIScrollView* scrollView;

- (IBAction) renderScrollViewToImage;

@end

