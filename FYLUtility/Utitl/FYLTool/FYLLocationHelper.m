//
//  FYLLocationHelper.m
//  FYLUtility
//
//  Created by FuYunLei on 2017/6/1.
//  Copyright © 2017年 FuYunLei. All rights reserved.
//

#import "FYLLocationHelper.h"

@interface FYLLocationHelper()
{
    CLLocationManager *locationManager;
    NSString *currentCity; //当前城市
    BOOL _isLocation;//是否正在定位
}
@end

@implementation FYLLocationHelper

+(instancetype)helper{
    
    static FYLLocationHelper *lh;
    static dispatch_once_t once;
    
    dispatch_once (&once ,^{
        lh = [[FYLLocationHelper alloc]init];
    });
    return lh;
    
}

- (void)locationWithSuc:(YLLocationBlock)sucBlock{
    if (_isLocation) {
        return;
    }
    self.block = sucBlock;
    _isLocation = YES;
    if ([CLLocationManager locationServicesEnabled]) {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        [locationManager requestAlwaysAuthorization];
        currentCity = [[NSString alloc] init];
        [locationManager startUpdatingLocation];
    }
}

#pragma mark CoreLocation delegate
//定位失败则执行此代理方法
//定位失败弹出提示框,点击"打开定位"按钮,会打开系统的设置,提示打开定位服务
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"允许\"定位\"提示" message:@"请在设置中打开定位" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * ok = [UIAlertAction actionWithTitle:@"打开定位" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //打开定位设置
        NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:settingsURL options:@{} completionHandler:nil];
    }];
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertVC addAction:cancel];
    [alertVC addAction:ok];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
    _isLocation = NO;
}
//定位成功
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    [locationManager stopUpdatingLocation];
    _isLocation = NO;
    CLLocation *currentLocation = [locations lastObject];
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    
    //反编码
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            CLPlacemark *placeMark = placemarks[0];
            currentCity = placeMark.locality;
            if (!currentCity) {
                currentCity = @"无法定位当前城市";
            }else{
                //去掉市
                NSRange range = [currentCity rangeOfString:@"市"];
                if (range.location != NSNotFound) {
                    
                    NSString *city = [currentCity substringToIndex:range.location];
                    
                    NSString *lat = [NSString stringWithFormat:@"%f",placeMark.location.coordinate.latitude];
                    NSString *lng = [NSString stringWithFormat:@"%f",placeMark.location.coordinate.longitude];
                    self.block(city, lat, lng);

                }

            }

            NSLog(@"当前城市为:%@",currentCity); //这就是当前的城市
            NSLog(@"具体地址:%@",placeMark.name);//具体地址:  xx市xx区xx街道
        }
        else if (error == nil && placemarks.count == 0) {
            NSLog(@"No location and error return");
        }
        else if (error) {
            NSLog(@"location error: %@ ",error);
        }
        
    }];
}


@end
