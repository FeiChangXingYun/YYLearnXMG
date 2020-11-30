//
//  Person.h
//  YYLearnIOS
//
//  Created by temp on 2020/7/15.
//  Copyright © 2020 YanYanJiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dog.h"

NS_ASSUME_NONNULL_BEGIN
@interface Person : NSObject<NSSecureCoding>
//遵守协议的目的是可以写出.m中的两个方法

@property(nonatomic, copy) NSString *name;
@property(nonatomic, assign) NSInteger age;
@property(nonatomic, strong) Dog *dog; 
@end

NS_ASSUME_NONNULL_END
