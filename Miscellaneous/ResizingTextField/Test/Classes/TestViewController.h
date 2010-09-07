// TestViewController.h

#import <UIKit/UIKit.h>

@interface TestViewController : UIViewController <UITextFieldDelegate> {
  @private
	UITextField* _textField;
	UILabel* _label;
}

@property (nonatomic,assign) IBOutlet UITextField* textField;
@property (nonatomic,assign) IBOutlet UILabel* label;

@end