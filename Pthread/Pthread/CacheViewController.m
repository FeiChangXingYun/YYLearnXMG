//
//  CacheViewController.m
//  Pthread
//
//  Created by Yanyan Jiang on 2020/8/5.
//  Copyright © 2020 Yanyan Jiang. All rights reserved.
//

#import "CacheViewController.h"

@interface CacheViewController ()<NSCacheDelegate>
@property(nonatomic, strong) NSCache *cache;
@property(nonatomic, strong) dispatch_source_t timer;
@end

@implementation CacheViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self runloopObserver];
    //[self dispatchTimer];
    //[self performSelectorInBackground:@selector(timer2) withObject:nil];
}

- (NSCache *)cache{
    if (_cache == nil) {
        _cache = [[NSCache alloc] init];
        _cache.countLimit = 7;
        _cache.totalCostLimit = 10;
        _cache.delegate = self;
    }
    return _cache;
}

- (IBAction)saveBtnClick:(id)sender {
    for (int i=0; i<10; i++) {
        NSData *data = [NSData dataWithContentsOfFile:@"/Users/yanyanjiang/Desktop/jackandrose.png"];
        //[self.cache setObject:data forKey:@(i)];
        [self.cache setObject:data forKey:@(i) cost:2];
        NSLog(@"存数据----%d-----%@",i,data);
    }
    NSLog(@"++++++++++");
}

- (IBAction)checkBtnClick:(id)sender {
    for (int i=0; i<10; i++) {
        NSData *data = (NSData *)[self.cache objectForKey:@(i)];
        if (data) {
            NSLog(@"取数据----%d",i);
        }
    }
    NSLog(@"-------------");
}

#pragma mark --NSCacheDelegate
- (void)cache:(NSCache *)cache willEvictObject:(id)obj{
    NSLog(@"------内部开启回收过程-----%@",obj);
}

- (void)runLoop{
    NSRunLoop *mainRunLoop = [NSRunLoop mainRunLoop];
    NSRunLoop *currentRunLoop = [NSRunLoop currentRunLoop];
    NSLog(@"%p-----%p",mainRunLoop,currentRunLoop);

    
    CFRunLoopRef mainRunLoopRef = CFRunLoopGetMain();
    CFRunLoopRef currentRunLoopRef = CFRunLoopGetCurrent();
    NSLog(@"%p-----%p",mainRunLoopRef,currentRunLoopRef);
    
    NSLog(@"%p-----%p",mainRunLoop.getCFRunLoop,currentRunLoop.getCFRunLoop);

    [NSThread detachNewThreadSelector:@selector(run) toTarget:self withObject:nil];
}

- (void)run{
    NSLog(@"----%@",[NSThread currentThread]);
    NSRunLoop *newThreadRunLoop = [NSRunLoop currentRunLoop];
    NSLog(@"%@-----",newThreadRunLoop);
    [newThreadRunLoop run];
}


- (void)timer1{
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(runTimer) userInfo:nil repeats:YES];
    //[[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    //[[NSRunLoop currentRunLoop] addTimer:timer forMode:UITrackingRunLoopMode];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    NSLog(@"%@-----",[NSRunLoop currentRunLoop]);
}


- (void)timer2{
    NSLog(@"---%@",[NSThread currentThread]);
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(runTimer) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] run];
//    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
//    [runloop addTimer:timer forMode:NSDefaultRunLoopMode];
//    [runloop run];
}


- (void)runTimer{
    NSLog(@"---%@",[NSRunLoop currentRunLoop].currentMode);
}


- (void)dispatchTimer{
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 2.0*NSEC_PER_SEC, 0*NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        NSLog(@"GCD-----%@",[NSThread currentThread]);
    });
    dispatch_resume(timer);
    self.timer = timer;
}


- (void)runloopObserver{
    //创建观察者对象
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
//        kCFRunLoopEntry = (1UL << 0),
//        kCFRunLoopBeforeTimers = (1UL << 1),
//        kCFRunLoopBeforeSources = (1UL << 2),
//        kCFRunLoopBeforeWaiting = (1UL << 5),
//        kCFRunLoopAfterWaiting = (1UL << 6),
//        kCFRunLoopExit = (1UL << 7),
        switch (activity) {
            case kCFRunLoopEntry:
                NSLog(@"runloop进入");
                break;
            case kCFRunLoopBeforeTimers:
                NSLog(@"即将处理timer事件");
                break;
            case kCFRunLoopBeforeSources:
                NSLog(@"即将处理source事件");
                break;
            case kCFRunLoopBeforeWaiting:
                NSLog(@"即将进入休眠");
                break;
            case kCFRunLoopAfterWaiting:
                NSLog(@"被唤醒");
                break;
            case kCFRunLoopExit:
                NSLog(@"runloop退出");
                break;

            default:
                break;
        }
    });
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(runTimerObsever) userInfo:nil repeats:YES];
}

- (void)runTimerObsever{
    NSLog(@"runTimerObserver");
}

@end
