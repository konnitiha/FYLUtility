//
//  ViewController.m
//  FYLUtility
//
//  Created by FuYunLei on 2017/4/25.
//  Copyright © 2017年 FuYunLei. All rights reserved.
//

#import "ViewController.h"
#import "FYLHeader.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIView *viewCenter = [[UIView alloc] init];
    viewCenter.backgroundColor = [UIColor redColor];
    [self.view addSubview:viewCenter];
    
    
    FYLLabel *label = [[FYLLabel alloc] initWithFrame:CGRectMake(12, 244, 200, 40)];
    label.backgroundColor = UIColor.orangeColor;
    label.text = @"普通Label";
    [self.view addSubview:label];
    
    FYLLabel *label1 = [[FYLLabel alloc] initWithFrame:CGRectMake(12, 64, 200, 40)];
    label1.backgroundColor = UIColor.orangeColor;
    label1.contentEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);
    label1.text = @"测试EdgeInsets";
    [self.view addSubview:label1];
    
   
    FYLLabel *label2 = [[FYLLabel alloc] initWithFrame:CGRectMake(12, 124, 200, 40)];
    label2.backgroundColor = UIColor.orangeColor;
    label2.highlightBackgroundColor = UIColor.blueColor;
    label2.text = @"测试高亮";
    [self.view addSubview:label2];
    
    FYLLabel *label3 = [[FYLLabel alloc] initWithFrame:CGRectMake(12, 184, 200, 40)];
    label3.backgroundColor = UIColor.orangeColor;
    label3.canPerformCopyAction = YES;
    label3.text = @"测试复制";
    [self.view addSubview:label3];
    
}


@end
