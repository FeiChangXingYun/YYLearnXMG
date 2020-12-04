//
//  CategoryViewController.m
//  Pthread
//
//  Created by Yanyan Jiang on 2020/12/1.
//  Copyright © 2020 Yanyan Jiang. All rights reserved.
//

#import "CategoryViewController.h"
#import "CategoryPerson.h"
#import "CategoryPerson+Eat.h"
#import "CategoryPerson+Test.h"
#import "YYStudent.h"
#import "YYTeacher.h"
#import <objc/runtime.h>

@interface CategoryViewController ()

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //CategoryPerson *person = [[CategoryPerson alloc] init];
    //[person run];
    //[person test];
    //[person eat];
    //通过runtime动态将分类中的方法合并到类对象中、元类对象中；当一编译的时候所有的分类都变成了_category_t 这种结构体，在运行时把_category_t 这种结构体合并到类对象里面去
    /**
     分类的一个底层结构
     假如你有5个分类，会利用这个结构体产生5个对象
     每一个分类都会生成一个结构体，结构体是一样的，只是数据不一样
     编译节段类里面的东西与分类里面的东西暂时是分开的
     struct _category_t {
         const char *name; CategoryPerson
         struct _class_t *cls;
         const struct _method_list_t *instance_methods;
         const struct _method_list_t *class_methods;
         const struct _protocol_list_t *protocols;
         const struct _prop_list_t *properties;
     };
     
     最后参与编译的分类放到方法列表前面，如果分类中的方法与父类重名先调用分类中的方法。
     类扩展在编译的时候就已经合并到到类里面去了，分类是利用运行时特性把分类里面的信息合并到类里面
     */
    
    //获取类的方法
    //[self printMethodNameOfClass:object_getClass(object_getClass(person))];
    
    //load是在runtime加载这个类的时候分别调用对应类的load方法
    //子类调用父类的load方法，是调用父类分类的load方法，如果分类中的方法与类中的方法相同分类的方法会在类方法列表的前面
    
    
    //initialize
    //只要有消息发送就会调用initialize方法并且只会调用其中的一个initialize方法，不会像load那样全部都调用因为load方法不是通过objc_sendMsg()方法调用的，是通过函数指针直接调用的，直接找到那个方法直接调用，load不是通过isa指针找到类对象元类对象调用的;如果没有消息发送就不会调用initialize
    /**
     当这个类第一次接受消息的时候就会调用initialize方法 ，initialize是通过消息机制调用的
     initialize有且只会调用一次
     [YYStudent alloc]; 子类收到第一次收到消息时如果父类的initialize没有调用过会先调用父类的initialize,否则不会调用，再调用子类的initialize方法
     你在第一次使用这个类的时候想做什么事情就可以用initialize
     
     */
    [CategoryPerson alloc];
    [YYStudent alloc];
    [YYTeacher alloc];
//    [CategoryPerson alloc];
//    [CategoryPerson alloc];
//    [YYStudent alloc];
//    [YYStudent alloc];
}


- (void)printMethodNameOfClass:(Class)cls{
    unsigned int count;
    Method *methodList =  class_copyMethodList(cls, &count);
    NSMutableString *methodNames = [NSMutableString string];
    for (int i=0; i<count; i++) {
        Method method = methodList[i];
        NSString *nameStr = NSStringFromSelector(method_getName(method));
        [methodNames appendFormat:@"%@ ",nameStr];
    }
    NSLog(@"person的方法名称:%@",methodNames);
}

@end
