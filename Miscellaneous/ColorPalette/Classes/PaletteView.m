// PaletteView.m

#import "PaletteView.h"

@implementation PaletteView

@synthesize delegate = _delegate;

- (void) updateColor: (UIView*) view
{
	if (_lastView != view) {
		_lastView = view;
		[_delegate paletteView: self didSelectColor: view.backgroundColor];
	}
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIView* view = [self hitTest: [[touches anyObject] locationInView: self] withEvent: nil];
	if (view != nil && view != self) {
		[self updateColor: view];
	}
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIView* view = [self hitTest: [[touches anyObject] locationInView: self] withEvent: nil];
	if (view != nil && view != self) {
		[self updateColor: view];		
	}
}

@end
