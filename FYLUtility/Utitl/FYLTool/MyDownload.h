//
//  MyDownload.h
//  GouHi
//
//  Created by xujian on 15/9/22.
//  Copyright (c) 2015年 xujian. All rights reserved.
//


#import <Foundation/Foundation.h>
//#import "AFNetworking.h"

//#define kBaseUrlWith(object) [NSString stringWithFormat:@"http://wx.zwzyd.com/api/%@", object]
//#define kResourceUrlWith(object) [NSString stringWithFormat:@"http://wx.zwzyd.com/%@", object]
#define kBaseUrlWith(object) [NSString stringWithFormat:@"http://gtedutech.com/api/%@", object]
#define kResourceUrlWith(object) [NSString stringWithFormat:@"http://gtedutech.com/%@", object]

@interface MyDownload : NSObject

//+(MyDownload *)shareDownload;
//
//
//- (void)Post:(NSString *)url
//              params:(NSDictionary *)paramsDict
//             success:(void (^)(NSDictionary *success))success
//             failure:(void (^)(NSError *failure))failure;
/////可设置是否显示 loading动画
//- (void)Post:(NSString *)url
//      params:(NSDictionary *)paramsDict
//     success:(void (^)(NSDictionary *success))success
//     failure:(void (^)(NSError *failure))failure
//isShowLoading:(BOOL)isShowLoading;
//
//+ (BOOL)checkState:(id)data;
//+ (BOOL)checkStatus:(id)data;
//+ (id)getMsg:(id)data;
//
//
///**
// 取消所有请求
// */
//+ (void)cancleAllTask;

@end
