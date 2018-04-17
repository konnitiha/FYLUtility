//
//  FYLLabel.h
//  FYLUtility
//
//  Created by admin on 2018/4/17.
//  Copyright © 2018年 FuYunLei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FYLLabel : UILabel

@property(nonatomic,assign)UIEdgeInsets contentEdgeInsets;

/**
 是否支持长按复制
 */
@property(nonatomic,assign)IBInspectable BOOL canPerformCopyAction;

/**
 高亮背景色
 */
@property(nonatomic,strong)IBInspectable UIColor *highlightBackgroundColor;

@end
