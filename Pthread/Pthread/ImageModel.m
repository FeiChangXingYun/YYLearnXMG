//
//  ImageModel.m
//  Pthread
//
//  Created by Yanyan Jiang on 2020/8/3.
//  Copyright © 2020 Yanyan Jiang. All rights reserved.
//

#import "ImageModel.h"

@implementation ImageModel

+(ImageModel*)imageWithDict:(NSDictionary*)dic{
    ImageModel *model = [[ImageModel alloc] init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
    
}

@end
