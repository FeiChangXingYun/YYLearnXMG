//
//  YYPerson.m
//  Pthread
//
//  Created by Yanyan Jiang on 2020/11/28.
//  Copyright © 2020 Yanyan Jiang. All rights reserved.
//

#import "YYPerson.h"

@implementation YYPerson

//- (int )getAge{
//    return 11;
//}

//- (int )age{
//    return 12;
//}

//- (int)isAge{
//    return 13;
//}

//- (int )_age{
//    return 14;
//}


//- (void)setAge:(int)age{
//    NSLog(@"setAge: %d",age);
//}

//- (void)_setAge:(int)age{
//    NSLog(@"_setAge: %d",age);
//}


//- (void)willChangeValueForKey:(NSString *)key{
//    [super willChangeValueForKey:key];
//    NSLog(@"willChangeValueForKey");
//}
//
//- (void)didChangeValueForKey:(NSString *)key{
//    NSLog(@"didChangeValueForKey -begin");
//    [super didChangeValueForKey:key];
//    NSLog(@"didChangeValueForKey -end");
//
//}

+ (BOOL)accessInstanceVariablesDirectly{
    return YES;
}

@end 
