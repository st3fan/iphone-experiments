//
//  ScreenShotAppDelegate.h
//  ScreenShot
//
//  Created by Stefan Arentz on 10-08-22.
//  Copyright Arentz Consulting 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScreenShotViewController;

@interface ScreenShotAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ScreenShotViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ScreenShotViewController *viewController;

@end

