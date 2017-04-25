//
//  NSString+FYL.m
//  QinYueHui
//
//  Created by FuYunLei on 2017/4/24.
//  Copyright © 2017年 FuYunLei. All rights reserved.
//

#import "NSString+FYL.h"

@implementation NSString (FYL)


- (NSString *)cacheDir{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    return [path stringByAppendingPathComponent:self];
}
- (NSString *)docDir{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    return [path stringByAppendingPathComponent:self];
}
- (NSString *)tempDir{
    NSString *path = NSTemporaryDirectory();
    return [path stringByAppendingPathComponent:self];
}

@end
