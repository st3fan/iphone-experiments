//  TestViewController.m

#import "TestViewController.h"

@implementation TestViewController

@synthesize textField = _textField;
@synthesize label = _label;

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
	CGRect frame = _textField.frame;
	frame.size.width += 80;
	frame.origin.x -= 80;
	
	[UIView beginAnimations: @"GrowTextField" context: nil];
	{
		_textField.frame = frame;
		[UIView setAnimationDuration: 0.5];
	}
	[UIView commitAnimations];
	
	return YES;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
	CGRect frame = _textField.frame;
	frame.size.width -= 80;
	frame.origin.x += 80;
	
	[UIView beginAnimations: @"ShrinkTextField" context: nil];
	{
		_textField.frame = frame;
		[UIView setAnimationDuration: 0.5];
	}
	[UIView commitAnimations];
	
	[textField resignFirstResponder];
	
	_label.text = textField.text;

	return YES;
}

@end
