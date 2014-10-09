//
//  JKLoogerConsoleModule.m
//  Pods
//
//  Created by Jackie CHEUNG on 14-9-5.
//
//

#import "JKConsoleLoggerModule.h"

static int _JKConsoleLogLevel = LOG_LEVEL_ALL;

@interface JKConsoleLoggerModule ()
@property (nonatomic, copy) NSDictionary *internalStorage;
@end

@implementation JKConsoleLoggerModule

+ (instancetype)sharedModule {
    static JKConsoleLoggerModule *_sharedModule = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedModule = [[JKConsoleLoggerModule alloc] init];
    });
    return _sharedModule;
}

+ (void)setConsoleLogLevel:(int)logLevel {
    _JKConsoleLogLevel = logLevel;
}

- (BOOL)dispatcher:(JKLoggerDispatcher *)dispatcher canModuleProcessLogWithFileName:(NSString *)fileName method:(NSString *)method line:(int)line text:(NSString *)format arguments:(va_list)arguments {
    
    int logFlag = LOG_FLAG_INFO;
    for (NSString *logPrefixString in self.internalStorage) {
        if([format hasPrefix:logPrefixString]) logFlag = [self.internalStorage[logPrefixString] intValue];
    }
    
    if(_JKConsoleLogLevel & logFlag) {
        BOOL shouldAsynchronous = (logFlag == LOG_FLAG_ERROR ? NO : YES);
        
        NSString *logMsg = [[NSString alloc] initWithFormat:format arguments:arguments];
        DDLogMessage *logMessage = [[DDLogMessage alloc] initWithLogMsg:logMsg
                                                                  level:_JKConsoleLogLevel
                                                                   flag:logFlag
                                                                context:0
                                                                   file:[fileName UTF8String]
                                                               function:[method UTF8String]
                                                                   line:line
                                                                    tag:nil
                                                                options:DDLogMessageCopyFile|DDLogMessageCopyFunction];
        
        [DDLog log:shouldAsynchronous message:logMessage];
    }

    return NO;
}

- (void)moduleDidAddToDispatcher:(JKLoggerDispatcher *)dispatcher {
    
#ifdef DEBUG
    setenv("XcodeColors", "YES", 0);
    [DDTTYLogger sharedInstance].colorsEnabled = YES;
    
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor clearColor] backgroundColor:[UIColor redColor] forFlag:LOG_FLAG_ERROR];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor clearColor] backgroundColor:[UIColor yellowColor] forFlag:LOG_FLAG_WARN];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor greenColor] backgroundColor:[UIColor clearColor] forFlag:LOG_FLAG_DEBUG];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor darkGrayColor] backgroundColor:[UIColor clearColor] forFlag:LOG_FLAG_VERBOSE];
#endif
    
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    
    [self registerLogPrefix:@"[VERBOSE]" forLoggingFlag:LOG_FLAG_VERBOSE];
    [self registerLogPrefix:@"[DEBUG]" forLoggingFlag:LOG_FLAG_DEBUG];
    [self registerLogPrefix:@"[INFO]" forLoggingFlag:LOG_FLAG_INFO];
    [self registerLogPrefix:@"[WARNING]" forLoggingFlag:LOG_FLAG_WARN];
    [self registerLogPrefix:@"[ERROR]" forLoggingFlag:LOG_FLAG_ERROR];
}

- (void)registerLogPrefix:(NSString *)prefix forLoggingFlag:(int)flag {
    NSMutableDictionary *internalStorage = [NSMutableDictionary dictionaryWithDictionary:self.internalStorage];
    internalStorage[prefix] = @(flag);
    self.internalStorage = internalStorage;
}

- (void)unregisterLogPrefix:(NSString *)prefix {
    NSMutableDictionary *internalStorage = [self.internalStorage mutableCopy];
    [internalStorage removeObjectForKey:prefix];
    self.internalStorage = internalStorage;
}

@end
