//
//  AppDelegate.m
//  JKLogDispatcherDemo
//
//  Created by Jackie CHEUNG on 14-10-7.
//  Copyright (c) 2014年 Jackie. All rights reserved.
//

#import "AppDelegate.h"
#import "JKLoggerDispatcher.h"
#import "JKConsoleLoggerModule.h"
#import "JKConsoleLogFormatter.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[JKLoggerDispatcher defaultDispatcher] registerLoggerModule:[JKConsoleLoggerModule sharedModule]];
//    [[DDTTYLogger sharedInstance] setLogFormatter:[[JKConsoleLogFormatter alloc] init]];
    
#ifdef DEBUG
    [JKConsoleLoggerModule setConsoleLogLevel:LOG_FLAG_ERROR|LOG_FLAG_WARN|LOG_FLAG_INFO|LOG_FLAG_VERBOSE|LOG_FLAG_DEBUG];
#else
    [JKConsoleLoggerModule setConsoleLogLevel:LOG_FLAG_ERROR|LOG_FLAG_WARN|LOG_FLAG_INFO];
#endif
    
    NSLog(@"[ERROR] This is an error.");
    NSLog(@"[WARNING] This is a warning.");
    NSLog(@"[DEBUG] This is a debug.");
    NSLog(@"[VERBOSE] This is a verbose.");
    NSLog(@"[INFO] This is a info.");
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
