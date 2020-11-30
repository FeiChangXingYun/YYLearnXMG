//
//  Person.m
//  YYLearnIOS
//
//  Created by temp on 2020/7/15.
//  Copyright © 2020 YanYanJiang. All rights reserved.
//

#import "Person.h"

@implementation Person
//当执行NSKeyedUnarchiver,会自动调用保存对象的initWithCoder方法
//调用initWithCoder该方法目的是告诉它读取该对象的哪些属性
- (instancetype)initWithCoder:(NSCoder *)coder{
#warning  -为什么没有 [super initWithCoder]
    //因为父类没有遵守NSSecureCoding协议
    if (self == [super init]) {
        self.name = [coder decodeObjectForKey:@"name"];
        self.age = [coder decodeIntegerForKey:@"age"];
//        self.dog = [coder decodeObjectForKey:@"dog"];//用这个不成功
        self.dog = [coder decodeObjectOfClass:[Dog class] forKey:@"dog"];
    }
    return self;
}

//想要写出encodeWithCoder:必须得要遵守一个协议<NSCoding>
//NSKeyedArchiver 归档时会调用该方法
//调用encodeWithCoder:该方法目的是告诉它保存该对象的哪些属性
- (void)encodeWithCoder:(NSCoder *)coder{
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeInteger:self.age forKey:@"age"];
    [coder encodeObject:self.dog forKey:@"dog"];
}

+ (BOOL)supportsSecureCoding{
    return YES;
}
@end
