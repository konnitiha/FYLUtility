//
//  UIButton+FYLExt.h
//  BATP
//
//  Created by eparking2 on 16/5/3.
//  Copyright © 2016年 eparking. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (FYLExt)

/**
字体大小
 */
@property (nonatomic,assign)IBInspectable CGFloat fontSize;

- (void)setBackgroundImageWithColor:(UIColor *)color forState:(UIControlState)state;

@end
