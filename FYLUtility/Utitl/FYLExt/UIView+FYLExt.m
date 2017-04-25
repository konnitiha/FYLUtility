//
//  UIView+FYLExt.m
//  享泊享停车
//
//  Created by eparking2 on 16/2/19.
//  Copyright © 2016年 eparking. All rights reserved.
//

#import "UIView+FYLExt.h"

@implementation UIView (FYLExt)
-(CGFloat)fyl_x{
    return self.frame.origin.x;
}

- (void)setFyl_x:(CGFloat)fyl_x{
    CGRect frame=self.frame;
    frame.origin.x=fyl_x;
    self.frame=frame;
}


- (CGFloat)fyl_y{
    return self.frame.origin.y;
}
- (void)setFyl_y:(CGFloat)fyl_y{
    CGRect frame=self.frame;
    frame.origin.y=fyl_y;
    self.frame=frame;
}

- (CGFloat)fyl_w{
    return self.frame.size.width;
}
- (void)setFyl_w:(CGFloat)fyl_w{
    CGRect frame=self.frame;
    frame.size.width=fyl_w;
    self.frame=frame;
}


- (CGFloat)fyl_h{
    return self.frame.size.height;
}
- (void)setFyl_h:(CGFloat)fyl_h{
    CGRect frame=self.frame;
    frame.size.height=fyl_h;
    self.frame=frame;
}

- (CGFloat)fyl_right{
    return self.frame.size.width + self.frame.origin.x;
}
- (void)setFyl_right:(CGFloat)fyl_right{
    CGRect frame=self.frame;
    frame.origin.x=fyl_right - frame.size.width;
    self.frame=frame;
}

- (CGFloat)fyl_bottom{
    return self.frame.size.height + self.frame.origin.y;
}
- (void)setFyl_bottom:(CGFloat)fyl_bottom{
    CGRect frame=self.frame;
    frame.origin.y=fyl_bottom - frame.size.height;
    self.frame=frame;
}

- (CGFloat)fyl_centerX{
    return self.center.x;
}
- (void)setFyl_centerX:(CGFloat)fyl_centerX{
    CGPoint center = self.center;
    center.x = fyl_centerX;
    self.center = center;
}

- (CGFloat)fyl_centerY{
    return self.center.y;
}
- (void)setFyl_centerY:(CGFloat)fyl_centerY{
    CGPoint center = self.center;
    center.y = fyl_centerY;
    self.center = center;
}

- (CGSize)fyl_size{
    return self.frame.size;
}
- (void)setFyl_size:(CGSize)fyl_size{
    CGRect frame = self.frame;
    frame.size.width = fyl_size.width;
    frame.size.height = fyl_size.height;
    self.frame = frame;
}

- (CGPoint)fyl_origin{
    return self.frame.origin;
}
- (void)setFyl_origin:(CGPoint)fyl_origin{
    CGRect frame = self.frame;
    frame.origin.x = fyl_origin.x;
    frame.origin.y = fyl_origin.y;
    self.frame = frame;
}

- (CGFloat)fyl_cornerRadius{
    return self.layer.cornerRadius;
}
- (void)setFyl_cornerRadius:(CGFloat)fyl_cornerRadius{
    self.layer.cornerRadius = fyl_cornerRadius;
    self.layer.masksToBounds = fyl_cornerRadius>0;
}

- (UIColor *)fyl_bordColor{
    return nil;
}
- (void)setFyl_bordColor:(UIColor *)fyl_bordColor{
    self.layer.borderColor = fyl_bordColor.CGColor;
}


- (CGFloat)fyl_borderWidth{
    return self.layer.borderWidth;
}
- (void)setFyl_borderWidth:(CGFloat)fyl_borderWidth{
    self.layer.borderWidth = fyl_borderWidth;
}


// Move via offset
- (void)FYLMoveBy:(CGPoint)delta {
    CGPoint newcenter = self.center;
    newcenter.x       += delta.x;
    newcenter.y       += delta.y;
    self.center       = newcenter;
}

// Scaling
- (void)FYLScaleBy:(CGFloat)scaleFactor {
    CGRect newframe      = self.frame;
    newframe.size.width  *= scaleFactor;
    newframe.size.height *= scaleFactor;
    self.frame           = newframe;
}

- (void)addShadow:(UIColor *)color opacity:(CGFloat)opacity radius:(CGFloat)radius offset:(CGSize)offset{
    self.layer.shadowOpacity = opacity;// 阴影透明度
    self.layer.shadowColor = color.CGColor;// 阴影的颜色
    self.layer.shadowRadius = radius;// 阴影扩散的范围控制
    self.layer.shadowOffset  = offset;// 阴影的范围
}

