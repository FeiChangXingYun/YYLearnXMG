//
//  Dog.h
//  YYLearnIOS
//
//  Created by Yanyan Jiang on 2020/7/15.
//  Copyright © 2020 YanYanJiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Dog : NSObject<NSSecureCoding>
@property(nonatomic, copy) NSString *name;

@end

NS_ASSUME_NONNULL_END
