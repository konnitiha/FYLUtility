//
//  UIWindow+Screenshot.h
//  FYLUtility
//
//  Created by FuYunLei on 2017/8/24.
//  Copyright © 2017年 FuYunLei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (Screenshot)

- (UIImage *)screenshot;
- (UIImage *)screenshotWithRect:(CGRect)rect;

@end
