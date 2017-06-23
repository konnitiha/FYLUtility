//
//  UIView+FYLExt.h
//  享泊享停车
//
//  Created by eparking2 on 16/2/19.
//  Copyright © 2016年 eparking. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FYLExt)

@property(nonatomic,assign)CGFloat fyl_x;
@property(nonatomic,assign)CGFloat fyl_y;
@property(nonatomic,assign)CGFloat fyl_w;
@property(nonatomic,assign)CGFloat fyl_h;
@property(nonatomic,assign)CGFloat fyl_right;
@property(nonatomic,assign)CGFloat fyl_bottom;
@property(nonatomic,assign)CGFloat fyl_centerX;
@property(nonatomic,assign)CGFloat fyl_centerY;
@property(nonatomic,assign)CGSize fyl_size;
@property(nonatomic,assign)CGPoint fyl_origin;

/**
 圆角
 */
@property (nonatomic,assign)IBInspectable CGFloat fyl_cornerRadius;
/**
 *  边框颜色
 */
@property IBInspectable UIColor *fyl_bordColor;

/**
 *  边框宽度
 */
@property IBInspectable CGFloat fyl_borderWidth;
- (void)FYLMoveBy:(CGPoint)delta;
- (void)FYLScaleBy:(CGFloat)scaleFactor;
- (void)addShadow:(UIColor *)color opacity:(CGFloat)opacity radius:(CGFloat)radius offset:(CGSize)offset;
/**
 *  获取view的viewController
 *
 *  @return 返回view的viewController
 */
- (UIViewController*)FYLViewController;

/**
 *  删除view里的所有子view
 */
- (void)FYLRemoveAllChildren;

/**
 *  初始化xib
 *
 */
+ (instancetype)FYLViewFromXib;

@end


typedef NS_ENUM(NSUInteger, FYL_AnimatonType) {
    FYL_AnimatonTypeFade,
    FYL_AnimatonTypePush,
    FYL_AnimatonTypeReveal,
    FYL_AnimatonTypeMoveIn,
    FYL_AnimatonTypeCube,
    FYL_AnimatonTypeSuckEffect,
    FYL_AnimatonTypeOglFlip,
    FYL_AnimatonTypeErippleEffect,
    FYL_AnimatonTypePageCurl,
    FYL_AnimatonTypePageUnCurl,
    FYL_AnimatonTypeCameraIrisHollowOpen,
    FYL_AnimatonTypeCameraIrisHollowClose,
};

typedef NS_ENUM(NSUInteger, FYL_AnimatonSubType) {
    FYL_AnimatonSubTypeFromTop,
    FYL_AnimatonSubTypeFromBottom,
    FYL_AnimatonSubTypeFromLeft,
    FYL_AnimatonSubTypeFromRight,
};

@interface UIView (Animation)

- (void)addAnimationWithType:(FYL_AnimatonType)animationType WithSubtype:(FYL_AnimatonSubType)subType;

@end

typedef NS_ENUM(NSUInteger, FYL_AlignType) {
    FYL_AlignTypeTopLeft,
    FYL_AlignTypeTopRight,
    FYL_AlignTypeTopCenter,
    FYL_AlignTypeBottomLeft,
    FYL_AlignTypeBottomRight,
    FYL_AlignTypeBottomCenter,
    FYL_AlignTypeCenterLeft,
    FYL_AlignTypeCenterRight,
    FYL_AlignTypeCenter,
};

@interface UIView (AutoLayout)


/**
 填充视图

 @param referView 参考视图
 @param insets 间距
 @return 约束数组
 */
- (NSArray<__kindof NSLayoutConstraint *> *)fyl_FillReferView:(UIView *)referView insets:(UIEdgeInsets)insets;

/**
 参照参考视图内部对齐

 @param type 对齐方式
 @param referView 参考视图
 @param size 视图大小
 @param offset 偏移量
 @return 约束数组
 */
- (NSArray<__kindof NSLayoutConstraint *> *)fyl_AlignInner:(FYL_AlignType)type referView:(UIView *)referView size:(CGSize)size offset:(CGPoint)offset;

/**
 参照参考视图垂直对齐
 
 @param type 对齐方式
 @param referView 参考视图
 @param size 视图大小
 @param offset 偏移量
 @return 约束数组
 */
- (NSArray<__kindof NSLayoutConstraint *> *)fyl_AlignVertical:(FYL_AlignType)type referView:(UIView *)referView size:(CGSize)size offset:(CGPoint)offset;
/**
 参照参考视图水平对齐
 
 @param type 对齐方式
 @param referView 参考视图
 @param size 视图大小
 @param offset 偏移量
 @return 约束数组
 */
- (NSArray<__kindof NSLayoutConstraint *> *)fyl_AlignHorizontal:(FYL_AlignType)type referView:(UIView *)referView size:(CGSize)size offset:(CGPoint)offset;


/**
 当前视图内,水平平铺控件

 @param views 子视图数组
 @param insets 间距
 @return 约束数组
 */
- (NSArray<__kindof NSLayoutConstraint *> *)fyl_HorizontalTile:(NSArray *)views insets:(UIEdgeInsets)insets;
/**
 当前视图内,垂直平铺控件
 
 @param views 子视图数组
 @param insets 间距
 @return 约束数组
 */
- (NSArray<__kindof NSLayoutConstraint *> *)fyl_VerticalTile:(NSArray *)views insets:(UIEdgeInsets)insets;



/**
 从约束数组中查找指定 attribute 的约束

 @param constraintsList 约束数组
 @param attribute 约束属性
 @return 对应的约束
 */
- (NSLayoutConstraint *)fyl_Constraint:(NSArray<__kindof NSLayoutConstraint *> *)constraintsList attribute:(NSLayoutAttribute)attribute;

@end


@interface FYL_LayoutAttributes : NSObject


@property(nonatomic,assign)NSLayoutAttribute horizontal;
@property(nonatomic,assign)NSLayoutAttribute referHorizontal;
@property(nonatomic,assign)NSLayoutAttribute vertical;
@property(nonatomic,assign)NSLayoutAttribute referVertical;

+ (instancetype)layoutAttributesWithType:(FYL_AlignType)type isInner:(BOOL)isInner isVertical:(BOOL)isVertical;

@end
