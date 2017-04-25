//
//  MyDownload.m
//  GouHi
//
//  Created by xujian on 15/9/22.
//  Copyright (c) 2015年 xujian. All rights reserved.
//

#import "MyDownload.h"

@interface MyDownload()

@property(nonatomic,strong)NSMutableDictionary *tasks;

@end

@implementation MyDownload
/*
+(MyDownload *)shareDownload
{
    static MyDownload *download;
    static dispatch_once_t once;
    
    dispatch_once (&once ,^{
        download = [[MyDownload alloc]init];
        download.tasks = [NSMutableDictionary dictionary];
    });
    return download;
}

- (void)Post:(NSString *)url
              params:(NSDictionary *)paramsDict
             success:(void (^)(NSDictionary *success))success
             failure:(void (^)(NSError *failure))failure
{
    [self Post:url params:paramsDict success:success failure:failure isShowLoading:YES];
}

- (void)Post:(NSString *)url
      params:(NSDictionary *)paramsDict
     success:(void (^)(NSDictionary *success))success
     failure:(void (^)(NSError *failure))failure
    isShowLoading:(BOOL)isShowLoading
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 12;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", nil];
    
    [manager.requestSerializer setValue:@"cd4d776e159510e486116827b80d0368" forHTTPHeaderField:@"X-YUN-KEY"];
    [manager.requestSerializer setValue:@"4e7268e57a109668e83f60927154d812" forHTTPHeaderField:@"X-YUN-ID"];
    
    if (isShowLoading) {
        [SVProgressHUD show];
    }
    
   NSURLSessionDataTask *task = [manager POST:url parameters:paramsDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (isShowLoading) {
             [SVProgressHUD dismiss];
        }

        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        if (isShowLoading && task.state != NSURLSessionTaskStateCanceling) {
            [SVProgressHUD showErrorWithStatus:@"请求失败"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }
        
    }];
    [self.tasks setValue:task forKey:url];
}

+ (BOOL)checkState:(id)data{
    if ([data[@"state"] isEqualToString:@"1"]) {
        return YES;
    }
    return NO;
}
+ (BOOL)checkStatus:(id)data{
    if ([data[@"status"] isEqualToString:@"1"]) {
        return YES;
    }
    return NO;
}

+ (id)getMsg:(id)data{
    return data[@"msg"];
}

+ (void)cancleAllTask{
    for (NSURLSessionDataTask *task in [MyDownload shareDownload].tasks.allValues) {
        [task cancel];
    }
    [[MyDownload shareDownload].tasks removeAllObjects];
    
}
 */
@end
