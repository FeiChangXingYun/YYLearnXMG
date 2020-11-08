//
//  YanYanOperation.m
//  Pthread
//
//  Created by Yanyan Jiang on 2020/8/2.
//  Copyright © 2020 Yanyan Jiang. All rights reserved.
//

#import "YanYanOperation.h"

@implementation YanYanOperation

- (void)main{
    for (int i=0; i<5000; i++) {
        NSLog(@"1---%d---%@",i,[NSThread currentThread]);
    }
    NSLog(@"++++++++++++++++");
    if (self.isCancelled) {
        return;
    }
    for (int i=0; i<5000; i++) {
        NSLog(@"2---%d---%@",i,[NSThread currentThread]);
    }
    NSLog(@"++++++++++++++++");
    if (self.isCancelled) {
        return;
    }

    for (int i=0; i<5000; i++) {
        NSLog(@"3---%d---%@",i,[NSThread currentThread]);
    }
    NSLog(@"++++++++++++++++");
    if (self.isCancelled) {
        return;
    }

    for (int i=0; i<5000; i++) {
        NSLog(@"4---%d---%@",i,[NSThread currentThread]);
    }
    NSLog(@"++++++++++++++++");
    if (self.isCancelled) {
        return;
    }
}


@end
