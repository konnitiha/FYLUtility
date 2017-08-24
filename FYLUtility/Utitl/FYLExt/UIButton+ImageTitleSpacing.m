//
//  UIButton+ImageTitleSpacing.m
//  BATP停车
//
//  Created by eparking2 on 16/8/17.
//  Copyright © 2016年 eparking2. All rights reserved.
//

#import "UIButton+ImageTitleSpacing.h"
#import <objc/runtime.h>

@implementation UIButton (ImageTitleSpacing)

static char *ImageTitleTypeKey = "ImageTitleTypeKey";
static char *ImageTitleSpaceKey = "ImageTitleSpaceKey";

- (NSInteger)ImageTitleType
{
    return [objc_getAssociatedObject(self, ImageTitleTypeKey) integerValue];
}
- (CGFloat)imageTitleSpace
{
    return [objc_getAssociatedObject(self, ImageTitleSpaceKey) doubleValue];
}

- (void)setImageTitleType:(NSInteger )ImageTitleType
{
    objc_setAssociatedObject(self, ImageTitleTypeKey, @(ImageTitleType), OBJC_ASSOCIATION_ASSIGN);
   [self layoutButtonWithEdgeInsetsStyle:ImageTitleType imageTitleSpace:self.imageTitleSpace==0?6:self.imageTitleSpace];
}
-(void)setImageTitleSpace:(CGFloat)imageTitleSpace
{
    objc_setAssociatedObject(self, ImageTitleSpaceKey, @(imageTitleSpace), OBJC_ASSOCIATION_ASSIGN);
    [self layoutButtonWithEdgeInsetsStyle:self.ImageTitleType imageTitleSpace:imageTitleSpace];
}

- (void)layoutButtonWithEdgeInsetsStyle:(MKButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space
{

    // 1. 得到imageView和titleLabel的宽、高
    CGFloat imageWith = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    
    
    labelWidth = self.titleLabel.intrinsicContentSize.width;
    labelHeight = self.titleLabel.intrinsicContentSize.height;
    
    /*
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
    } else {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }
    */
    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    
    // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
    switch (style) {
        case MKButtonEdgeInsetsStyleTop:
        {
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2.0, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space/2.0, 0);
        }
            break;
        case MKButtonEdgeInsetsStyleLeft:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
        }
            break;
        case MKButtonEdgeInsetsStyleBottom:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/2.0, -imageWith, 0, 0);
        }
            break;
        case MKButtonEdgeInsetsStyleRight:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space/2.0, 0, -labelWidth-space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-space/2.0, 0, imageWith+space/2.0);
        }
            break;
        default:
            break;
    }
    // 4. 赋值
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
 
}
@end
