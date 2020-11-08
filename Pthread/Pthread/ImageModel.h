//
//  ImageModel.h
//  Pthread
//
//  Created by Yanyan Jiang on 2020/8/3.
//  Copyright © 2020 Yanyan Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageModel : NSObject

@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *icon;
@property(nonatomic, copy) NSString *download;
+(ImageModel*)imageWithDict:(NSDictionary*)dic;

@end

NS_ASSUME_NONNULL_END
 
