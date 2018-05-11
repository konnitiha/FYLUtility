//
//  NSObject+FYLModel.h
//  FYLUtility
//
//  Created by admin on 2018/5/11.
//  Copyright © 2018年 FuYunLei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (FYLModel)

+ (instancetype)fyl_modelWithDic:(NSDictionary *)dict;
+ (NSDictionary *)fyl_keyValueMap;

@end
