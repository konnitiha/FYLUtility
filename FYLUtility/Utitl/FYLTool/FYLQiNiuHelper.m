//
//  FYLQiNiuHelper.m
//  YBTaoChe
//
//  Created by FuYunLei on 2017/6/29.
//  Copyright © 2017年 FuYunLei. All rights reserved.
//

#import "FYLQiNiuHelper.h"

/*  Podfile
 platform:ios,"8.0"
 
 target '工程名' do
 
 pod 'Qiniu', '~> 7.1'
 
 end
 */

/*
//七牛sdk
#import "QiniuSDK.h"
#import <Qiniu/QN_GTM_Base64.h>
#import <CommonCrypto/CommonCrypto.h>
//七牛key
#define kQiNiuScope @"yuanbaotaoche"
#define kQiNiuAccessKey @"wzb8S29SVK5PvS0doSy7lvKmF7dMxljSLMMy3kD9"
#define kQiNiuSecretKey @"lUlwtgTwe5EdmI4cW6kE3anZJAj2OlqjYGkmpTuC"
*/

/*
 域名  http://olifjkwpe.bkt.clouddn.com/
*/
@implementation FYLQiNiuHelper

/*
+ (void)uploadImageToQN:(UIImage *)image withSuc:(void (^)(NSString *))sucBlock{
     NSData *data = UIImageJPEGRepresentation(image, 0.2);

    [QNConfiguration build:^(QNConfigurationBuilder *builder) {
        builder.zone = [QNZone zone1];
    }];
    
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    
    QNUploadOption *uploadOption = [[QNUploadOption alloc] initWithMime:nil progressHandler:^(NSString *key, float percent) {
        NSLog(@"上传图片进度 %.2f", percent);
    } params:nil checkCrc:NO cancellationSignal:nil];
    
//    WeakSelf(ws)
    [upManager putData:data key:nil token:[self createToken] complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        
        NSString *picName = resp[@"key"];
        
        if (picName != nil) {
            
            if (sucBlock!= nil) {
                sucBlock(picName);
            }
//            ws.imageUrl = [NSString stringWithFormat:@"http://oqv8tlktu.bkt.clouddn.com/%@",picName];
//            [ws updateAvatarToServer:picName];
        }
        
    } option:uploadOption];
    
}

#pragma mark - Qiniu
+ (NSString *)createToken {
    
    // 将上传策略中的scrop和deadline序列化成json格式
    NSMutableDictionary *authInfo = [NSMutableDictionary dictionary];
    [authInfo setObject:kQiNiuScope forKey:@"scope"];
    [authInfo
     setObject:[NSNumber numberWithLong:[[NSDate date] timeIntervalSince1970] + 30 * 24 * 3600]
     forKey:@"deadline"];
    
    NSData *jsonData =
    [NSJSONSerialization dataWithJSONObject:authInfo options:NSJSONWritingPrettyPrinted error:nil];
    
    // 对json序列化后的上传策略进行URL安全的base64编码
    NSString *encodedString = [self urlSafeBase64Encode:jsonData];
    
    // 用secretKey对编码后的上传策略进行HMAC-SHA1加密，并且做安全的base64编码，得到encoded_signed
    NSString *encodedSignedString = [self HMACSHA1:kQiNiuSecretKey text:encodedString];
    
    // 将accessKey、encodedSignedString和encodedString拼接，中间用：分开，就是上传的token
    NSString *token =
    [NSString stringWithFormat:@"%@:%@:%@", kQiNiuAccessKey, encodedSignedString, encodedString];
    
    return token;
    
}

+ (NSString *)urlSafeBase64Encode:(NSData *)text {
    NSString *base64 =
    [[NSString alloc] initWithData:[QN_GTM_Base64 encodeData:text] encoding:NSUTF8StringEncoding];
    base64 = [base64 stringByReplacingOccurrencesOfString:@"+" withString:@"-"];
    base64 = [base64 stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    return base64;
}

+ (NSString *)HMACSHA1:(NSString *)key text:(NSString *)text {
    const char *cKey = [key cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [text cStringUsingEncoding:NSUTF8StringEncoding];
    
    char cHMAC[CC_SHA1_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC length:CC_SHA1_DIGEST_LENGTH];
    NSString *hash = [self urlSafeBase64Encode:HMAC];
    return hash;
}
*/
@end
