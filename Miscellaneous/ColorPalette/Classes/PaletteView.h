// PaletteView.h

#import <UIKit/UIKit.h>

@class PaletteView;

@protocol PaletteViewDelegate
- (void) paletteView: (PaletteView*) paletteView didSelectColor: (UIColor*) color;
@end

@interface PaletteView : UIView {
  @private
    id<PaletteViewDelegate> _delegate;
  @private
	UIView* _lastView;
}

@property (nonatomic,assign) IBOutlet id<PaletteViewDelegate> delegate;

@end
