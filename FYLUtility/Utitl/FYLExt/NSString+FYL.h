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
 添加前缀
 */
@property(nonatomic, readonly) NSString *(^addPrefix)(NSString *pre);

/**
 添加后缀
 */
@property(nonatomic, readonly) NSString *(^addSuffix)(NSString *suf);
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


/**
 添加前缀

 @param pre 前缀
 @return 新String
 */
- (NSString *)addPrefix:(NSString *)pre;

/**
 添加后缀

 @param suf 后缀
 @return 新String
 */
- (NSString *)addSuffix:(NSString *)suf;

@end
