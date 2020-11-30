//
//  VCView.m
//  YYLearnIOS
//
//  Created by temp on 2020/7/15.
//  Copyright © 2020 YanYanJiang. All rights reserved.
//

#import "VCView.h"

@interface VCView ()
@property (weak, nonatomic) IBOutlet UIButton *save;
@end

@implementation VCView

//当解析nib文件完成时调用
//先调用Controller中的awakeFromNib 再调用VCView中的awakeFromNib
- (void)awakeFromNib{
    [super awakeFromNib];
    NSLog(@"%@",self.save);
}

//当开始解析一个文件时调用。
//因为nib是文件，所以当加载nib文件时会调用该方法
- (instancetype)initWithCoder:(NSCoder *)coder{
    NSLog(@"%@",self.save);
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

@end