- (UIViewController*)FYLViewController {
    
    UIResponder *nextResponder =  self;
    
    do {
        nextResponder = [nextResponder nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
            return (UIViewController*)nextResponder;
    } while (nextResponder != nil);
    
    return nil;
}

-(void)FYLRemoveAllChildren{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
}

+ (instancetype)FYLViewFromXib
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

@end



@implementation UIView (AutoLayout)


- (NSArray<__kindof NSLayoutConstraint *> *)fyl_FillReferView:(UIView *)referView insets:(UIEdgeInsets)insets{

    self.translatesAutoresizingMaskIntoConstraints = NO;

    NSMutableArray *cons = [NSMutableArray array];
    
    CGFloat left = insets.left;
    CGFloat right = insets.right;
    CGFloat top = insets.top;
    CGFloat bottom = insets.bottom;
    
    [cons addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-\(left)-[self]-\(right)-|" options:NSLayoutFormatAlignAllLastBaseline metrics:@{@"left":@(left),@"right":@(right)} views:NSDictionaryOfVariableBindings(self)]];

    [cons addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-\(top)-[self]-\(bottom)-|" options:NSLayoutFormatAlignAllLastBaseline metrics:@{@"top":@(top),@"bottom":@(bottom)} views:NSDictionaryOfVariableBindings(self)]];
   
    [self.superview addConstraints:cons];
    
    return cons;
}
- (NSArray<__kindof NSLayoutConstraint *> *)fyl_AlignInner:(FYL_AlignType)type referView:(UIView *)referView size:(CGSize)size offset:(CGPoint)offset{
    
    return [self fyl_AlignLayoutReferView:referView attributes:[FYL_LayoutAttributes layoutAttributesWithType:type isInner:YES isVertical:YES] size:size offset:offset];

}
- (NSArray<__kindof NSLayoutConstraint *> *)fyl_AlignVertical:(FYL_AlignType)type referView:(UIView *)referView size:(CGSize)size offset:(CGPoint)offset{
    
    return [self fyl_AlignLayoutReferView:referView attributes:[FYL_LayoutAttributes layoutAttributesWithType:type isInner:NO isVertical:YES] size:size offset:offset];
    
}
- (NSArray<__kindof NSLayoutConstraint *> *)fyl_AlignHorizontal:(FYL_AlignType)type referView:(UIView *)referView size:(CGSize)size offset:(CGPoint)offset{
    
    return [self fyl_AlignLayoutReferView:referView attributes:[FYL_LayoutAttributes layoutAttributesWithType:type isInner:NO isVertical:NO] size:size offset:offset];
    
}
- (NSArray<__kindof NSLayoutConstraint *> *)fyl_HorizontalTile:(NSArray *)views insets:(UIEdgeInsets)insets{
    
    NSAssert(views.count != 0, @"views should not be empty");
    
     NSMutableArray *cons = [NSMutableArray array];
    
    UIView *firstView = views[0];
    
    [firstView fyl_AlignInner:FYL_AlignTypeTopLeft referView:self size:CGSizeZero offset:CGPointMake(insets.left, insets.top)];
    [cons addObject:[NSLayoutConstraint constraintWithItem:firstView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-insets.bottom]];
    
    
    UIView *preView = firstView;
    for (int i = 1; i<views.count; i++) {
        UIView *subView = views[i];
        [cons addObjectsFromArray:[subView fyl_SizeConstraintsWithReferView:firstView]];
        [subView fyl_AlignHorizontal:FYL_AlignTypeTopRight referView:preView size:CGSizeZero offset:CGPointMake(insets.right, 0)];
        preView = subView;
    }
    
    UIView *lastView = views.lastObject;
     [cons addObject:[NSLayoutConstraint constraintWithItem:lastView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-insets.right]];

    [self addConstraints:cons];
    return cons;
}
- (NSArray<__kindof NSLayoutConstraint *> *)fyl_VerticalTile:(NSArray *)views insets:(UIEdgeInsets)insets{
    
    NSAssert(views.count != 0, @"views should not be empty");
    
    NSMutableArray *cons = [NSMutableArray array];
    
    UIView *firstView = views[0];
    
    [firstView fyl_AlignInner:FYL_AlignTypeTopLeft referView:self size:CGSizeZero offset:CGPointMake(insets.left, insets.top)];
    [cons addObject:[NSLayoutConstraint constraintWithItem:firstView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-insets.right]];
    
    
    UIView *preView = firstView;
    for (int i = 1; i<views.count; i++) {
        UIView *subView = views[i];
        [cons addObjectsFromArray:[subView fyl_SizeConstraintsWithReferView:firstView]];
        [subView fyl_AlignVertical:FYL_AlignTypeBottomLeft referView:preView size:CGSizeZero offset:CGPointMake(0, insets.bottom)];
        preView = subView;
    }
    
    UIView *lastView = views.lastObject;
    [cons addObject:[NSLayoutConstraint constraintWithItem:lastView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-insets.bottom]];
    
    [self addConstraints:cons];
    return cons;
}

- (NSLayoutConstraint *)fyl_Constraint:(NSArray<__kindof NSLayoutConstraint *> *)constraintsList attribute:(NSLayoutAttribute)attribute{

    for (NSLayoutConstraint *constraint in constraintsList) {
        
        if (constraint.firstItem == self && constraint.firstAttribute == attribute) {
            return constraint;
        }
    }

    return nil;
}

#pragma mark - 私有函数
- (NSArray<__kindof NSLayoutConstraint *> *)fyl_AlignLayoutReferView:(UIView *)referView attributes:(FYL_LayoutAttributes *)attributes size:(CGSize)size offset:(CGPoint)offset{
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSMutableArray *cons = [NSMutableArray array];
    
    [cons addObjectsFromArray:[self fyl_PositionConstraintsReferView:referView attributes:attributes offset:offset]];
    
    
    if (!CGSizeEqualToSize(size, CGSizeZero)) {
        
        [cons addObjectsFromArray:[self fyl_SizeConstraintsWithSize:size]];
    }
    
    [self.superview addConstraints:cons];
    
    return cons;
}
- (NSArray<__kindof NSLayoutConstraint *> *)fyl_SizeConstraintsWithSize:(CGSize)size{
    
    NSMutableArray *cons = [NSMutableArray array];
    
    [cons addObject: [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:size.width]];
    [cons addObject: [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:size.height]];
    
    return cons;
}
- (NSArray<__kindof NSLayoutConstraint *> *)fyl_SizeConstraintsWithReferView:(UIView *)referView{
    
    NSMutableArray *cons = [NSMutableArray array];
    
    [cons addObject: [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:referView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
    [cons addObject: [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:referView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0]];

    return cons;
}

- (NSArray<__kindof NSLayoutConstraint *> *)fyl_PositionConstraintsReferView:(UIView *)referView attributes:(FYL_LayoutAttributes *)attributes offset:(CGPoint)offset{

    NSMutableArray *cons = [NSMutableArray array];
    
    [cons addObject: [NSLayoutConstraint constraintWithItem:self attribute:attributes.horizontal relatedBy:NSLayoutRelationEqual toItem:referView attribute:attributes.referHorizontal multiplier:1.0 constant:offset.x]];
    [cons addObject: [NSLayoutConstraint constraintWithItem:self attribute:attributes.vertical relatedBy:NSLayoutRelationEqual toItem:referView attribute:attributes.referVertical multiplier:1.0 constant:offset.y]];


    return cons;
}

@end


@implementation FYL_LayoutAttributes

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.horizontal = NSLayoutAttributeLeft;
        self.referHorizontal = NSLayoutAttributeLeft;
        self.vertical = NSLayoutAttributeTop;
        self.referVertical = NSLayoutAttributeTop;
    }
    return self;
}
- (instancetype)initWithHorizontal:(NSLayoutAttribute)horizontal referHorizontal:(NSLayoutAttribute)referHorizontal vertical:(NSLayoutAttribute)vertical referVertical:(NSLayoutAttribute)referVertical
{
    self = [super init];
    if (self) {
        self.horizontal = horizontal;
        self.referHorizontal = referHorizontal;
        self.vertical = vertical;
        self.referVertical = referVertical;
    }
    return self;
}

- (instancetype)horizontalsFrom:(NSLayoutAttribute)from to:(NSLayoutAttribute)to
{

    self.horizontal = from;
    self.referHorizontal = to;
    
    return self;
}
- (instancetype)verticals:(NSLayoutAttribute)from to:(NSLayoutAttribute)to
{

    self.vertical = from;
    self.referVertical = to;
 
    return self;
}
+ (instancetype)layoutAttributesWithType:(FYL_AlignType)type isInner:(BOOL)isInner isVertical:(BOOL)isVertical
{
    FYL_LayoutAttributes * attributes = [[FYL_LayoutAttributes alloc] init];
    
    switch (type) {
        case FYL_AlignTypeTopLeft:
        {
            [[attributes horizontalsFrom:NSLayoutAttributeLeft to:NSLayoutAttributeLeft] verticals:NSLayoutAttributeTop to:NSLayoutAttributeTop];
            if (isInner) {
                return attributes;
            }else if (isVertical){
                return [attributes verticals:NSLayoutAttributeBottom to:NSLayoutAttributeTop];
            }else{
                return [attributes horizontalsFrom:NSLayoutAttributeRight to:NSLayoutAttributeLeft];
            }
        }
            break;
        case FYL_AlignTypeTopRight:
        {
            [[attributes horizontalsFrom:NSLayoutAttributeRight to:NSLayoutAttributeRight] verticals:NSLayoutAttributeTop to:NSLayoutAttributeTop];
            if (isInner) {
                return attributes;
            }else if (isVertical){
                return [attributes verticals:NSLayoutAttributeBottom to:NSLayoutAttributeTop];
            }else{
                return [attributes horizontalsFrom:NSLayoutAttributeLeft to:NSLayoutAttributeRight];
            }
        }
            break;
        case FYL_AlignTypeBottomLeft:
        {
            [[attributes horizontalsFrom:NSLayoutAttributeLeft to:NSLayoutAttributeLeft] verticals:NSLayoutAttributeBottom to:NSLayoutAttributeBottom];
            if (isInner) {
                return attributes;
            }else if (isVertical){
                return [attributes verticals:NSLayoutAttributeTop to:NSLayoutAttributeBottom];
            }else{
                return [attributes horizontalsFrom:NSLayoutAttributeRight to:NSLayoutAttributeLeft];
            }
        }
            break;
        case FYL_AlignTypeBottomRight:
        {
            [[attributes horizontalsFrom:NSLayoutAttributeRight to:NSLayoutAttributeRight] verticals:NSLayoutAttributeBottom to:NSLayoutAttributeBottom];
            if (isInner) {
                return attributes;
            }else if (isVertical){
                return [attributes verticals:NSLayoutAttributeTop to:NSLayoutAttributeBottom];
            }else{
                return [attributes horizontalsFrom:NSLayoutAttributeLeft to:NSLayoutAttributeRight];
            }
        }
            break;
        case FYL_AlignTypeTopCenter:
        {
            [[attributes horizontalsFrom:NSLayoutAttributeCenterX to:NSLayoutAttributeCenterX] verticals:NSLayoutAttributeTop to:NSLayoutAttributeTop];
            if (isInner) {
                return attributes;
            }else{
                return [attributes verticals:NSLayoutAttributeBottom to:NSLayoutAttributeTop];
            }
        }
            break;
        case FYL_AlignTypeBottomCenter:
        {
            [[attributes horizontalsFrom:NSLayoutAttributeCenterX to:NSLayoutAttributeCenterX] verticals:NSLayoutAttributeBottom to:NSLayoutAttributeBottom];
            if (isInner) {
                return attributes;
            }else{
                return [attributes verticals:NSLayoutAttributeTop to:NSLayoutAttributeBottom];
            }
        }
            break;
        case FYL_AlignTypeCenterLeft:
        {
            [[attributes horizontalsFrom:NSLayoutAttributeLeft to:NSLayoutAttributeLeft] verticals:NSLayoutAttributeCenterY to:NSLayoutAttributeCenterY];
            if (isInner) {
                return attributes;
            }else{
                return [attributes horizontalsFrom:NSLayoutAttributeRight to:NSLayoutAttributeLeft];
            }
        }
            break;
        case FYL_AlignTypeCenterRight:
        {
            [[attributes horizontalsFrom:NSLayoutAttributeRight to:NSLayoutAttributeRight] verticals:NSLayoutAttributeCenterY to:NSLayoutAttributeCenterY];
            if (isInner) {
                return attributes;
            }else{
                return [attributes horizontalsFrom:NSLayoutAttributeLeft to:NSLayoutAttributeRight];
            }
        }
            break;
        case FYL_AlignTypeCenter:
        {
            
            return [[FYL_LayoutAttributes alloc] initWithHorizontal:NSLayoutAttributeCenterX referHorizontal:NSLayoutAttributeCenterX vertical:NSLayoutAttributeCenterY referVertical:NSLayoutAttributeCenterY];
        }
            break;
            
        default:
            break;
    }
    return attributes;
}



@end

