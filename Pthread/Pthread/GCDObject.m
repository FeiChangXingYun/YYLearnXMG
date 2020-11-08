//
//  GCDObject.m
//  Pthread
//
//  Created by Yanyan Jiang on 2020/7/27.
//  Copyright © 2020 Yanyan Jiang. All rights reserved.
//

#import "GCDObject.h"

@interface GCDObject ()
@property(nonatomic, assign) NSInteger totalCount;
@property(nonatomic, strong) NSString *lock;

@end


@implementation GCDObject
- (void)delay{
    NSLog(@"--delay--");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)2*NSEC_PER_SEC), dispatch_get_global_queue(0, 0), ^{
        NSLog(@"--------GCD-------%@",[NSThread currentThread]);
    });
}

- (void)once{
    static dispatch_once_t onceToken;
    NSLog(@"++++++%zd",onceToken);
    //内部实现原理:判断onceToken的值 == 0 来决定是否执行block中的任务
    dispatch_once(&onceToken, ^{
        NSLog(@"----------");
    });
}

- (void)GCD{
        //[self asyncMain];
        //[NSThread detachNewThreadSelector:@selector(syncMain) toTarget:self withObject:nil];
        //[self performSelectorInBackground:@selector(syncMain) withObject:nil];
        dispatch_queue_t queue = dispatch_queue_create("ILoveJackVeryMuch", DISPATCH_QUEUE_CONCURRENT);
        dispatch_async(queue, ^{
            NSURL *url = [NSURL URLWithString:@"http://llyc.oss-cn-beijing.aliyuncs.com/upload/jfnaW_1587614206886.jpg"];
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *image =  [UIImage imageWithData:data];
            //[self performSelectorOnMainThread:@selector(shadowImage:) withObject:image waitUntilDone:YES];
            //[self performSelector:@selector(shadowImage:) onThread:[NSThread mainThread] withObject:image waitUntilDone:NO];
            [self.imageV performSelector:@selector(setImage:) onThread:[NSThread mainThread]  withObject:image waitUntilDone:NO];
    //        dispatch_async(dispatch_get_main_queue(), ^{
    //            self.imageV.image = image;
    //        });
        });

}


//异步+并发队列 会开启多条子线程，所有的任务并发执行
//开几条线程并不是由任务的数量决定的，是由GCD内部自动决定的
- (void)asyncConcurrent{
    dispatch_queue_t queue = dispatch_queue_create("ILoveJackVeryMuch", DISPATCH_QUEUE_CONCURRENT);
    //dispatch_queue_t queue = dispatch_get_global_queue(0, 0);

    NSLog(@"-------start---------------");
    dispatch_async(queue, ^{
        NSLog(@"1-------%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"2-------%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"3-------%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"4-------%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"5-------%@",[NSThread currentThread]);
    });
    NSLog(@"-------END---------------");
}

//开启一条子线程，所有的任务都会在该子线程中一个接着一个执行
- (void)asyncSerial{
    dispatch_queue_t queue = dispatch_queue_create("ILoveJackVeryMuch", DISPATCH_QUEUE_SERIAL);
    NSLog(@"-------start---------------");
    dispatch_async(queue, ^{
        NSLog(@"1-------%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"2-------%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"3-------%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"4-------%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"5-------%@",[NSThread currentThread]);
    });
    NSLog(@"-------END---------------");
}


//同步+并发 不会开启子线程，所有的任务都在当前线程中执行任务，一个接一个的执行
- (void)syncConcurrent{
    dispatch_queue_t queue = dispatch_queue_create("ILoveJackVeryMuch", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"-------start---------------");
    dispatch_sync(queue, ^{
        NSLog(@"1-------%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"2-------%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"3-------%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"4-------%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"5-------%@",[NSThread currentThread]);
    });
    NSLog(@"-------END---------------");
}

//同步+串行，不会开启子线程，所有的任务都在当前线程中执行任务
- (void)syncSerial{
    dispatch_queue_t queue = dispatch_queue_create("ILoveJackVeryMuch", DISPATCH_QUEUE_SERIAL);
    NSLog(@"-------start---------------");
    dispatch_sync(queue, ^{
        NSLog(@"1-------%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"2-------%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"3-------%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"4-------%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"5-------%@",[NSThread currentThread]);
    });
    NSLog(@"-------END---------------");
}

