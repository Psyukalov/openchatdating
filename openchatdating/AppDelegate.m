//
//  AppDelegate.m
//  openchatdating
//
//  Created by Vladimir Psyukalov on 28.06.2018.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "AppDelegate.h"

#import "Macros.h"


@interface AppDelegate ()

@end


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self configureWithCompletion:^(UIWindow *window) {
        
    }];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    //
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    //
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    //
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    //
}


- (void)applicationWillTerminate:(UIApplication *)application {
    //
}

#pragma mark - Other methods

- (void)configureWithCompletion:(void (^)(UIWindow *window))completion {
    self.window = [UIWindow new];
    self.window.frame = [UIScreen mainScreen].bounds;
    if (completion) {
        completion(self.window);
    }
    [self.window makeKeyAndVisible];
}

@end
