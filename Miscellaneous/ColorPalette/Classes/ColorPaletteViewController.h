// ColorPaletteViewController.h

#import <UIKit/UIKit.h>
#import "PaletteView.h"

@interface ColorPaletteViewController : UIViewController <PaletteViewDelegate> {
  @private
	UIView* _currentColorView;
}

@property (nonatomic,assign) IBOutlet UIView* currentColorView;

@end

