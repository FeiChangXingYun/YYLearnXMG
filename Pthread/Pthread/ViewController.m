//
//  ViewController.m
//  Pthread
//
//  Created by Yanyan Jiang on 2020/7/25.
//  Copyright © 2020 Yanyan Jiang. All rights reserved.
//

#import "ViewController.h"
#import <pthread.h>
#import "YYThread.h"
#import "YYTool.h"
#import "YanYanOperation.h"

@interface ViewController ()
@property(nonatomic, assign) NSInteger totalCount;
@property(nonatomic, strong) NSString *lock;
@property(nonatomic, strong) UIImage *image1;
@property(nonatomic, strong) UIImage *image2;
@property(nonatomic, strong) NSOperationQueue *queue;
@end

@implementation ViewController

- (IBAction)ILoveYouJack:(id)sender {
    [self operationDownload];
    
    
}


- (IBAction)startBtnClick:(id)sender {//开始
    [self customOperation];
}

- (IBAction)suspendBtnClick:(id)sender {//暂停
    [self.queue setSuspended:YES];
}

- (IBAction)resumeBtnClick:(id)sender {//恢复
    [self.queue setSuspended:NO];
}

- (IBAction)cancelBtnClick:(id)sender {//取消
    //只能取消正在等待处理的操作，已经在处理中的操作取消不了
    [self.queue cancelAllOperations];
}












- (void)operationDownload{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSBlockOperation *oper = [NSBlockOperation blockOperationWithBlock:^{
        NSURL *url = [NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1595958132630&di=f500fe50cdb0a11a49e06d47070a1733&imgtype=0&src=http%3A%2F%2Fimg1.gtimg.com%2Frushidao%2Fpics%2Fhv1%2F20%2F108%2F1744%2F113431160.jpg"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.imageV.image = image;
        }];
    }];
    //[oper addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionNew context:nil];
    [oper addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@"ILoveYouJack"];
    [queue addOperation:oper];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"#####%@",context);
}

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
//    NSLog(@"#####");
//}


- (void)dependency{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSOperationQueue *queue2 = [[NSOperationQueue alloc] init];

    NSBlockOperation *oper1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"1------%@",[NSThread currentThread]);
    }];
    NSBlockOperation *oper2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"2------%@",[NSThread currentThread]);
    }];
    NSBlockOperation *oper3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"3------%@",[NSThread currentThread]);
    }];
    NSBlockOperation *oper4 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"4------%@",[NSThread currentThread]);
    }];
    NSBlockOperation *oper5 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"5------%@",[NSThread currentThread]);
    }];
    
    oper5.completionBlock = ^{
        NSLog(@"主人,你的电影已经下载好了,快点来看我吧");
    };
    
    //03 设置操作依赖:4->3->2->1->5
    //⚠️ 不能设置循环依赖,结果就是两个任务都不会执行
    [oper5 addDependency:oper1];
    [oper1 addDependency:oper2];
    [oper2 addDependency:oper3];
    [oper3 addDependency:oper4];

    [queue addOperation:oper1];
    [queue addOperation:oper2];
    [queue addOperation:oper3];
    [queue addOperation:oper4];
    [queue2 addOperation:oper5];
}


- (void)customThread{
    YYThread *thread = [[YYThread alloc] init];
    [thread start];
}

//自定义操作
- (void)customOperation{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    YanYanOperation *oper = [[YanYanOperation alloc] init];
    [queue addOperation:oper];
    self.queue = queue;
}


- (void)testSuspend{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSBlockOperation *oper1 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i=0; i<5000; i++) {
            NSLog(@"1---%d---%@",i,[NSThread currentThread]);
        }
    }];
    
    NSBlockOperation *oper2 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i=0; i<5000; i++) {
            NSLog(@"2----%d----%@",i,[NSThread currentThread]);
        }
    }];
    
    NSBlockOperation *oper3 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i=0; i<5000; i++) {
            NSLog(@"3---%d---%@",i,[NSThread currentThread]);
        }
    }];
    
    NSBlockOperation *oper4 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i=0; i<5000; i++) {
            NSLog(@"4---%d---%@",i,[NSThread currentThread]);
        }
    }];

    NSBlockOperation *oper5 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i=0; i<5000; i++) {
            NSLog(@"5---%d---%@",i,[NSThread currentThread]);
        }
    }];
    queue.maxConcurrentOperationCount = 1;
    [queue addOperation:oper1];
    [queue addOperation:oper2];
    [queue addOperation:oper3];
    [queue addOperation:oper4];
    [queue addOperation:oper5];
    self.queue = queue;
}


