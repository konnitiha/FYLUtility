//
//  FYLUtility.m
//  XiangParkingNew
//
//  Created by eparking2 on 15/11/16.
//  Copyright © 2015年 eparking. All rights reserved.
//

#import "FYLUtility.h"
//#import "MBProgressHUD.h"
#import <objc/runtime.h>

@interface FYLUtility()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,copy)ChooseImageBlock blockChooseImage;

@end

@implementation FYLUtility

+ (instancetype)shareUtility{
    static FYLUtility *utili;
    static dispatch_once_t once;
    
    dispatch_once (&once ,^{
        utili = [[FYLUtility alloc]init];
    });
    return utili;
}

//创建label
 +(UILabel *)createLabelWithTitle:(NSString *)title fontSize:(CGFloat )fontSize
{
   return  [self createLabelWithFrame:CGRectMake(0, 0, 0, 0) title:title font:[UIFont fontWithName:@"PingFang SC" size:fontSize] textColor:[UIColor blackColor] bgColor:nil];
}
+ (UILabel *)createLabelWithFrame:(CGRect)frame title:(NSString *)title font:(UIFont *)font textColor:(UIColor *)textColor bgColor:(UIColor *)bgColor
{
   return [self createLabelWithFrame:frame title:title font:font textColor:textColor bgColor:bgColor textAlignment:NSTextAlignmentCenter numberOfLines:0];
}
+ (UILabel *)createLabelWithFrame:(CGRect)frame title:(NSString *)title font:(UIFont *)font textColor:(UIColor *)textColor bgColor:(UIColor *)bgColor textAlignment:(NSTextAlignment)textAlignment numberOfLines:(NSInteger)numberOfLines
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textAlignment = textAlignment;
    if (font) {
        [label setFont:font];
    }
    if (textColor) {
        label.textColor = textColor;
    }
    if (bgColor) {
        label.backgroundColor = bgColor;
    }
    if (title) {
         label.text = title;
    }
    label.numberOfLines = numberOfLines;
    return label;
}
//创建button
+ (UIButton *)createButtonWithFrame:(CGRect)frame bgColor:(UIColor *)bgColor title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font image:(UIImage *)image target:(id)target sel:(SEL)action tag:(NSInteger)tag
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:frame];
    if (bgColor) {
        [btn setBackgroundColor:bgColor];
    }
    if (title) {
        [btn setTitle:title forState:UIControlStateNormal];
    }
    if (titleColor) {
        [btn setTitleColor:titleColor forState:UIControlStateNormal];
    }
    if (image) {
        [btn setBackgroundImage:image forState:UIControlStateNormal];
       
    }
    if (font) {
        [btn.titleLabel setFont:font];
    }
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setTag:tag];
    return btn;
}
+(UIButton *)createButtonWithFrame:(CGRect)frame image:(UIImage *)image target:(id)target sel:(SEL)action tag:(NSInteger)tag
{
    return [self createButtonWithFrame:frame bgColor:nil title:nil titleColor:nil font:nil image:image target:target sel:action tag:tag];
}

//保存数据到本地
+(void)saveLocalData:(id)obj forKey:(NSString *)key
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:obj];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
//移除本地数据
+(void)removeLocalData:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}
//获取本地数据
+(id)getLocalData:(NSString *)key
{
    NSData *data = [[NSUserDefaults standardUserDefaults]objectForKey:key];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}


