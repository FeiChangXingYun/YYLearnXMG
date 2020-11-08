//
//  UrlConnectionVController.m
//  Pthread
//
//  Created by Yanyan Jiang on 2020/8/14.
//  Copyright © 2020 Yanyan Jiang. All rights reserved.
//

#import "UrlConnectionVController.h"

@interface UrlConnectionVController ()<NSURLConnectionDataDelegate,NSURLSessionDataDelegate>
@property(nonatomic, strong) NSMutableData *data;
@end

@implementation UrlConnectionVController
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self sessionDelegate];
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

@end
