//
//  JKLoogerConsoleModule.h
//  Pods
//
//  Created by Jackie CHEUNG on 14-9-5.
//
//

#import <Foundation/Foundation.h>
#import <CocoaLumberjack/CocoaLumberjack.h>
#import <JKLogDispatcher/JKLogDispatcher.h>

@interface JKConsoleLoggerModule : NSObject <JKLoggerModule>

+ (instancetype)sharedModule;

/**
 logLevel: Choose one of level from DDLog.h, forinstance LOG_LEVEL_DEBUG
 */
+ (void)setConsoleLogLevel:(int)logLevel;

/** 
    Default support [VERBOSE],[INFO],[ERROR],[WARNING] and [DEBUG] 
    Flag: Choose one of flag from DDLog.h, forinstance LOG_FLAG_VERBOSE
 */
- (void)registerLogPrefix:(NSString *)prefix forLoggingFlag:(int)flag;

- (void)unregisterLogPrefix:(NSString *)prefix;

@end
