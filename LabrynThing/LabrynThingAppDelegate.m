//
//  LabrynThingAppDelegate.m
//  LabrynThing
//
//  Created by Stephanie Shupe on 9/3/12.
//  Copyright (c) 2012 burnOffBabes. All rights reserved.
//

#import "LabrynThingAppDelegate.h"

#import "StartScreenViewController.h"

@implementation LabrynThingAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    StartScreenViewController* startVC = [StartScreenViewController new];
    self.window.rootViewController = startVC;
    [application setStatusBarHidden:YES];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
