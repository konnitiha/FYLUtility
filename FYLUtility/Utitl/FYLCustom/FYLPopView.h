//
//  FYLPopView.h
//  BATP
//
//  Created by eparking2 on 16/4/29.
//  Copyright © 2016年 eparking. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^sure)();

typedef void(^fyl_sheet_action_handler)(NSInteger index);

@interface FYLPopView : UIView

+ (void)showViewWithTitle:(NSString *)title;
+ (void)showViewWithTitle:(NSString *)title aotuHidden:(CGFloat)duration;
+ (void)showViewWithTitle:(NSString *)title withComplete:(sure)sure;

+ (void)showActivityIndicatorView;
//+ (void)addAFHTTPRequestOperationToActivityIndicatorView:(AFHTTPRequestOperation *)op;
+ (void)hideActivityIndicatorView;

+ (void)showActionSheetControllerWithTitle:(NSString *)title message:(NSString *)message destructiveBtnTitle:(NSString *)destructiveTitle otherBtnTitles:(NSArray *)titles action:(fyl_sheet_action_handler)block inVc:(UIViewController *)vc;
+ (void)showAlertControllerWithTitle:(NSString *)title message:(NSString *)message sureBtnTitle:(NSString *)sureTitle otherBtnTitles:(NSArray *)titles action:(fyl_sheet_action_handler)block inVc:(UIViewController *)vc;
@end
