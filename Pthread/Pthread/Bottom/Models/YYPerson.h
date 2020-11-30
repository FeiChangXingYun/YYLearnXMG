//
//  YYPerson.h
//  Pthread
//
//  Created by Yanyan Jiang on 2020/11/28.
//  Copyright © 2020 Yanyan Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYPerson : NSObject{
    @public
    int _weight;
}

@property (assign, nonatomic) int age;
@property (assign, nonatomic) int height;

@end

NS_ASSUME_NONNULL_END
