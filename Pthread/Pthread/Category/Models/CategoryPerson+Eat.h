//
//  CategoryPerson+Eat.h
//  Pthread
//
//  Created by Yanyan Jiang on 2020/12/1.
//  Copyright © 2020 Yanyan Jiang. All rights reserved.
//

#import "CategoryPerson.h"

NS_ASSUME_NONNULL_BEGIN

@interface CategoryPerson (Eat)

@property(nonatomic, assign) int weight;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, assign) int  height;

- (void)eat;
+ (void)eat2;

@end

NS_ASSUME_NONNULL_END
