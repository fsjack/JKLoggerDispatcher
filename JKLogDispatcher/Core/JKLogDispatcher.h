//
//  JKLogDispatcher.h
//  Pods
//
//  Created by Jackie CHEUNG on 14-9-5.
//
//

#import <Foundation/Foundation.h>

#define NSLog(s, ... ) [JKLogDispatcher logWithFileName:[[NSString stringWithUTF8String:__FILE__] lastPathComponent] method: [NSString stringWithUTF8String:__PRETTY_FUNCTION__] line:__LINE__ text:s, ##__VA_ARGS__]

@class JKLogDispatcher;
@protocol JKLoggerModule <NSObject>

- (BOOL)dispatcher:(JKLogDispatcher *)dispatcher canModuleProcessLogWithFileName:(NSString *)fileName method:(NSString *)method line:(int)line text:(NSString *)format arguments:(va_list)arguments;

@optional

- (BOOL)moduleShouldAddToDispatcher:(JKLogDispatcher *)dispatcher;

- (void)moduleDidAddToDispatcher:(JKLogDispatcher *)dispatcher;

@end


@interface JKLogDispatcher : NSObject

+ (instancetype)defaultDispatcher;

+ (void)logWithFileName:(NSString*)fileName method:(NSString*)method line:(int)line text:(NSString *)format, ...;

- (void)registerLoggerModule:(id<JKLoggerModule>)module;

@end
