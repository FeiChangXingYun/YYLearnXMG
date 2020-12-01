//
//  UrlConnectionVController.m
//  Pthread
//
//  Created by Yanyan Jiang on 2020/8/14.
//  Copyright © 2020 Yanyan Jiang. All rights reserved.
//

#import "UrlConnectionVController.h"
#import "YYPerson.h"
#import <objc/runtime.h>

@interface UrlConnectionVController ()<NSURLConnectionDataDelegate,NSURLSessionDataDelegate>
@property(nonatomic, strong) NSMutableData *data;
@property(nonatomic, strong) YYPerson *person1;
@property(nonatomic, strong) YYPerson *person2;

@end

@implementation UrlConnectionVController
- (void)viewDidLoad{
    [super viewDidLoad];
    [self createPerson];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self changeValue];
    //[self sessionDelegate];
//    [self getSessionRequest];
}

- (void)sessionDelegate{
    NSURL *url = [NSURL URLWithString:@"http://47.114.45.98:8082/inspect_platform/basicAuth/login"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request];
    [dataTask resume];
}


#pragma mark --NSURLSessionDataDelegate
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler{
    NSLog(@"______%s_______",__func__);
    completionHandler(NSURLSessionResponseAllow);
    self.data = [NSMutableData data];
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
    NSLog(@"______%s_______",__func__);
    [self.data appendData:data];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    NSLog(@"______%s_______",__func__);
    NSLog(@"%@",[[NSString alloc] initWithData:self.data encoding:NSUTF8StringEncoding]);
    NSLog(@"当前线程：%@",[NSThread currentThread]);
}


- (void)postSession{
    NSURL *url = [NSURL URLWithString:@"http://47.114.45.98:8082/inspect_platform/basicAuth/login"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [@"mobile=18519195047&password=123456&deviceSn=2ba4b8634ec16837c07be5159ddfea77" dataUsingEncoding:NSUTF8StringEncoding];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        NSLog(@"当前线程：%@",[NSThread currentThread]);
    }];
    [dataTask resume];
}


- (void)getSessionRequest{
    NSURL *url = [NSURL URLWithString:@"http://47.114.45.98:8082/inspect_platform/basicAuth/login?mobile=18519195047&password=123456&deviceSn=2ba4b8634ec16837c07be5159ddfea77"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        NSLog(@"%@",[NSThread currentThread]);
    }];
    [dataTask resume];
}

- (void)getSessionNORequest{
    NSURL *url = [NSURL URLWithString:@"http://47.114.45.98:8082/inspect_platform/basicAuth/login?mobile=18519195047&password=123456&deviceSn=2ba4b8634ec16837c07be5159ddfea77"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        NSLog(@"%@",[NSThread currentThread]);
    }];
    NSLog(@"执行完了");
    [dataTask resume];
}

- (void)urlRequest{
    NSURL *url = [NSURL URLWithString:@"http://47.114.45.98:8082/inspect_platform/basicAuth/login?mobile=18519195047&password=123456&deviceSn=2ba4b8634ec16837c07be5159ddfea77"];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:@"18519195047" forKey:@"mobile"];
    [paramDic setObject:@"123456" forKey:@"password"];
    [paramDic setObject:@"2ba4b8634ec16837c07be5159ddfea77" forKey:@"deviceSn"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *response = nil; //响应头
    NSError *error = nil;
    
   NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
   NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
   NSLog(@"执行完了");
}


- (void)urlAsynchronousRequest{
    NSURL *url = [NSURL URLWithString:@"http://47.114.45.98:8082/inspect_platform/basicAuth/login?mobile=18519195047&password=123456&deviceSn=2ba4b8634ec16837c07be5159ddfea77"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        NSLog(@"%@",[NSThread currentThread]);
        
    }];
}

- (void)urlAsynchronousRequestDelegate{
    NSURL *url = [NSURL URLWithString:@"http://47.114.45.98:8082/inspect_platform/basicAuth/login?mobile=18519195047&password=123456&deviceSn=2ba4b8634ec16837c07be5159ddfea77"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //设置代理马上发送请求
   //NSURLConnection *con= [[NSURLConnection alloc] initWithRequest:request delegate:self];
    //[con cancel];
    
    //设置代理 startImmediately yes 表示马上开始  NO需要调用start方法开始发送请求
    NSURLConnection *con= [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    //[con start];
}


#pragma mark --NSURLConnectionDataDelegate
//接收到服务器的响应
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    self.data = [NSMutableData data];
    NSLog(@"______%s_______",__func__);
}

//接收到服务器返回的数据，该方法可能会被调用多次
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [self.data appendData:data];
    NSLog(@"______%s_______",__func__);
}

//请求完成的时候调用
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"%@",[[NSString alloc] initWithData:self.data encoding:NSUTF8StringEncoding]);
    NSLog(@"______%s_______",__func__);
}

//请求失败的时候调用
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"______%s_______",__func__);
}

- (void)sendPost{
    //只有get请求需要转码 post不需要转码
    NSString *str = @"http://47.114.45.98:8082/inspect_platform/basicAuth/login";
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    [request setValue:@"IOS 10" forHTTPHeaderField:@"User-Agent"];
    request.timeoutInterval = 10;
    request.HTTPMethod = @"POST";
    request.HTTPBody = [@"mobile=18519195047&password=123456&deviceSn=2ba4b8634ec16837c07be5159ddfea77" dataUsingEncoding:NSUTF8StringEncoding];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        NSLog(@"当前线程：%@",[NSThread currentThread]);
     }];
    NSLog(@"执行完了");
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

@end
