//
//  YYFirstC.m
//  YYLearnIOS
//
//  Created by temp on 2020/7/13.
//  Copyright © 2020 YanYanJiang. All rights reserved.
//

#import "YYFirstC.h"
#import "Student.h" 

@interface YYFirstC ()

@end

@implementation YYFirstC
- (void)viewDidLoad {
    [super viewDidLoad];
    NSThread *mainThread = [NSThread mainThread];
    NSLog(@"mainThread:%@",mainThread);
    NSThread *currentThread = [NSThread currentThread];
    NSLog(@"currentThread:%@",currentThread);
    
    Student *stu = [[Student alloc] init];
    [stu setAge:10];
    NSLog(@"stu1:%@",stu);
    [stu release];
    //NSLog(@"stu2:%@",stu);
    stu = nil;
    NSLog(@"stu3:%@",stu);
    [stu setAge:20];
    
    float a = 3.14;
    float b = 3.14;
    NSLog(@"%f,%f\n %p,%p",a,b,&a,&b);
    
    void *pa = &a;
    void *pb = &b;
    NSLog(@"%f,%f\n %p,%p",*((float*)pa),*((float*)pb),&(*pa),&(*pb));
    
    
    char c = 'u';
    char d = 'u';
    NSLog(@"%c,%c\n %p,%p",c,d,&c,&d);
    
    NSString *str1 = @"abc";
    NSString *str2 = @"abc";
    NSLog(@"%@,%@\n %p,%p",str1,str2,&*str1,&*str2);
    
    NSInteger aa = 3;
    NSInteger bb = 3;
    NSLog(@"%ld,%ld\n %p,%p",(long)aa,(long)bb,&aa,&bb);

}

- (IBAction)clickBtn:(id)sender {
    for (int i=0; i<1000000; i++) {
        NSLog(@"currentThread:%@",[NSThread currentThread]);
    }
}


- (IBAction)jumpToShowGGOrMM:(id)sender {
//    [self performSegueWithIdentifier:@"showGG" sender:nil];
    [self performSegueWithIdentifier:@"showMM" sender:nil];
    //performSegueWithIdentifier内部实现：
    //1.根据标识，去到storyboard当中查找有没有指定的标识，没有就报错,如果有
    //2.帮你创建segue对象(UIStoryboardSegue*)segue
    //3.给segue对象的属性赋值, segue.sourceViewController = self;
    //4.帮你创建segue箭头指向的控制器（YYSecondC）YYSecondC *secondC = [[YYSecondC alloc] init];给segue的目标控制器赋值segue.destinationViewController=secondC;
    //5.会调用当前控制器的prepareForSegue:sender:告诉你segue已经准备好跳转，在些方法可以获取当要跳转的控制器了，有没有数据传递给目标控制器。这个方法仅仅是在跳转之前调用，
    //6.真正做跳转的是segue的perform方法 [segue perform];这个方法才是真正做跳转的 [segue.sourceViewController.navigationController pushViewController:segue.destinationViewController animated:YES];你在storyboard中看到的所有东西都是要转化为代码的
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"%@,%@",segue.destinationViewController,sender);
//    [segue perform];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
@end
