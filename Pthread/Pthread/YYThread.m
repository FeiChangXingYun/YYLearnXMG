//
//  YYThread.m
//  Pthread
//
//  Created by Yanyan Jiang on 2020/7/25.
//  Copyright © 2020 Yanyan Jiang. All rights reserved.
//

#import "YYThread.h"

@implementation YYThread


- (void)main{
    NSLog(@"Main------%@",[NSThread currentThread]);
}

- (void)dealloc{
    NSLog(@"该对象被释放了-------%@",[NSThread currentThread]);
}
@end
