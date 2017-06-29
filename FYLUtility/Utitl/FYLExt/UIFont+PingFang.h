//
//  UIFont+PingFang.h
//  YBTaoChe
//
//  Created by FuYunLei on 2017/6/23.
//  Copyright © 2017年 FuYunLei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (PingFang)

#ifdef kChangeFont

+ (UIFont *)__pingFang_SC_FontOfSize:(CGFloat)fontSize;

#endif

@end

