//
//  BasicAppDelegate.h
//  Basic
//
//  Created by Stefan Arentz on 10-09-09.
//  Copyright Arentz Consulting 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BasicViewController;

@interface BasicAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    BasicViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet BasicViewController *viewController;

@end

