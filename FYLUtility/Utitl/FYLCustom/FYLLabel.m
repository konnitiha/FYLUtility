//
//  FYLLabel.m
//  FYLUtility
//
//  Created by admin on 2018/4/17.
//  Copyright © 2018年 FuYunLei. All rights reserved.
//

#import "FYLLabel.h"

@interface FYLLabel ()

@property(nonatomic,strong)UIColor *originalBackgroundColor;
@property(nonatomic,strong)UILongPressGestureRecognizer *longGestureRecognize;

@end

@implementation FYLLabel


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setContentEdgeInsets:(UIEdgeInsets)contentEdgeInsets{
    _contentEdgeInsets = contentEdgeInsets;
    [self setNeedsDisplay];
}

- (CGSize)sizeThatFits:(CGSize)size{
    size = [super sizeThatFits:CGSizeMake(size.width - UIEdgeInsetsGetHorizontalValue(self.contentEdgeInsets), size.height - UIEdgeInsetsGetHorizontalValue(self.contentEdgeInsets))];
    size.width += UIEdgeInsetsGetHorizontalValue(self.contentEdgeInsets);
    size.height += UIEdgeInsetsGetVerticalValue(self.contentEdgeInsets);
    return size;
}

//固有大小   Autolayout 不设置尺寸约束时,以这个尺寸显示
- (CGSize)intrinsicContentSize{
    //self.preferredMaxLayoutWidth
    //label 没有明确的宽度约束时的最大宽度,如果<=0,则表示无限宽
    CGFloat preferredMaxLayoutWidth = self.preferredMaxLayoutWidth;
    if (preferredMaxLayoutWidth <= 0) {
        preferredMaxLayoutWidth = CGFLOAT_MAX;
    }
    return [self sizeThatFits:CGSizeMake(preferredMaxLayoutWidth, CGFLOAT_MAX)];
}

- (void)drawTextInRect:(CGRect)rect{
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.contentEdgeInsets)];
}

- (void)setHighlightBackgroundColor:(UIColor *)highlightBackgroundColor{
    _highlightBackgroundColor = highlightBackgroundColor;
    if (highlightBackgroundColor) {
        self.originalBackgroundColor = self.backgroundColor;
    }
}
- (void)setHighlighted:(BOOL)highlighted{
    [super setHighlighted:highlighted];
    if (self.highlightBackgroundColor) {
        self.backgroundColor = highlighted ? self.highlightBackgroundColor : self.originalBackgroundColor;
    }
}

#pragma mark - 长按复制
- (void)setCanPerformCopyAction:(BOOL)canPerformCopyAction{
    _canPerformCopyAction = canPerformCopyAction;
    if (_canPerformCopyAction && !self.longGestureRecognize) {
        self.userInteractionEnabled = YES;
        self.longGestureRecognize = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGestureRecognizer:)];
        [self addGestureRecognizer:self.longGestureRecognize];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleMenuWillHideNotification:) name:UIMenuControllerWillHideMenuNotification object:nil];
        
        if (!self.highlightBackgroundColor) {
            self.highlightBackgroundColor = [self.backgroundColor colorWithAlphaComponent:0.5];
        }
    }else if (!_canPerformCopyAction && self.longGestureRecognize){
        [self removeGestureRecognizer:self.longGestureRecognize];
        self.longGestureRecognize = nil;
        self.userInteractionEnabled = NO;
        
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }

}
- (void)handleLongPressGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer{
    if (!self.canPerformCopyAction) {
        return;
    }
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        [self becomeFirstResponder];
        
        UIMenuController *menuController = [UIMenuController sharedMenuController];
        UIMenuItem *copyItem = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyString:)];
        [menuController setMenuItems:@[copyItem]];
        [menuController setTargetRect:self.frame inView:self.superview];
        [menuController setMenuVisible:YES animated:YES];
        
        [self setHighlighted:YES];
    }else if (gestureRecognizer.state == UIGestureRecognizerStatePossible){
        [self setHighlighted:NO];
    }
}
- (void)handleMenuWillHideNotification:(NSNotification *)notification{
    if (!self.canPerformCopyAction) {
        return;
    }
    [self setHighlighted:NO];
}
- (BOOL)canBecomeFirstResponder{
    return self.canPerformCopyAction;
}
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    if ([self canBecomeFirstResponder]) {
        return action == @selector(copyString:);
    }
    return NO;
}
- (void)copyString:(id)sender{
    if (self.canPerformCopyAction) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        if (self.text) {
            pasteboard.string = self.text;
        }
    }
    
}

#pragma mark - Tool
CGFloat UIEdgeInsetsGetHorizontalValue(UIEdgeInsets edgeInsets){
    return edgeInsets.left - edgeInsets.right;
}

CGFloat UIEdgeInsetsGetVerticalValue(UIEdgeInsets edgeInsets){
    return edgeInsets.top - edgeInsets.bottom;
}

@end
