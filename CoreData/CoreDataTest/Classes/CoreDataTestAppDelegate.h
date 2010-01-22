// CoreDataTestAppDelegate.h

@interface CoreDataTestAppDelegate : NSObject <UIApplicationDelegate> {
  @private
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end