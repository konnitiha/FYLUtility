//
//  FYLLocationHelper.h
//  FYLUtility
//
//  Created by FuYunLei on 2017/6/1.
//  Copyright © 2017年 FuYunLei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

/*
 
 * 定位权限1: Privacy - Location When In Use Usage Description    我们需要通过您的地理位置信息获取您周边的相关数据
 * 定位权限2: Privacy - Location Always Usage Description         我们需要通过您的地理位置信息获取您周边的相关数据
 
 */

typedef void (^YLLocationBlock)(NSString *City,NSString *lat,NSString *lng);

@interface FYLLocationHelper : NSObject<CLLocationManagerDelegate>
@property(nonatomic,copy)YLLocationBlock block;

+ (instancetype)helper;
- (void)locationWithSuc:(YLLocationBlock)sucBlock;

@end
