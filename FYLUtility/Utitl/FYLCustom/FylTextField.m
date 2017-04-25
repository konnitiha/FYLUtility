//
//  FylTextField.m
//  BATP
//
//  Created by eparking2 on 16/3/18.
//  Copyright © 2016年 eparking. All rights reserved.
//

#import "FylTextField.h"

@implementation FylTextField

- (CGRect)textRectForBounds:(CGRect)bounds
{
    CGRect rect = [super textRectForBounds:bounds];
    
    UIEdgeInsets insets = UIEdgeInsetsMake(0,17, 0,0);
    return UIEdgeInsetsInsetRect(rect, insets);
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    CGRect rect = [super editingRectForBounds:bounds];
    UIEdgeInsets insets = UIEdgeInsetsMake(0,17, 0,0);
    return UIEdgeInsetsInsetRect(rect, insets);
}
- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    return CGRectMake(17, (CGRectGetHeight(bounds)-23)/2.f, 16, 23);
}
- (CGRect)rightViewRectForBounds:(CGRect)bounds
{
    CGRect rect = [super rightViewRectForBounds:bounds];
    UIEdgeInsets insets = UIEdgeInsetsMake(0,-10, 0,10);
    return UIEdgeInsetsInsetRect(rect, insets);
}

@end
