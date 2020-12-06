//
//  CategoryPerson+Eat.m
//  Pthread
//
//  Created by Yanyan Jiang on 2020/12/1.
//  Copyright © 2020 Yanyan Jiang. All rights reserved.
//

#import "CategoryPerson+Eat.h"
#import <objc/runtime.h>

@implementation CategoryPerson (Eat)

int weight_;
NSMutableDictionary *weights_;

- (void)eat{
    NSLog(@"eat");
}

+ (void)eat2{
    NSLog(@"eat2");
}

- (void)run{
    NSLog(@"run (Eat)");
}

+ (void)load{
    NSLog(@"CategoryPerson Eat  +load");
    weights_ = [NSMutableDictionary dictionary];
}

+ (void)initialize{
    NSLog(@"CategoryPerson Eat  +initialize");
}

//不安全多个线程会同时访问一块内存资源
- (void)setWeight:(int)weight{
    weight_ = weight;
    NSString *key = [NSString stringWithFormat:@"%p",self];
    weights_[key] = @(weight);
}

- (int)weight{
    NSString *key = [NSString stringWithFormat:@"%p",self];
    return [weights_[key] intValue];
    //return weight_;
}

//const void * YYNameKey = &YYNameKey;
//const void * YYHeightKey = &YYHeightKey;
//main.m 这个文件通过extern 这个关键字是可以访问 YYNameKey YYHeightKey  这两个变量的是可以随意更改的不安全
//- (void)setName:(NSString *)name{
//    objc_setAssociatedObject(self, YYNameKey, name, OBJC_ASSOCIATION_COPY_NONATOMIC);
//}
//
//- (NSString *)name{
//    return  objc_getAssociatedObject(self, YYNameKey);
//}
//
//- (void)setHeight:(int)height{
//    objc_setAssociatedObject(self, YYHeightKey, @(height), OBJC_ASSOCIATION_ASSIGN);
//}
//
//- (int)height{
//    return [objc_getAssociatedObject(self, YYHeightKey) intValue];
//}



//用static 修饰外部就不可以访问了，比较安全 用char修改是因为char 只占用一个字节
//static const char  YYNameKey ;
//static const char  YYHeightKey ;
//- (void)setName:(NSString *)name{
//    objc_setAssociatedObject(self, &YYNameKey, name, OBJC_ASSOCIATION_COPY_NONATOMIC);
//}
//
//- (NSString *)name{
//    return  objc_getAssociatedObject(self, &YYNameKey);
//}
//
//- (void)setHeight:(int)height{
//    objc_setAssociatedObject(self, &YYHeightKey, @(height), OBJC_ASSOCIATION_ASSIGN);
//}
//
//- (int)height{
//    return [objc_getAssociatedObject(self, &YYHeightKey) intValue];
//}


//用变量名修饰这样更直观一些，但是写错了不会提示错误,字符串常量在常量区，相同的字符串常量地址都是一样的
//- (void)setName:(NSString *)name{
//    NSLog(@"%p, %p",@"name",@"name");
//    objc_setAssociatedObject(self, @"name", name, OBJC_ASSOCIATION_COPY_NONATOMIC);
//}
//
//- (NSString *)name{
//    return  objc_getAssociatedObject(self, @"name");
//}
//
//- (void)setHeight:(int)height{
//    objc_setAssociatedObject(self,@"height", @(height), OBJC_ASSOCIATION_ASSIGN);
//}
//
//- (int)height{
//    return [objc_getAssociatedObject(self, @"height") intValue];
//}


//这样写会有提示,写错了也会有提示
//- (void)setName:(NSString *)name{
//    NSLog(@"%p, %p",@selector(name),@selector(name));
//    objc_setAssociatedObject(self, @selector(name), name, OBJC_ASSOCIATION_COPY_NONATOMIC);
//}
//
//- (NSString *)name{
//    return  objc_getAssociatedObject(self, @selector(name));
//}
//
//- (void)setHeight:(int)height{
//    objc_setAssociatedObject(self,@selector(height), @(height), OBJC_ASSOCIATION_ASSIGN);
//}
//
//- (int)height{
//    return [objc_getAssociatedObject(self, @selector(height)) intValue];
//}

- (void)setName:(NSString *)name{
    //_cmd == @selector(setName:) set方法中不能写_cmd 因为set方法与get方法要保持一致
    objc_setAssociatedObject(self, @selector(name), name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)name{
    //_cmd就代表当前方法的selector
    //_cmd == @selector(name)
    //每一个oc方法在调用的时候都会有一个隐式的参数传过来就是_cmd
    //get方法是两个隐式的参数 一个是self 一个是_cmd
    //- (NSString *)name:(id)self   _cmd:(SEL)_cmd
    //关联对象是没有weak这种操作的，没有弱引用效果的
    return  objc_getAssociatedObject(self, _cmd);
}

- (void)setHeight:(int)height{
    objc_setAssociatedObject(self,@selector(height), @(height), OBJC_ASSOCIATION_ASSIGN);
}

- (int)height{
    return [objc_getAssociatedObject(self, _cmd) intValue];
}




@end
