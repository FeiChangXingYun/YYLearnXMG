//
//  YYTool.h
//  Pthread
//
//  Created by Yanyan Jiang on 2020/7/30.
//  Copyright © 2020 Yanyan Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYTool : NSObject<NSCopying,NSMutableCopying>
+ (instancetype)shareTool;
@end

NS_ASSUME_NONNULL_END
