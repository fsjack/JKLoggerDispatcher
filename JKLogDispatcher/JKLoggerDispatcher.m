//
//  JKLoggerDispatcher.m
//  Pods
//
//  Created by Jackie CHEUNG on 14-9-5.
//
//

#import "JKLoggerDispatcher.h"

@interface JKLoggerDispatcher ()
@property (nonatomic, copy) NSArray *registeredLoggerModules;
@end

@implementation JKLoggerDispatcher

+ (instancetype)defaultDispatcher {
    static JKLoggerDispatcher *_defaultDispatcher = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _defaultDispatcher = [[JKLoggerDispatcher alloc] init];
    });
    return _defaultDispatcher;
}

+ (void)logWithFileName:(NSString*)fileName method:(NSString*)method line:(int)line text:(NSString *)format, ... {
    va_list arg_ptr;
    va_start(arg_ptr, format);
    
    if([JKLoggerDispatcher defaultDispatcher].registeredLoggerModules.count) {
        for (id<JKLoggerModule>module in [JKLoggerDispatcher defaultDispatcher].registeredLoggerModules) {
            if([module dispatcher:[JKLoggerDispatcher defaultDispatcher] canModuleProcessLogWithFileName:fileName method:method line:line text:format arguments:arg_ptr]) break;
        }
    } else {
        NSLogv(format, arg_ptr);
    }
}

- (void)registerLoggerModule:(id<JKLoggerModule>)module {
    if(![self.registeredLoggerModules containsObject:module]) {
        BOOL shouldAddToDispatcher = YES;
        if([module respondsToSelector:@selector(moduleShouldAddToDispatcher:)])
            shouldAddToDispatcher = [module moduleShouldAddToDispatcher:self];
        
        if(shouldAddToDispatcher) {
            self.registeredLoggerModules = [[NSArray arrayWithArray:self.registeredLoggerModules] arrayByAddingObject:module];
            
            if([module respondsToSelector:@selector(moduleDidAddToDispatcher:)])
                [module moduleDidAddToDispatcher:self];
        }
        
    }
}

@end
