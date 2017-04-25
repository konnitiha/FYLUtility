//
//  NSString+FYL.h
//  QinYueHui
//
//  Created by FuYunLei on 2017/4/24.
//  Copyright © 2017年 FuYunLei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FYL)


/**
 将当前字符串拼接到cache目录后面

 @return path
 */
- (NSString *)cacheDir;

/**
 将当前字符串拼接到doc目录后面
 
 @return path
 */
- (NSString *)docDir;
/**
 将当前字符串拼接到temp目录后面
 
 @return path
 */
- (NSString *)tempDir;

@end
