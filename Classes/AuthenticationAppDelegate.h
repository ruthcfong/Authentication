//
//  AuthenticationAppDelegate.h
//  Authentication
//
//  Created by Ruth Fong on 12/21/11.
//  Copyright 2011 Harvard College. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AuthenticationViewController;

@interface AuthenticationAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    AuthenticationViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet AuthenticationViewController *viewController;

@end

