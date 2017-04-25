//
//  FYLBtn.h
//  QinYueHui
//
//  Created by FuYunLei on 2017/4/6.
//  Copyright © 2017年 FuYunLei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    FYLBtnImageTypeLeft,
    FYLBtnImageTypeTop,
    FYLBtnImageTypeRight,
    FYLBtnImageTypeBottom,
} FYLBtnImageType;

@interface FYLBtn : UIButton

@property(nonatomic,assign)NSUInteger imageType;

@property(nonatomic,assign)CGFloat space;

@property(nonatomic,strong)UIFont *fontTitleLabel;
@property(nonatomic,strong)UIColor *colorTitleLabel;

@end