- (void)changeSerialQueue{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    NSBlockOperation *oper1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"1------%@",[NSThread currentThread]);
    }];
    
    NSBlockOperation *oper2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"2------%@",[NSThread currentThread]);
    }];
    
    NSBlockOperation *oper3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"3------%@",[NSThread currentThread]);
    }];
    
    NSBlockOperation *oper4 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"4------%@",[NSThread currentThread]);
    }];

    NSBlockOperation *oper5 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"5------%@",[NSThread currentThread]);
    }];
    
    [oper5 addExecutionBlock:^{
        NSLog(@"6------%@",[NSThread currentThread]);
    }];
    
    [oper5 addExecutionBlock:^{
        NSLog(@"7------%@",[NSThread currentThread]);
    }];
    
    [oper5 addExecutionBlock:^{
        NSLog(@"8------%@",[NSThread currentThread]);
    }];
    
    queue.maxConcurrentOperationCount = 2;
    [queue addOperation:oper1];
    [queue addOperation:oper2];
    [queue addOperation:oper3];
//    [queue addBarrierBlock:^{
//        NSLog(@"3.1------%@",[NSThread currentThread]);
//    }];
    [queue addOperation:oper4];
    [queue addOperation:oper5];
}


- (void)invocationOperationWithQueue{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSInvocationOperation *oper1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downLoad1:) object:@"1"];
    oper1.name = @"哈哈";
    oper1.queuePriority = NSOperationQueuePriorityVeryLow;
    NSInvocationOperation *oper2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downLoad1:) object:@"2"];
    oper2.name = @"呵呵";
    oper2.queuePriority = NSOperationQueuePriorityLow;
    NSInvocationOperation *oper3 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downLoad1:) object:@"3"];
    oper3.name = @"嘿嘿";
    oper3.queuePriority = NSOperationQueuePriorityVeryHigh;
    [queue addOperation:oper1];
    [queue addOperation:oper2];
    [queue addOperation:oper3];
    
    [queue addOperationWithBlock:^{
        NSLog(@"downLoad1-4----%@",[NSThread currentThread]);
    }];
}


- (void)blockOperationWithQueue{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSBlockOperation *oper1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"我要属于我1-----%@",[NSThread currentThread]);
    }];
    oper1.name = @"哈哈";
    NSBlockOperation *oper2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"我要属于我2-----%@",[NSThread currentThread]);
    }];
    oper2.name = @"呵呵";

    NSBlockOperation *oper3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"我要属于我3-----%@",[NSThread currentThread]);
    }];
    oper3.name = @"嘿嘿";
    [queue addOperation:oper1];
    [queue addOperation:oper2];
    [queue addOperation:oper3];
}


- (void)downLoad1:(NSString *)str{
    NSLog(@"downLoad1-%@----%@",str,[NSThread currentThread]);
}


- (void)blockOperation{
    //都在主线程中运行
    NSBlockOperation *oper1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"1----%@",[NSThread currentThread]);
    }];
    NSBlockOperation *oper2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"2----%@",[NSThread currentThread]);
    }];
    NSBlockOperation *oper3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"3----%@",[NSThread currentThread]);
    }];
    //都在分线程中运行
    [oper3 addExecutionBlock:^{
        NSLog(@"4----%@",[NSThread currentThread]);
    }];
    [oper3 addExecutionBlock:^{
        NSLog(@"5----%@",[NSThread currentThread]);
    }];
    [oper1 start];
    [oper2 start];
    [oper3 start];
}


- (void)invocationOperation{
    //都是在主线程中运行
    NSInvocationOperation *oper1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(operation1) object:nil];
    NSInvocationOperation *oper2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(operation1) object:nil];
    NSInvocationOperation *oper3 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(operation1) object:nil];
    [oper1 start];
    [oper2 start];
    [oper3 start];
}


- (void)operation1{
    NSLog(@"1-----%@",[NSThread currentThread]);
}

