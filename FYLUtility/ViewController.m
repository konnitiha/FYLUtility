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
    
    
    [viewCenter fyl_FillReferView:self.view insets:UIEdgeInsetsMake(10, 20, 30, 40)];
    
}


@end