//MD5
+ (NSString *)md5:(NSString *)input
{
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    {
        
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return  output;
}

+ (NSString *)strDeleteZeroAtEnd:(NSString *)str
{
    if (![str containsString:@"."]) {
        return str;
    }
    
    NSMutableString *strMut = [NSMutableString stringWithString:str];
    
    while (strMut.length) {
        unichar ch = [strMut characterAtIndex:strMut.length-1];
        if (ch == '0') {
            [strMut deleteCharactersInRange:NSMakeRange(strMut.length - 1, 1)];
            continue;
        }
        if (ch == '.') {
            [strMut deleteCharactersInRange:NSMakeRange(strMut.length - 1, 1)];
            break;
        }else
        {
            break;
        }
    }
    return strMut;
}

+ (NSString *)doubleDeleteZeroAtEnd:(double)f
{
    NSMutableString *strMut = [NSMutableString stringWithString:[NSString stringWithFormat:@"%.2f",f]];
    while (strMut.length) {
        unichar ch = [strMut characterAtIndex:strMut.length-1];
        if (ch == '0') {
            [strMut deleteCharactersInRange:NSMakeRange(strMut.length - 1, 1)];
            continue;
        }
        if (ch == '.') {
            [strMut deleteCharactersInRange:NSMakeRange(strMut.length - 1, 1)];
            break;
        }else
        {
            break;
        }
    }
    return strMut;
}

+ (NSString *)strToDateStr:(NSString *)str
{
    NSInteger time = [str integerValue]/1000;
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    return [formatter stringFromDate:date];
    
}


+ (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

+ (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

+ (void)showMBProgressWithTitle:(NSString *)title ToView:(UIView *)view autoHideWithAfterSecond:(float)second {
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//    hud.mode = MBProgressHUDModeText;
//    hud.label.text = title;
//    hud.label.textColor = [UIColor whiteColor];
//    hud.bezelView.backgroundColor = [UIColor blackColor];
//    if (second) {
//        [hud hideAnimated:YES afterDelay:second];
//    }
}
+ (void)showAlertControllerWithTitle:(NSString *)title message:(NSString *)message inVc:(UIViewController *)vc
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:action];
    
    
    [vc presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - 工具方法
//判断手机号是否正确
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,183,184,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[0125-9])\\d{8}$";
    /**
     10 * 中国移动：China Mobile
     11 * 134[0-8],135,136,137,138,139,147,150,151,157,158,159,182,187,188,178,1705
     12 */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|4[7]|5[017-9]|8[23478]|78)\\d)\\d{7}$";
    /**
     15 * 中国联通：China Unicom
     16 * 130,131,132,152,155,156,185,186,176,1709
     17 */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56]|76)\\d{8}$";
    /**
     20 * 中国电信：China Telecom
     21 * 133,1349,153,180,189,181,177,1700
     22 */
    NSString * CT = @"^1((33|53|8[019]|77)[0-9]|349|70[059])\\d{7}$";
    //178 1705 1709 176 177 1700
    NSString *newMobile = @"^17(8[0-9]|0[059]|6[0-9]|7[0-9])\\d{7}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextesnewMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", newMobile];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES)
        || ([regextesnewMobile evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (UIViewController *)createViewControllerWithVcName:(NSString *)vcName{
    if (vcName.length < 10) {
        NSLog(@"没有此控制器");
        return [UIViewController new];
    }
    Class cls = NSClassFromString(vcName);
    UIViewController *vc = [[cls alloc] init];
    return vc;
}
- (void)chooseImage:(ChooseImageBlock)block{
    [FYLPopView showActionSheetControllerWithTitle:nil message:nil destructiveBtnTitle:nil otherBtnTitles:@[@"拍照",@"从相册中选择"] action:^(NSInteger index) {
        
        switch (index) {
            case 1:
                [self openCameraOrPhotoLibrary:(UIImagePickerControllerSourceTypeCamera)];
                break;
            case 2:
                [self openCameraOrPhotoLibrary:(UIImagePickerControllerSourceTypePhotoLibrary)];
                break;
            default:
                break;
        }
        
    } inVc:[[UIApplication sharedApplication].keyWindow rootViewController]];
    
    self.blockChooseImage = block;
}
- (void)openCameraOrPhotoLibrary:(UIImagePickerControllerSourceType)type
{
    UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
    
    if (type == UIImagePickerControllerSourceTypeCamera) {
        
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            pickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;
            pickerImage.showsCameraControls = YES;
            pickerImage.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            pickerImage.delegate = self;
            pickerImage.allowsEditing = YES;
            [[[UIApplication sharedApplication].keyWindow rootViewController] presentViewController:pickerImage animated:YES completion:nil];
        }else
        {
            NSLog(@"模拟器");
        }
        
    }else
    {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
            pickerImage.delegate = self;
            pickerImage.allowsEditing = YES;
            [[[UIApplication sharedApplication].keyWindow rootViewController] presentViewController:pickerImage animated:YES completion:nil];
        }
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
    UIImage *image = info[@"UIImagePickerControllerEditedImage"];
    
    NSData *data = UIImageJPEGRepresentation(image, 0.2);
    
    NSLog(@"图片大小%zi kb",data.length/1024);
    // 转成base64编码的字符串
//    NSString * base64Str = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    if (self.blockChooseImage != nil) {
        self.blockChooseImage(image);
    }
    
    [[[UIApplication sharedApplication].keyWindow rootViewController] dismissViewControllerAnimated:YES completion:nil];
}


@end