- (void)asyncMain{
    dispatch_queue_t queue = dispatch_get_main_queue();
    NSLog(@"-------start---------------");
    dispatch_async(queue, ^{
        NSLog(@"1-------%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"2-------%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"3-------%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"4-------%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"5-------%@",[NSThread currentThread]);
    });
    NSLog(@"-------END---------------");
}

- (void)syncMain{
    dispatch_queue_t queue = dispatch_get_main_queue();
    NSLog(@"-------start---------------");
    dispatch_sync(queue, ^{
        NSLog(@"1-------%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"2-------%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"3-------%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"4-------%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"5-------%@",[NSThread currentThread]);
    });
    NSLog(@"-------END---------------");
}

//下载图片
- (void)download{
    NSURL *url = [NSURL URLWithString:@"http://llyc.oss-cn-beijing.aliyuncs.com/upload/jfnaW_1587614206886.jpg"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image =  [UIImage imageWithData:data];
    //[self performSelectorOnMainThread:@selector(shadowImage:) withObject:image waitUntilDone:YES];
    [self performSelector:@selector(shadowImage:) onThread:[NSThread mainThread] withObject:image waitUntilDone:YES];
    //[self.imageV performSelector:@selector(setImage:) onThread:[NSThread mainThread] withObject:image waitUntilDone:YES];
    NSLog(@"__________end_________");
}

- (void)shadowImage:(UIImage*)image{
    for (int i=0; i<20; i++) {
        NSLog(@"这是第几次%d",i);
    }
    self.imageV.image = image;
}

- (void)timer{//下载图片
    NSURL *url = [NSURL URLWithString:@"http://llyc.oss-cn-beijing.aliyuncs.com/upload/jfnaW_1587614206886.jpg"];
    CFTimeInterval start = CFAbsoluteTimeGetCurrent();
    NSData *data = [NSData dataWithContentsOfURL:url];
    CFTimeInterval end = CFAbsoluteTimeGetCurrent();
    NSLog(@"%f",end-start);
//    NSDate *start = [NSDate date];
//    NSDate *end = [NSDate date];
//    NSLog(@"%f",[end timeIntervalSinceDate:start]);
    UIImage *image =  [UIImage imageWithData:data];
    self.imageV.image = image;
}

- (void)threadA{
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(run:) object:@"ILoveJack"];
    thread.name = @"ILoveJack";
    [thread start];
}

- (void)threadB{
    [NSThread detachNewThreadSelector:@selector(run:) toTarget:self withObject:@"ILoveJackTwo"];
}

- (void)threadC{
    [self performSelectorInBackground:@selector(run:) withObject:@"ILoveYouJackThree"];
}

- (void)threadD{
    self.totalCount = 30;
    self.lock = [[NSString alloc] init];
    YYThread *threadA = [[YYThread alloc] initWithTarget:self selector:@selector(saleTicket) object:@"ILoveJackA"];
    YYThread *threadB = [[YYThread alloc] initWithTarget:self selector:@selector(saleTicket) object:@"ILoveJackB"];
    YYThread *threadC = [[YYThread alloc] initWithTarget:self selector:@selector(saleTicket) object:@"ILoveJackC"]; 
    threadA.name = @"ILoveJackA";
    threadB.name = @"ILoveJackB";
    threadC.name = @"ILoveJackC";
    [threadA start];
    [threadB start];
    [threadC start];
}

- (void)run:(NSString*)str{
    NSLog(@"%@",[NSDate distantFuture]);
    for (int i=0; i<100; i++) {
        NSLog(@"%d,%@",i,[NSThread currentThread].name);
    }
}

- (void)saleTicket{//卖票
    while (1) {
        NSInteger count = self.totalCount;
        if (count>0) {
            self.totalCount = count-1;
            NSLog(@"%@----还剩:%ld",[NSThread currentThread],self.totalCount);
        }else{
            NSLog(@"%@已经把票卖完了，还剩%ld",[NSThread currentThread],self.totalCount);
            break;
        }
    }
}


@end
