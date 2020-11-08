//
//  ImageTableViewController.m
//  Pthread
//
//  Created by Yanyan Jiang on 2020/8/3.
//  Copyright © 2020 Yanyan Jiang. All rights reserved.
//

#import "ImageTableViewController.h"
#import "ImageModel.h"

@interface ImageTableViewController ()
@property(nonatomic, strong) NSArray *apps;
@property(nonatomic, strong) NSMutableDictionary *dict;
@property(nonatomic, strong) NSMutableDictionary *operations;
@property(nonatomic, strong) NSOperationQueue *queue;
@end

@implementation ImageTableViewController
- (NSArray *)apps{
    if (!_apps) {
        NSString *fileStr = [[NSBundle mainBundle] pathForResource:@"apps.plist" ofType:nil];
        NSArray *arr = [NSArray arrayWithContentsOfFile:fileStr];
        NSMutableArray *apps = [NSMutableArray array];
        for (int i=0; i<arr.count; i++) {
            NSDictionary *dict = arr[i];
            [apps addObject:[ImageModel imageWithDict:dict]];
        }
        _apps = apps;
    }
    return _apps;
}

- (NSMutableDictionary *)dict{
    if (!_dict) {
        _dict = [NSMutableDictionary dictionary];
    }
    return _dict;
}

- (NSMutableDictionary *)operations{
    if (!_operations) {
        _operations = [NSMutableDictionary dictionary];
    }
    return _operations;
}

- (NSOperationQueue *)queue{
    if (!_queue) {
        _queue = [[NSOperationQueue alloc] init];
    }
    return _queue;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"%@",NSHomeDirectory());
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.apps.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *appID = @"app";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:appID];
    ImageModel *model = self.apps[indexPath.row];
    cell.textLabel.text = model.name;
    cell.detailTextLabel.text = model.download;
    
    UIImage *image = [self.dict objectForKey:model.icon];
    if (image) {//从内存中找
        cell.imageView.image = image;
    }else{
        //从磁盘中找
        NSString *caches = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        NSString *lastStr = [model.icon lastPathComponent];
        NSString *fullPath = [caches stringByAppendingPathComponent:lastStr];
        NSData *dataImage = [NSData dataWithContentsOfFile:fullPath];
        if (dataImage) {
            UIImage *image = [UIImage imageWithData:dataImage];
            cell.imageView.image = image;
            [self.dict setObject:image forKey:model.icon];
        }else{
            NSBlockOperation *download = [self.operations objectForKey:model.icon];
            if (download) {
                NSLog(@"第%ld已经在下载",indexPath.row);
            }else{
                NSBlockOperation *oper = [NSBlockOperation blockOperationWithBlock:^{
                    NSURL *url = [NSURL URLWithString:model.icon];
                    NSData *data = [NSData dataWithContentsOfURL:url];
                    UIImage *image = [UIImage imageWithData:data];
                    [self.dict setObject:image forKey:model.icon];
                    [data writeToURL:[NSURL URLWithString:fullPath] atomically:YES];
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                        cell.imageView.image = image;
                        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                    }];
                }];
                [self.queue addOperation:oper];
                [self.operations setObject:oper forKey:model.icon];
            }
        }
        NSLog(@"%ld",indexPath.row);
    }
    
    return cell;
}

@end