- (void)signleInstace{
    YYTool *tool1 = [[YYTool alloc] init];
    YYTool *tool2 = [[YYTool alloc] init];
    NSLog(@"--\n%@\n%@\n%@\n%@",tool1,tool2,[tool2 mutableCopy],[tool2 copy]);
}


- (void)apply{
    //在当前线程中串行执行
    for (int i=0; i<10; i++) {
        NSLog(@"-----%d-%@",i,[NSThread currentThread]);
    }
    //iterations 迭代的次数
    //dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_queue_t queue = dispatch_queue_create("ILoveYouJack", DISPATCH_QUEUE_SERIAL);
    dispatch_apply(10, queue, ^(size_t i) {
        NSLog(@"-----%zu-----%@",i,[NSThread currentThread]);
    });
}

- (void)test{
    NSString *fromPath = @"/Users/yanyanjiang/Desktop/from";
    NSString *toPath = @"/Users/yanyanjiang/Desktop/to";
    NSArray *picArr = [[NSFileManager defaultManager] subpathsAtPath:fromPath];
    for (int i=0; i<picArr.count; ++i) {
        NSString *fromeFullPath = [fromPath stringByAppendingPathComponent:picArr[i]];
        NSString *toFullPath = [toPath stringByAppendingPathComponent:picArr[i]];
        [[NSFileManager defaultManager] moveItemAtPath:fromeFullPath toPath:toFullPath error:nil];
        NSLog(@"---%@---%@---%@",fromeFullPath,toFullPath,[NSThread currentThread]);
    }
}

- (void)test1{
    NSString *fromPath = @"/Users/yanyanjiang/Desktop/from";
    NSString *toPath = @"/Users/yanyanjiang/Desktop/to";
    NSArray *picArr = [[NSFileManager defaultManager] subpathsAtPath:fromPath];
    dispatch_apply(picArr.count, dispatch_get_global_queue(0, 0), ^(size_t i) {
        NSString *fromeFullPath = [fromPath stringByAppendingPathComponent:picArr[i]];
        NSString *toFullPath = [toPath stringByAppendingPathComponent:picArr[i]];
        [[NSFileManager defaultManager] moveItemAtPath:fromeFullPath toPath:toFullPath error:nil];
        NSLog(@"---%@---%@---%@",fromeFullPath,toFullPath,[NSThread currentThread]);
    });
}

- (void)barrier
{
    dispatch_queue_t queue = dispatch_queue_create("ILoveJackVeryMuchButJackDoNotLoveME", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue2 = dispatch_queue_create("ILoveMyMother", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"1-----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"2-----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"3-----%@",[NSThread currentThread]);
    });
    dispatch_async(queue2, ^{
        NSLog(@"4-----%@",[NSThread currentThread]);
    });
    dispatch_async(queue2, ^{
        NSLog(@"5-----%@",[NSThread currentThread]);
    });
    dispatch_async(queue2, ^{
        NSLog(@"6-----%@",[NSThread currentThread]);
    });
    dispatch_barrier_async(queue, ^{
        NSLog(@"+++++++++++++++");
    });
    NSLog(@"---end----");
}


- (void)group
{
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("ILoveJackVeryMuchButJackDoNotLoveME", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue2 = dispatch_queue_create("ILoveMyMother", DISPATCH_QUEUE_CONCURRENT);
        
    dispatch_group_async(group, queue, ^{
        NSLog(@"1-----%@",[NSThread currentThread]);
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"2-----%@",[NSThread currentThread]);
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"3-----%@",[NSThread currentThread]);
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"4-----%@",[NSThread currentThread]);
    });
    dispatch_group_async(group, queue2, ^{
        NSLog(@"5-----%@",[NSThread currentThread]);
    });
    dispatch_group_async(group, queue2, ^{
        NSLog(@"6-----%@",[NSThread currentThread]);
    });
    
    dispatch_group_async_f(group, queue, "ILoveYouJack", lovelove);
    
    dispatch_group_notify(group, queue, ^{
        NSLog(@"++++++++%@",[NSThread currentThread]);
    });
    NSLog(@"---end----");
}

void lovelove(void *str){
    NSLog(@"ILoveYouJack");
}





