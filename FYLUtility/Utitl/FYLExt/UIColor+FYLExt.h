//
//  UIColor+FYLExt.h
//  BATP
//
//  Created by eparking2 on 16/3/31.
//  Copyright © 2016年 eparking. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (FYLExt)


+ (UIColor*)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;
+ (UIColor*)colorWithHex:(NSInteger)hexValue;
+ (NSString *)hexFromUIColor: (UIColor*) color;

+ (UIImage *)colorToImageWithColor:(UIColor *)color andSize:(CGSize)size;

@end
