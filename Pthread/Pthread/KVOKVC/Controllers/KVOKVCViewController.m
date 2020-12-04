//
//  KVOKVCViewController.m
//  Pthread
//
//  Created by Yanyan Jiang on 2020/12/1.
//  Copyright © 2020 Yanyan Jiang. All rights reserved.
//

#import "KVOKVCViewController.h"
#import "YYPerson.h"
#import <objc/runtime.h>

@interface KVOKVCViewController ()
@property(nonatomic, strong) YYPerson *person1;
@property(nonatomic, strong) YYPerson *person2;

@end

@implementation KVOKVCViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createPerson];
}

#pragma mark --kvo
- (void)createPerson{
    self.person1 = [[YYPerson alloc] init];
    self.person1.cat = [[YYCat alloc] init];
    //[self.person1 setValue:@"30" forKey:@"age"];
    
    //self.person1->_age = 50;
    self.person1->isAge = 60;

    NSLog(@"age:%@",[self.person1 valueForKeyPath:@"age"]);
    //self.person1.height = 18;
    
    self.person2 = [[YYPerson alloc] init];
    //self.person2.age = 3;
    //self.person2.height = 18;
    //这个是找实例的类对象  person1监听之前YYPerson   YYPerson
    
    //NSLog(@"person1监听之前%@   %@",object_getClass(self.person1),object_getClass(self.person2));
    //person1监听之前0x106975940  0x106975940
    //NSLog(@"person1监听之前%p  %p",[self.person1 methodForSelector:@selector(setAge:)],[self.person2 methodForSelector:@selector(setAge:)]);

    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld;
    [self.person1 addObserver:self forKeyPath:@"cat.weight" options:options context:@"person1"];
    
    //[self.person2 addObserver:self forKeyPath:@"height" options:options context:@"person2"];
    //person1监听之后NSKVONotifying_YYPerson   YYPerson
    //NSLog(@"person1监听之后%@   %@",object_getClass(self.person1),object_getClass(self.person2));
    //person1监听之后0x7fff207d2ce3  0x106975940
    //NSLog(@"person1监听之后%p  %p",[self.person1 methodForSelector:@selector(setAge:)],[self.person2 methodForSelector:@selector(setAge:)]);
    //(lldb) p (IMP)0x106975940
    //(IMP) $0 = 0x0000000106975940 (Pthread`-[YYPerson setAge:] at YYPerson.m:13)
    //(lldb) p  (IMP)0x7fff207d2ce3
    //(IMP) $1 = 0x00007fff207d2ce3 (Foundation`_NSSetIntValueAndNotify)
    
    // 类对象0x600001ab0480  0x101086dc8
    //NSLog(@"类对象%p  %p ",object_getClass(self.person1),object_getClass(self.person2));
    //类对象0x600001ab0630  0x101086da0
    //NSLog(@"元类对象%p  %p ",object_getClass(object_getClass(self.person1)),object_getClass(object_getClass(self.person2)));
    //NSLog(@"哈哈哈哈哈");

    //类对象NSKVONotifying_YYPerson  YYPerson
    //NSLog(@"类对象%p  %p ",object_getClass(self.person1),object_getClass(self.person2));
    //类对象2YYPerson  YYPerson
    //NSLog(@"类对象2%p  %p ",[self.person1 class],[self.person2 class]);
    
    //NSKVONotifying_YYPerson  setAge: class dealloc _isKVOA
    //[self printMethodNamesOfClass:object_getClass(self.person1)];
    
    //YYPerson  willChangeValueForKey: didChangeValueForKey: height setAge: age setHeight:
    //[self printMethodNamesOfClass:object_getClass(self.person2)];
}

- (void)changeValue{
    //self.person1.age = 30;
    //self.person2.age = 28;
    //self.person1->_weight = 55;
    
    //手动触发KVO
    //[self.person1 willChangeValueForKey:@"age"];
    //[self.person1 didChangeValueForKey:@"age"];
    //通过KVC触发KVO
    //[self.person1 setValue:@"88" forKey:@"age"];
    //[self.person1 setValue:@"99" forKeyPath:@"age"];
    //[self.person1 setValue:@"14" forKeyPath:@"cat.weight"];
    //NSLog(@"%@",[self.person1 valueForKeyPath:@"cat.weight"]);
}

- (void)dealloc{
    [self.person1 removeObserver:self forKeyPath:@"age"];
    [self.person2 removeObserver:self forKeyPath:@"height"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"监听%@对象的%@属性值%@发生了改变 context:%@",object,keyPath,change,context);
}

//获取一个对象的方法
- (void)printMethodNamesOfClass:(Class)cls{
    unsigned int count;
    Method *methodList = class_copyMethodList(cls, &count);
    NSMutableString *methodNames = [NSMutableString string];
    for (int i=0; i<count; i++) {
        Method method = methodList[i];
        NSString *methodName= NSStringFromSelector(method_getName(method));
        [methodNames appendFormat:@"%@ ",methodName];
    }
    free(methodList);
    NSLog(@"%@  %@",cls,methodNames);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self changeValue];
}



@end
