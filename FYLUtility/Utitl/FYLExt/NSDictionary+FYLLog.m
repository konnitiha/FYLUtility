//
//  NSDictionary+FYLLog.m
//  iOS_Toy
//
//  Created by FuYunLei on 2017/3/20.
//  Copyright © 2017年 zhushuai. All rights reserved.
//

#import "NSDictionary+FYLLog.h"

@implementation NSDictionary (FYLLog)

- (NSString *)descriptionWithLocale:(id)locale
{
    NSString *logStr;
    
    @try {
        logStr = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
    } @catch (NSException *exception) {
        NSString *reason = [NSString stringWithFormat:@"reason:%@",exception.reason];
        logStr = [NSString stringWithFormat:@"转换失败:\n%@,\n转换终止,输出如下:\n%@",reason,self.description];
    } @finally {
        
    }
    return logStr;
}


@end
