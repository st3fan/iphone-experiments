//
//  FlickerAppDelegate.h
//  Flicker
//
//  Created by Stefan Arentz on 10-01-23.
//  Copyright Arentz Consulting 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlickerViewController;

@interface FlickerAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    FlickerViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet FlickerViewController *viewController;

@end

