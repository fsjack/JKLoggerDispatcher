//
//  JKConsoleLogFormatter.m
//  Pods
//
//  Created by Jackie CHEUNG on 14-9-6.
//
//

#import "JKConsoleLogFormatter.h"

@implementation JKConsoleLogFormatter

- (NSString*)formatLogMessage:(DDLogMessage *)logMessage {
    
    static NSString *_applicationIdentifier = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _applicationIdentifier = [[NSBundle mainBundle] infoDictionary][(NSString *)kCFBundleNameKey];
    });
    
    return [NSString stringWithFormat:@"%@ %@[%x][%@:%d] %@",
            [self stringFromDate:logMessage->timestamp],
            _applicationIdentifier,
            logMessage->machThreadID,
            @(logMessage->file).lastPathComponent,
            logMessage->lineNumber,
            logMessage->logMsg];
}


@end
