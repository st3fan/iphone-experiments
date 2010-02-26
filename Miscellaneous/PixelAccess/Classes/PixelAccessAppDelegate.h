//
//  PixelAccessAppDelegate.h
//  PixelAccess
//
//  Created by Stefan Arentz on 10-02-26.
//  Copyright Apple Inc 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PixelAccessViewController;

@interface PixelAccessAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    PixelAccessViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet PixelAccessViewController *viewController;

@end

