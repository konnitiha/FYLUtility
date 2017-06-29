//
//  FYLQiNiuHelper.h
//  YBTaoChe
//
//  Created by FuYunLei on 2017/6/29.
//  Copyright © 2017年 FuYunLei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FYLQiNiuHelper : NSObject


/**
 上传图片到七牛

 @param image 图片对象
 @param sucBlock 成功回调
 */
+ (void)uploadImageToQN:(UIImage *)image withSuc:(void(^)(NSString *imageName))sucBlock;

@end
