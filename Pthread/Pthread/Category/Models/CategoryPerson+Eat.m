//
//  CategoryPerson+Eat.m
//  Pthread
//
//  Created by Yanyan Jiang on 2020/12/1.
//  Copyright © 2020 Yanyan Jiang. All rights reserved.
//

#import "CategoryPerson+Eat.h"

@implementation CategoryPerson (Eat)

- (void)eat{
    NSLog(@"eat");
}

+ (void)eat2{
    NSLog(@"eat2");
}

- (void)run{
    NSLog(@"run (Eat)");
}

+ (void)load{
    NSLog(@"CategoryPerson Eat  +load");
}

+ (void)initialize{
    NSLog(@"CategoryPerson Eat  +initialize");
}

@end
