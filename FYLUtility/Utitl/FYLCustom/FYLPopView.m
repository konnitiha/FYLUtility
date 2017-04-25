//
//  FYLPopView.m
//  BATP
//
//  Created by eparking2 on 16/4/29.
//  Copyright © 2016年 eparking. All rights reserved.
//

#import "FYLPopView.h"
#import "UIView+FYLExt.h"


#define FYLRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width     //屏幕宽度
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height    //屏幕高度

#define kPopViewWidth 282
#define kPopViewHeight 220

@interface FYLPopView ()
{
    UIWindow *_window;
    UITapGestureRecognizer *_gesture;
    UIView *_view;
}

@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic,strong)UIActivityIndicatorView *indicatorView;

@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,copy)sure sure;

@property (strong, nonatomic) IBOutlet UIView *viewPop;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;

@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIButton *btnSure;


@end

@implementation FYLPopView
+ (void)showActionSheetControllerWithTitle:(NSString *)title message:(NSString *)message destructiveBtnTitle:(NSString *)destructiveTitle otherBtnTitles:(NSArray *)titles action:(fyl_sheet_action_handler)block inVc:(UIViewController *)vc
{
    UIAlertController *sheetController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    if (destructiveTitle != nil) {
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:destructiveTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            block(0);
        }];
        
        [sheetController addAction:action1];
    }
    
    int i = 1;
    for (NSString *item in titles) {
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:item style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            block(i);
        }];
         [sheetController addAction:action];
        i++;
    }
    
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        block(500);
    }];

    [sheetController addAction:action2];
    
    [vc presentViewController:sheetController animated:YES completion:nil];
}

+ (void)showAlertControllerWithTitle:(NSString *)title message:(NSString *)message sureBtnTitle:(NSString *)sureTitle otherBtnTitles:(NSArray *)titles action:(fyl_sheet_action_handler)block inVc:(UIViewController *)vc{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
   
    
    int i = 1;
    for (NSString *item in titles) {
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:item style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            block(i);
        }];
        [alertController addAction:action];
        i++;
    }
    if (sureTitle != nil) {
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:sureTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            block(0);
        }];
        
        [alertController addAction:action1];
    }
    
    [vc presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)cancel:(UIButton *)sender {
    [self close];
}
- (IBAction)sure:(UIButton *)sender {
    if (self.sure != nil) {
        _sure();
    }
    [self close];
}
+(FYLPopView *)sharePopView
{
    static FYLPopView *popView;
    static dispatch_once_t once;
    dispatch_once (&once ,^{
        popView = [[FYLPopView alloc]init];
    });
    return popView;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self loadNibFile];
}


-(instancetype)init{
    if (self = [super init]) {
//        [self.layer setAnchorPoint:CGPointMake(0.5, 0.5)];
        [self loadNibFile];
        
        [self addSubview:self.viewPop];
    }
    return self;
}
-(void)loadNibFile
{
    [[NSBundle mainBundle] loadNibNamed:@"FYLPopView" owner:self options:nil];
}
-(void)loadUIIsShowButton:(BOOL)isShowBtn{
    _btnCancel.layer.borderColor = FYLRGBA(153, 153, 153, 1).CGColor;
    _btnSure.layer.borderColor = FYLRGBA(59, 200, 219, 1).CGColor;
    

    _window = [UIApplication sharedApplication].keyWindow;
  
    _gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(close)];
    [_window addGestureRecognizer:_gesture];
    _view = [[UIView alloc]initWithFrame:_window.bounds];
    _view.backgroundColor = FYLRGBA(0, 0, 0, 0.2);
    [_window addSubview:_view];
    
    self.transform = CGAffineTransformIdentity;
    if (isShowBtn) {
        self.fyl_size = CGSizeMake(kPopViewWidth, kPopViewHeight);
        self.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    }else
    {
        self.fyl_size = CGSizeMake(kPopViewWidth, kPopViewHeight-41);
        self.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2+20.5);
    }

   [_view addSubview:self];
    self.transform = CGAffineTransformMakeScale(0.1, 0.1);
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.viewPop.frame = self.bounds;
}

#pragma mark 打开与关闭方法

+(void)showViewWithTitle:(NSString *)title
{
    [self showViewWithTitle:title aotuHidden:0];

}
+(void)showViewWithTitle:(NSString *)title aotuHidden:(CGFloat)duration
{
    
    FYLPopView *view = [FYLPopView sharePopView];
//    [view loadNibFile];
    [view loadUIIsShowButton:duration == 0? YES : NO];
    
    view.labelTitle.text = title;
    [UIView animateWithDuration:0.3 animations:^{
        view.transform = CGAffineTransformIdentity;
    }];
    if (duration != 0) {
        view.timer = [NSTimer scheduledTimerWithTimeInterval:duration target:view selector:@selector(close) userInfo:nil repeats:NO];
    }
    
}
+(void)showViewWithTitle:(NSString *)title withComplete:(sure)sure
{
    FYLPopView *view = [FYLPopView sharePopView];
//    [view loadNibFile];
    [view loadUIIsShowButton:YES];
    
    view.sure = sure;
    
    view.labelTitle.text = title;
    [UIView animateWithDuration:0.3 animations:^{
        view.transform = CGAffineTransformIdentity;
    }];
}

-(void)close{
  
    [self.timer invalidate];
    [_window removeGestureRecognizer:_gesture];
    _gesture = nil;
    
    __weak FYLPopView *ws = self;
    [UIView animateWithDuration:0.2 animations:^{
        ws.transform = CGAffineTransformMakeScale(0.1, 0.1);
    } completion:^(BOOL finished) {
        ws.transform = CGAffineTransformIdentity;
        [_view removeFromSuperview];
        _timer = nil;
        _sure = nil;
    }];
}

#pragma mark - 活动指示器
+(void)showActivityIndicatorView
{
    FYLPopView *view = [FYLPopView sharePopView];
    [view hideActivityIndicatorView];
    [view showActivityIndicatorView];
   
}
//+ (void)addAFHTTPRequestOperationToActivityIndicatorView:(AFHTTPRequestOperation *)op
//{
//    FYLPopView *view = [FYLPopView sharePopView];
//    view.op = op;
//}
- (void)showActivityIndicatorView
{
    _window = [UIApplication sharedApplication].keyWindow;

    _view = [[UIView alloc]initWithFrame:_window.bounds];
    _view.backgroundColor = FYLRGBA(0, 0, 0, 0.2);
    [_window addSubview:_view];
    _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancleOP)];
    [_view addGestureRecognizer:tap];
    [_view addSubview:_indicatorView];
    _indicatorView.center = _view.center;
    [_indicatorView startAnimating];
}
- (void)cancleOP
{
//    FYLPopView *view = [FYLPopView sharePopView];
//    
//    if (view.op != nil) {
//        [view.op cancel];
//       [view hideActivityIndicatorView];
//    }
}

+(void)hideActivityIndicatorView
{
    FYLPopView *view = [FYLPopView sharePopView];
//    view.op = nil;
    [view hideActivityIndicatorView];
}
- (void)hideActivityIndicatorView
{
    [_indicatorView stopAnimating];
    [_view removeFromSuperview];
}

@end
