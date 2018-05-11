//
//  Person.h
//  FYLUtility
//
//  Created by admin on 2018/5/11.
//  Copyright © 2018年 FuYunLei. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Dog;

@interface Person : NSObject

@property(nonatomic,strong)NSString *idd;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *age;
@property(nonatomic,strong)Dog *dog;

@end


@interface Dog : NSObject

@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *age;

@end
