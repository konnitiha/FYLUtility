//
//  NSObject+FYLModel.m
//  FYLUtility
//
//  Created by admin on 2018/5/11.
//  Copyright © 2018年 FuYunLei. All rights reserved.
//

#import "NSObject+FYLModel.h"
#import <objc/runtime.h>

@implementation NSObject (FYLModel)

+ (instancetype)fyl_modelWithDic:(NSDictionary *)dict{
    
    id objc = [[self alloc] init];
    
    unsigned int count = 0;
    
    Ivar *ivarList = class_copyIvarList(self, &count);
    for (int i = 0; i < count; i++) {
        
        Ivar ivar = ivarList[i];
        
        NSString *propertyName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        
        NSString *propertyKey = [propertyName substringFromIndex:1];//去掉下划线
        NSDictionary *map = [self fyl_keyValueMap];
        
        id value = nil;
        
        if ([map objectForKey:propertyKey] != nil) {
            value = dict[[map objectForKey:propertyKey]];
        }else{
            value = dict[propertyKey];
        }
        
        NSString *propertyType = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        
        if ([value isKindOfClass:[NSDictionary class]] && ![propertyType containsString:@"NS"]) {
            
            NSRange range = [propertyType rangeOfString:@"\""];
            propertyType = [propertyType substringFromIndex:range.location + range.length];
            range = [propertyType rangeOfString:@"\""];
            propertyType = [propertyType substringToIndex:range.location];
            
            Class modelClass = NSClassFromString(propertyType);
            
            if (modelClass) {
                value = [modelClass fyl_modelWithDic:value];
            }
        }
        
        if (value) {
            [objc setValue:value forKey:propertyKey];
        }
        
    }
    
    return objc;
}

+ (NSDictionary *)fyl_keyValueMap{
    return nil;
}


@end
