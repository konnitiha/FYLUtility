//
//  FYLUtility.h
//  XiangParkingNew
//
//  Created by eparking2 on 15/11/16.
//  Copyright © 2015年 eparking. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import<CommonCrypto/CommonDigest.h>


//分类
#import "UIView+FYLExt.h"
#import "UIView+Screenshot.h"
#import "UIWindow+Screenshot.h"
#import "UILabel+FYLColor.h"
#import "UIColor+FYLExt.h"
#import "UIButton+FYLExt.h"
#import "UIButton+ImageTitleSpacing.h"
#import "NSString+FYL.h"
#import "UIFont+PingFang.h"
#import "NSDictionary+FYLLog.h"


//自定义
#import "FylTextField.h"
#import "FYLPopView.h"
#import "FYLBtn.h"

//工具
#import "FYLQiNiuHelper.h"
#import "MyDownload.h"
#import "FYLLocationHelper.h"

#define FYLRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]


typedef void (^ChooseImageBlock)(UIImage *image);
@interface FYLUtility : NSObject

+ (instancetype)shareUtility;

/**
 通过 标题,字体大小创建label
 */
+ (UILabel *)createLabelWithTitle:(NSString *)title fontSize:(CGFloat)fontSize;
/**
 通过 坐标,标题,字体,颜色,背景颜色创建label
 */
+ (UILabel *)createLabelWithFrame:(CGRect)frame title:(NSString *)title font:(UIFont *)font textColor:(UIColor *)textColor bgColor:(UIColor *)bgColor;
/**
 全属性创建label
 */
+ (UILabel *)createLabelWithFrame:(CGRect)frame title:(NSString *)title font:(UIFont *)font textColor:(UIColor *)textColor bgColor:(UIColor *)bgColor textAlignment:(NSTextAlignment)textAlignment numberOfLines:(NSInteger)numberOfLines;

/**
 全属性创建Btn
 */
+ (UIButton *)createButtonWithFrame:(CGRect)frame bgColor:(UIColor *)bgColor title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font image:(UIImage *)image target:(id)target sel:(SEL)action tag:(NSInteger)tag;
/**
创建图像按钮
 */
+ (UIButton *)createButtonWithFrame:(CGRect)frame image:(UIImage *)image target:(id)target sel:(SEL)action tag:(NSInteger)tag;

//数据存取
+ (void)saveLocalData:(id)obj forKey:(NSString *)key;
+ (void)removeLocalData:(NSString *)key;
+ (id)getLocalData:(NSString *)key;

//加密
+ (NSString *)md5:(NSString *)input;
//字符串处理
+ (NSString *)strDeleteZeroAtEnd:(NSString *)str;
+ (NSString *)doubleDeleteZeroAtEnd:(double)f;

/**
 时间戳字符串转时间 @"YYYY-MM-dd HH:mm"
 */
+ (NSString *)strToDateStr:(NSString *)str;

/**
 获取最上层vc
 */
+ (UIViewController *)topViewController;

+ (void)showMBProgressWithTitle:(NSString *)title ToView:(UIView *)view autoHideWithAfterSecond:(float)second;
+ (void)showAlertControllerWithTitle:(NSString *)title message:(NSString *)message inVc:(UIViewController *)vc;
/**
 检查手机号格式

 @param mobileNum 手机号字符串
 @return bool
 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum;


/**
 通过类名创建类_viewcontroller

 @param vcName 类名
 @return 控制器
 */
+ (UIViewController *)createViewControllerWithVcName:(NSString *)vcName;

/**
 选择照片
 在 info.plist里面添加Localized resources can be mixed,YES 表示是否允许应用程序获取框架库内语言。
 
 @param block 照片选择完成回调
 */
- (void)chooseImage:(ChooseImageBlock)block;

/**
 全屏截图

 @return UIImage对象
 */
UIImage *getImageWithFullScreenshot(void);
@end


