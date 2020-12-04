//
//  CategoryPerson+Test.m
//  Pthread
//
//  Created by Yanyan Jiang on 2020/12/1.
//  Copyright © 2020 Yanyan Jiang. All rights reserved.
//

#import "CategoryPerson+Test.h"

@implementation CategoryPerson (Test)
- (void)test{
    NSLog(@"test");
}

+ (void)test2{
    NSLog(@"test2");
}

- (void)run{ 
    NSLog(@"run (Test)");
}

+ (void)load{
    NSLog(@"CategoryPerson Test  +load");
}

+ (void)initialize{
    NSLog(@"CategoryPerson Test  +initialize");
}

@end
