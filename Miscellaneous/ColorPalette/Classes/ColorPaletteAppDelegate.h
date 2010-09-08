//
//  ColorPaletteAppDelegate.h
//  ColorPalette
//
//  Created by Stefan Arentz on 10-09-08.
//  Copyright Arentz Consulting 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ColorPaletteViewController;

@interface ColorPaletteAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ColorPaletteViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ColorPaletteViewController *viewController;

@end

