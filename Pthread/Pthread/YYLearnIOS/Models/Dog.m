//
//  Dog.m
//  YYLearnIOS
//
//  Created by Yanyan Jiang on 2020/7/15.
//  Copyright © 2020 YanYanJiang. All rights reserved.
//

#import "Dog.h"

@interface Dog ()
@end

@implementation Dog
- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super init];
    if (self) {
        self.name = [coder decodeObjectForKey:@"name"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder{
    [coder encodeObject:self.name forKey:@"name"];
}

+ (BOOL)supportsSecureCoding{
    return YES;
}
@end
