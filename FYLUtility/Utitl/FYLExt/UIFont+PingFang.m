//
//  UIFont+PingFang.m
//  YBTaoChe
//
//  Created by FuYunLei on 2017/6/23.
//  Copyright © 2017年 FuYunLei. All rights reserved.
//

#import "UIFont+PingFang.h"
#import <objc/runtime.h>

@implementation UIFont (PingFang)

#ifdef kChangeFont
+(void)load{
    [super load];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method oldMethod = class_getClassMethod([self class], @selector(systemFontOfSize:));
        Method newMethod = class_getClassMethod([self class], @selector(__pingFang_SC_FontOfSize:));
        method_exchangeImplementations(oldMethod, newMethod);
    });
}

+ (UIFont *)__pingFang_SC_FontOfSize:(CGFloat)fontSize{
    
    UIFont *font = [UIFont fontWithName:@"PingFang SC" size:fontSize];
    if (!font)return [self __pingFang_SC_FontOfSize:fontSize];
    return font;
    
}
#endif

@end