- (void)group2
{
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("ILoveJackVeryMuchButJackDoNotLoveME", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue2 = dispatch_queue_create("ILoveMyMother", DISPATCH_QUEUE_CONCURRENT);
        
//    dispatch_group_async(group, queue, ^{
//        NSLog(@"1-----%@",[NSThread currentThread]);
//    });
//    dispatch_group_async(group, queue, ^{
//        NSLog(@"2-----%@",[NSThread currentThread]);
//    });
//    dispatch_group_async(group, queue, ^{
//        NSLog(@"3-----%@",[NSThread currentThread]);
//    });
//    dispatch_group_async(group, queue, ^{
//        NSLog(@"4-----%@",[NSThread currentThread]);
//    });
//    dispatch_group_async(group, queue2, ^{
//        NSLog(@"5-----%@",[NSThread currentThread]);
//    });
//    dispatch_group_async(group, queue2, ^{
//        NSLog(@"6-----%@",[NSThread currentThread]);
//    });
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        NSLog(@"1-----%@",[NSThread currentThread]);
        dispatch_group_leave(group);
    });
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        NSLog(@"2-----%@",[NSThread currentThread]);
        dispatch_group_leave(group);
    });
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        NSLog(@"3-----%@",[NSThread currentThread]);
        dispatch_group_leave(group);
    });

    dispatch_group_enter(group);
    dispatch_async(queue2, ^{
        NSLog(@"4-----%@",[NSThread currentThread]);
        dispatch_group_leave(group);
    });

    dispatch_group_enter(group);
    dispatch_async(queue2, ^{
        NSLog(@"5-----%@",[NSThread currentThread]);
        dispatch_group_leave(group);
    });

    dispatch_group_notify(group, queue, ^{
        NSLog(@"++++++++%@",[NSThread currentThread]);
    });
    NSLog(@"---end----");
}


//下载图片3
- (void)group3
{
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("Download", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_async(group, queue, ^{
        NSURL *url = [NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1595958132630&di=f500fe50cdb0a11a49e06d47070a1733&imgtype=0&src=http%3A%2F%2Fimg1.gtimg.com%2Frushidao%2Fpics%2Fhv1%2F20%2F108%2F1744%2F113431160.jpg"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        self.image1 = [UIImage imageWithData:data];
        
    });
    
    dispatch_group_async(group, queue, ^{
        NSURL *url = [NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1595958132630&di=77860915f870749361e880643d851dfa&imgtype=0&src=http%3A%2F%2Fgss0.baidu.com%2F9vo3dSag_xI4khGko9WTAnF6hhy%2Fzhidao%2Fpic%2Fitem%2F3b292df5e0fe99257d8c844b34a85edf8db1712d.jpg"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        self.image2 = [UIImage imageWithData:data];
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        UIGraphicsBeginImageContext(CGSizeMake(300, 300));
        [self.image1 drawInRect:CGRectMake(0, 0, 150, 300)];
        [self.image2 drawInRect:CGRectMake(150, 0, 150, 300)];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageV.image = image;
        });
    });
}


//下载图片4
- (void)group4{
    dispatch_queue_t queue = dispatch_queue_create("download", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSURL *url = [NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1595958132630&di=f500fe50cdb0a11a49e06d47070a1733&imgtype=0&src=http%3A%2F%2Fimg1.gtimg.com%2Frushidao%2Fpics%2Fhv1%2F20%2F108%2F1744%2F113431160.jpg"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        self.image1 = [UIImage imageWithData:data];

    });
    dispatch_async(queue, ^{
        NSURL *url = [NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1595958132630&di=77860915f870749361e880643d851dfa&imgtype=0&src=http%3A%2F%2Fgss0.baidu.com%2F9vo3dSag_xI4khGko9WTAnF6hhy%2Fzhidao%2Fpic%2Fitem%2F3b292df5e0fe99257d8c844b34a85edf8db1712d.jpg"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        self.image2 = [UIImage imageWithData:data];

    });
    dispatch_barrier_async(queue, ^{
        UIGraphicsBeginImageContext(CGSizeMake(300, 300));
        [self.image1 drawInRect:CGRectMake(0, 0, 150, 300)];
        [self.image2 drawInRect:CGRectMake(150, 0, 150, 300)];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageV.image = image;
        });
    });
}

@end
