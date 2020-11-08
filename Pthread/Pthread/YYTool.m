//
//  YYTool.m
//  Pthread
//
//  Created by Yanyan Jiang on 2020/7/30.
//  Copyright © 2020 Yanyan Jiang. All rights reserved.
//

#import "YYTool.h"

@interface YYTool ()
@end


@implementation YYTool

static YYTool *_tool;
+(instancetype)allocWithZone:(struct _NSZone *)zone{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        if (_tool == nil) {
//            _tool = [super allocWithZone:zone];
//        }
//    });
//    return _tool;
    
    @synchronized (self) {
        if (_tool == nil) {
            _tool = [super allocWithZone:zone];
        }
        return _tool;
    }
}

+(instancetype)shareTool{
    return [[self alloc] init];
}

- (id)mutableCopyWithZone:(NSZone *)zone{
    return _tool;
}

- (id)copyWithZone:(NSZone *)zone{
    return _tool;
}

@end
