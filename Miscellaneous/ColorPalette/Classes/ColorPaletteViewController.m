// ColorPaletteViewController.m

#import "ColorPaletteViewController.h"

@implementation ColorPaletteViewController

@synthesize currentColorView = _currentColorView;

- (void) paletteView: (PaletteView*) paletteView didSelectColor: (UIColor*) color
{
	_currentColorView.backgroundColor = color;
}

@end
