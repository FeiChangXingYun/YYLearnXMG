//
//  YYPerson.h
//  Pthread
//
//  Created by Yanyan Jiang on 2020/11/28.
//  Copyright © 2020 Yanyan Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYCat.h"

NS_ASSUME_NONNULL_BEGIN
@interface YYPerson : NSObject{
    @public
    int _weight;
//    int _age;
//    int _isAge;
//    int age;
    int isAge;
}

//@property (assign, nonatomic) int age;
@property (assign, nonatomic) int height;
@property (strong, nonatomic) YYCat *cat;
@end

NS_ASSUME_NONNULL_END
