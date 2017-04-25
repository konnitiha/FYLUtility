//
//  FYLBtn.m
//  QinYueHui
//
//  Created by FuYunLei on 2017/4/6.
//  Copyright © 2017年 FuYunLei. All rights reserved.
//

#import "FYLBtn.h"
#import "UIView+FYLExt.h"

@interface FYLBtn()

@property(nonatomic,strong)UIImageView *fyl_imageView;
@property(nonatomic,strong)UILabel *fyl_titleLabel;
@property(nonatomic,strong)UIView *fyl_maskView;

@end

@implementation FYLBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    [self setupUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    self.fyl_imageView = [[UIImageView alloc] init];
    [self addSubview:self.fyl_imageView];
    
    self.fyl_titleLabel = [[UILabel alloc] init];
    self.fyl_titleLabel.font = self.titleLabel.font;
    self.fyl_titleLabel.textColor = self.currentTitleColor;
    [self addSubview:self.fyl_titleLabel];
    
    self.fyl_maskView = [[UIView alloc] initWithFrame:self.bounds];
    self.fyl_maskView.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.3];
    self.fyl_maskView.hidden = YES;
    
    [self addSubview:self.fyl_maskView];
    
    self.imageView.hidden = YES;
    self.titleLabel.hidden = YES;

}
- (void)layoutSubviews{
    [self setSubViewsFrame];
}

- (void)setSubViewsFrame{

    UIImage *image = self.currentImage;
    CGSize imageSize = image.size;
    
    self.fyl_imageView.image = image;
    [self.fyl_imageView setFrame:CGRectMake(self.fyl_w/2-imageSize.width/2, self.fyl_h*0.34-imageSize.height/2, imageSize.width, imageSize.height)];
    
    self.fyl_titleLabel.text = self.currentTitle;
    self.fyl_titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.fyl_titleLabel setFrame:CGRectMake(0, self.fyl_imageView.fyl_bottom + 10, self.fyl_w, self.titleLabel.intrinsicContentSize.height)];
    
    [self.fyl_maskView setFrame:self.bounds];
}


- (void)setImage:(UIImage *)image forState:(UIControlState)state{
    [super setImage:image forState:state];
    
    CGSize imageSize = image.size;
    
    self.fyl_imageView.image = image;
    [self.fyl_imageView setFrame:CGRectMake(self.fyl_w/2-imageSize.width/2, self.fyl_h*0.4-imageSize.height/2, imageSize.width, imageSize.height)];
 
}
- (void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super setTitle:title forState:state];
    
    self.fyl_titleLabel.text = title;
    self.fyl_titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.fyl_titleLabel setFrame:CGRectMake(0, self.fyl_imageView.fyl_bottom + 10, self.fyl_w, 0)];
    [self.fyl_titleLabel sizeToFit];
}

- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state{
    [super setTitleColor:color forState:state];
    self.fyl_titleLabel.textColor = color;

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    self.fyl_maskView.hidden = NO;
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    self.fyl_maskView.hidden = YES;
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesCancelled:touches withEvent:event];
    self.fyl_maskView.hidden = YES;
}


@end
