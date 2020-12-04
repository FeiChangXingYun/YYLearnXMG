//
//  CategoryPerson.m
//  Pthread
//
//  Created by Yanyan Jiang on 2020/12/1.
//  Copyright © 2020 Yanyan Jiang. All rights reserved.
//

#import "CategoryPerson.h"

@implementation CategoryPerson

- (void)run{
    NSLog(@"run");
}

+ (void)run2{
    NSLog(@"run2");
}

+ (void)load{
    NSLog(@"CategoryPerson  +load");
}

+ (void)initialize{
    NSLog(@"CategoryPerson  +initialize");
}

@end
