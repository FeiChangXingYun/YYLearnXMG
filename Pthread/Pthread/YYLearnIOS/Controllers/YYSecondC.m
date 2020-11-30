
//
//  YYSecondC.m
//  YYLearnIOS
//
//  Created by temp on 2020/7/13.
//  Copyright © 2020 YanYanJiang. All rights reserved.
//

#import "YYSecondC.h"
#import "Person.h"
#import "Dog.h"

@interface YYSecondC ()

@end

@implementation YYSecondC

//awakeFromNib写到控制器里面，代表是控制器从nib加载完毕
- (void)awakeFromNib{
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)save:(id)sender {
//    NSHomeDirectory();
//    NSArray *arr = @[@"family",@10];
//    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
//    NSString *filePath= [path stringByAppendingString:@"/array.list"];
////    NSString *filePath= [path stringByAppendingPathComponent:@"array.list"];//会自动给你添加/
//    NSLog(@"%@",filePath);
//    [arr writeToFile:filePath atomically:YES];//是否保持原子性，当为YES时数据写完之后才会生成文件路径，NO时刚写就会创建文件。要写YES当写到一半电脑断点没有成功就不生成文件
    
    //NSUserDefaults它的本质其实就是一个字典型的plist文件
    //使用NSUserDefaults不用关心路径，会自动帮你存到Library/Preferences
    //NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    //[userDefault setObject:@"YANYAN" forKey:@"name"];//现在写完之后会立马帮你存起来，以前不是这样的你写了[userDefault synchronize];之后才会立即帮你存
    //ios7之后，就不要synchronize
    //[userDefault synchronize];
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [path stringByAppendingPathComponent:@"model.data"];

    Person *per = [[Person alloc] init];
    per.name = @"yanyan";
    per.age = 18;
    
    Dog *dog = [[Dog alloc] init];
    dog.name = @"Jack";
    per.dog = dog;
    
    NSError *error;
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:per requiringSecureCoding:YES error:&error];
    [data writeToFile:filePath atomically:YES];
}

- (IBAction)read:(id)sender {
//    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
//    NSString *filePath= [path stringByAppendingString:@"/array.list"];
//    NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
//    NSLog(@"%@",array);
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [path stringByAppendingPathComponent:@"model.data"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSError *error;
    Person *per = [NSKeyedUnarchiver unarchivedObjectOfClass:[Person class] fromData:data error:&error];
    NSLog(@"name:%@,dog.name:%@ ",per.name,per.dog.name);
}


/*
#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
