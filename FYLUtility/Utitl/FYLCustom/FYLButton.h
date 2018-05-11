//
//  FYLButton.h
//  FYLUtility
//
//  Created by admin on 2018/4/18.
//  Copyright © 2018年 FuYunLei. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, FYLButtonImagePosition) {
    FYLButtonImagePositionTop,
    FYLButtonImagePositionLeft,
    FYLButtonImagePositionBottom,
    FYLButtonImagePositionRight,
};

typedef NS_ENUM(NSUInteger, FYLGhostButtonColor) {
    FYLGhostButtonColorBlue,
    FYLGhostButtonColorRed,
    FYLGhostButtonColorGreen,
    FYLGhostButtonColorGray,
    FYLGhostButtonColorWhite,
};

typedef NS_ENUM(NSUInteger, FYLFillButtonColor) {
    FYLFillButtonColorBlue,
    FYLFillButtonColorRed,
    FYLFillButtonColorGreen,
    FYLFillButtonColorGray,
    FYLFillButtonColorWhite,
};

typedef NS_ENUM(NSUInteger, FYLNavigationButtonType) {
    FYLNavigationButtonTypeNormal,
    FYLNavigationButtonTypeBold,
    FYLNavigationButtonTypeImage,
    FYLNavigationButtonTypeBack,
};

typedef NS_ENUM(NSUInteger, FYLToolbarButtonType) {
    FYLToolbarButtonTypeNormal,
    FYLToolbarButtonTypeRed,
    FYLToolbarButtonTypeImage,
};

typedef NS_ENUM(NSInteger, FYLNavigationButtonPosition) {
    FYLNavigationButtonPositionNone = -1,
    FYLNavigationButtonPositionLeft,
    FYLNavigationButtonPositionRight,
};

/**
 * 提供以下功能
 * 1.highlighted,disabled状态均通过改变整个按钮的alpha来实现,无需分别设置不同state下的titleColor,image. alpha的值可在配置表里修改  ButtonHighlightedAlpha,ButtonDisableAlpha.
 * 2.支持点击时改变背景色 (highlightedBackgroundColor)
 * 3.支持点击时改变边框颜色 (highlightedBorderColor)
 * 4.支持设置图片相对于 titleLabel 的位置 (imagePosition)
 * 5.支持设置图片和 titleLabel 之间的间距,无需自行调整 titleEdgeInsets,imageEdgeInsets (spacingBetweenImageAndTitle)
 
 */
@interface FYLButton : UIButton

/**
 * 让按钮的文字颜色自动跟随tintColor调整 <br/>
 * 默认为NO
 */
@property(nonatomic,assign)IBInspectable BOOL adjustsTitleTintColorAutomatically;

/**
 * 让按钮的图片颜色自动跟随tintColor调整 <br/>
 * 默认为NO
 */
@property(nonatomic,assign)IBInspectable BOOL adjustsImageTintColorAutomatically;

/**
 * 等价于 adjustsTitleTintColorAutomatically = YES & adjustsImageTintColorAutomatically = YES & tintColor = xxx
 * @note 一般只使用这个属性的 setter,而 getter 永远返回 self.tintColor
 * @warning 不支持传nil
 */
@property(nonatomic,strong)IBInspectable UIColor *tintColorAdjustsTitleAndImage;

/**
 * 是否自动调整highlighted时的按钮样式,默认为YES. <br/>
 * 当值为YES时,按钮highlighted时会改变自身的alpha属性为<b>ButtonHighlightedAlpha</b>
 */
@property(nonatomic,assign)IBInspectable BOOL adjustsButtonWhenHighlighted;

/**
 * 是否自动调整disabled时的按钮样式,默认为YES. <br/>
 * 当值为YES时,按钮disabled时会改变自身的alpha属性为<b>ButtonDisableAlpha</b>
 */
@property(nonatomic,assign)IBInspectable BOOL adjustsButtonWhenDisabled;

/**
 * 设置按钮点击时的背景色,默认为nil
 * @warning 不支持带透明度的颜色.当设置highlightedBackgroundColor时,会强制把adjustsButtonWhenHighlighted设为NO,避免两者效果冲突.
 * @see adjustsButtonWhenHighlighted
 */
@property(nonatomic,strong,nullable)IBInspectable UIColor *highlightedBackgroundColor;

/**
 * 设置按钮点击时的边框颜色,默认为nil
 * @warning 当设置highlightedBorderColor时,会强制把adjustsButtonWhenHighlighted设为NO,避免两者效果冲突.
 * @see adjustsButtonWhenHighlighted
 */
@property(nonatomic,strong,nullable)IBInspectable UIColor *highlightedBorderColor;

/**
 * 设置按钮里图标和文字的相对位置,默认为 FYLButtonImagePositionLeft<br/>
 * 可配合imageEdgeInsets,titleEdgeInsets,conteneHorizontalAligment,contentVerticalAligment使用
 */
@property(nonatomic,assign)FYLButtonImagePosition imagePosition;

/**
 * 设置按钮里图标和文字之间的间隔,会自动响应 imagePosition 的变化而变化,默认为0. <br/>
 * 系统默认实现需同时设置 titleEdgeInsets 和imageEdgeInsets,同时还需考虑 contentEdgeInsets 的增加 (否则不会影响布局,可能会让图标或者文字溢出或挤压),使用该属性可以避免以上情况.<br/>
 * @warning 会与 titleEdgeInsets,imageEdgeInsets,contentEdgeInsets 共同作用.
 */
@property(nonatomic,assign)IBInspectable CGFloat spacingBetweenImageAndTitle;

@end

/**
 *  FYLNavigationButton 是用于 UINavigationItem 的按钮，有两种使用方式：
 *  1. 利用类方法，快速生成所需的 UIBarButtonItem，其中大部分 UIBarButtonItem 均使用系统的 initWithBarButtonSystemItem 或 initWithImage 接口创建，仅有返回按钮利用了 customView 来创建 UIBarButtonItem。
 *  2. 利用 init 方法生成一个 FYLNavigationButton 实例，再通过类方法 + barButtonItemWithNavigationButton:position:target:action: 来生成一个对应的 UIBarButtonItem，此时 FYLNavigationButton 将作为 UIBarButtonItem 的 customView。
 *  若能满足需求，建议优先使用第 1 种方式。
 *  @note 关于 tintColor：UIBarButtonItem 如果使用了 customView，则需要修改 customView.tintColor，如果没使用 customView，则直接修改 UIBarButtonItem.tintColor。
 */
@interface FYLNavigationButton : UIButton

/**
 *  获取当前按钮的`FYLNavigationButtonType`
 */
@property(nonatomic,assign,readonly)FYLNavigationButtonType type;

/**
 *  设置按钮是否用于UINavigationBar上的UIBarButtonItem。若为YES，则会参照系统的按钮布局去更改FYLNavigationButton的内容布局，若为NO，则内容布局与普通按钮没差别。默认为YES。
 */
@property(nonatomic,assign)BOOL useForBarButtonItem;

/**
 * 导航栏按钮的初始化函数,指定的初始化方法

 * @param type 按钮类型
 * @param title 按钮的title
 * @return FYLNavigationButton
 */
- (instancetype)initWithType:(FYLNavigationButtonType)type title:(nullable NSString *)title;

/**
 * 导航栏按钮的初始化函数

 * @param type 按钮类型
 * @return FYLNavigationButton
 */
- (instancetype)initWithType:(FYLNavigationButtonType)type;

/**
 * 导航栏按钮的初始化函数

 *  @param image 按钮的image
 *  @return FYLNavigationButton
 */
- (instancetype)initWithImage:(nullable UIImage *)image;

/**
 *  创建一个 type 为 FYLNavigationButtonTypeBack 的 button 并作为 customView 用于生成一个 UIBarButtonItem，返回按钮的图片由配置表里的宏 NavBarBackIndicatorImage 决定。
 *  @param target 按钮点击事件的接收者
 *  @param selector 按钮点击事件的方法
 *  @param tintColor 按钮要显示的颜色，如果为 nil，则表示跟随当前 UINavigationBar 的 tintColor
 */
+ (nullable UIBarButtonItem *)backBarButtonItemWithTarget:(nullable id)target action:(nullable SEL)selector tintColor:(nullable UIColor *)tintColor;

/**
 *  创建一个 type 为 FYLNavigationButtonTypeBack 的 button 并作为 customView 用于生成一个 UIBarButtonItem，返回按钮的图片由配置表里的宏 NavBarBackIndicatorImage 决定。
 *  @param target 按钮点击事件的接收者
 *  @param selector 按钮点击事件的方法
 */
+ (nullable UIBarButtonItem *)backBarButtonItemWithTarget:(nullable id)target action:(nullable SEL)selector;

/**
 *  创建一个以 “×” 为图标的关闭按钮，图片由配置表里的宏 NavBarCloseButtonImage 决定。
 *  @param target 按钮点击事件的接收者
 *  @param selector 按钮点击事件的方法
 *  @param tintColor 按钮要显示的颜色，如果为 nil，则表示跟随当前 UINavigationBar 的 tintColor
 */
+ (nullable UIBarButtonItem *)closeBarButtonItemWithTarget:(nullable id)target action:(nullable SEL)selector tintColor:(nullable UIColor *)tintColor;

/**
 *  创建一个以 “×” 为图标的关闭按钮，图片由配置表里的宏 NavBarCloseButtonImage 决定，图片颜色跟随 UINavigationBar.tintColor。
 *  @param target 按钮点击事件的接收者
 *  @param selector 按钮点击事件的方法
 */
+ (nullable UIBarButtonItem *)closeBarButtonItemWithTarget:(nullable id)target action:(nullable SEL)selector;

/**
 *  创建一个 UIBarButtonItem
 *  @param type 按钮的类型
 *  @param title 按钮的标题
 *  @param tintColor 按钮的颜色，如果为 nil，则表示跟随当前 UINavigationBar 的 tintColor
 *  @param position 按钮在 UINavigationBar 上的左右位置，如果某一边的按钮有多个，则只有最左边（最右边）的按钮需要设置为 FYLNavigationButtonPositionLeft（FYLNavigationButtonPositionRight），靠里的按钮使用 FYLNavigationButtonPositionNone 即可
 *  @param target 按钮点击事件的接收者
 *  @param selector 按钮点击事件的方法
 */
+ (nullable UIBarButtonItem *)barButtonItemWithtype:(FYLNavigationButtonType)type title:(nullable NSString *)title tintColor:(nullable UIColor *)tintColor position:(FYLNavigationButtonPosition)position target:(nullable id)target action:(nullable SEL)selector;

/**
 *  创建一个 UIBarButtonItem
 *  @param type 按钮的类型
 *  @param title 按钮的标题
 *  @param position 按钮在 UINavigationBar 上的左右位置，如果某一边的按钮有多个，则只有最左边（最右边）的按钮需要设置为 FYLNavigationButtonPositionLeft（FYLNavigationButtonPositionRight），靠里的按钮使用 FYLNavigationButtonPositionNone 即可
 *  @param target 按钮点击事件的接收者
 *  @param selector 按钮点击事件的方法
 */
+ (nullable UIBarButtonItem *)barButtonItemWithtype:(FYLNavigationButtonType)type title:(nullable NSString *)title position:(FYLNavigationButtonPosition)position target:(nullable id)target action:(nullable SEL)selector;

/**
 *  将参数传进来的 button 作为 customView 用于生成一个 UIBarButtonItem。
 *  @param button 要作为 customView 的 FYLNavigationButton
 *  @param tintColor 按钮的颜色，如果为 nil，则表示跟随当前 UINavigationBar 的 tintColor
 *  @param position 按钮在 UINavigationBar 上的左右位置，如果某一边的按钮有多个，则只有最左边（最右边）的按钮需要设置为 FYLNavigationButtonPositionLeft（FYLNavigationButtonPositionRight），靠里的按钮使用 FYLNavigationButtonPositionNone 即可
 *  @param target 按钮点击事件的接收者
 *  @param selector 按钮点击事件的方法
 *
 *  @note tintColor、position、target、selector 等参数不需要对 FYLNavigationButton 设置，通过参数传进来就可以了，就算设置了也会在这个方法里被覆盖。
 */
+ (nullable UIBarButtonItem *)barButtonItemWithNavigationButton:(FYLNavigationButton *)button tintColor:(nullable UIColor *)tintColor position:(FYLNavigationButtonPosition)position target:(nullable id)target action:(nullable SEL)selector;
/**
 *  将参数传进来的 button 作为 customView 用于生成一个 UIBarButtonItem。
 *  @param button 要作为 customView 的 FYLNavigationButton
 *  @param position 按钮在 UINavigationBar 上的左右位置，如果某一边的按钮有多个，则只有最左边（最右边）的按钮需要设置为 FYLNavigationButtonPositionLeft（FYLNavigationButtonPositionRight），靠里的按钮使用 FYLNavigationButtonPositionNone 即可
 *  @param target 按钮点击事件的接收者
 *  @param selector 按钮点击事件的方法
 *
 *  @note position、target、selector 等参数不需要对 FYLNavigationButton 设置，通过参数传进来就可以了，就算设置了也会在这个方法里被覆盖。
 */
+ (nullable UIBarButtonItem *)barButtonItemWithNavigationButton:(FYLNavigationButton *)button position:(FYLNavigationButtonPosition)position target:(nullable id)target action:(nullable SEL)selector;

/**
 *  创建一个图片类型的 UIBarButtonItem
 *  @param image 按钮的图标
 *  @param tintColor 按钮的颜色，如果为 nil，则表示跟随当前 UINavigationBar 的 tintColor
 *  @param position 按钮在 UINavigationBar 上的左右位置，如果某一边的按钮有多个，则只有最左边（最右边）的按钮需要设置为 FYLNavigationButtonPositionLeft（FYLNavigationButtonPositionRight），靠里的按钮使用 FYLNavigationButtonPositionNone 即可
 *  @param target 按钮点击事件的接收者
 *  @param selector 按钮点击事件的方法
 */
+ (nullable UIBarButtonItem *)barButtonItemWithImage:(nullable UIImage *)image tintColor:(nullable UIColor *)tintColor position:(FYLNavigationButtonPosition)position target:(nullable id)target action:(nullable SEL)selector;

/**
 *  创建一个图片类型的 UIBarButtonItem
 *  @param image 按钮的图标
 *  @param position 按钮在 UINavigationBar 上的左右位置，如果某一边的按钮有多个，则只有最左边（最右边）的按钮需要设置为 FYLNavigationButtonPositionLeft（FYLNavigationButtonPositionRight），靠里的按钮使用 FYLNavigationButtonPositionNone 即可
 *  @param target 按钮点击事件的接收者
 *  @param selector 按钮点击事件的方法
 */
+ (nullable UIBarButtonItem *)barButtonItemWithImage:(nullable UIImage *)image position:(FYLNavigationButtonPosition)position target:(nullable id)target action:(nullable SEL)selector;

@end


/**
 *  `FYLToolbarButton`是用于底部工具栏的按钮
 */
@interface FYLToolbarButton : UIButton

/// 获取当前按钮的type
@property(nonatomic,assign,readonly)FYLToolbarButtonType type;

/**
 *  工具栏按钮的初始化函数
 *  @param type 按钮类型
 *  @param title 按钮的title
 */
- (instancetype)initWithType:(FYLToolbarButtonType)type title:(nullable NSString *)title;

/**
 *  工具栏按钮的初始化函数
 *  @param type  按钮类型
 */
- (instancetype)initWithType:(FYLToolbarButtonType)type;

/**
 *  工具栏按钮的初始化函数
 *  @param image 按钮的image
 */
- (instancetype)initWithImage:(nullable UIImage *)image;

/// 在原有的FYLToolbarButton上创建一个UIBarButtonItem
+ (nullable UIBarButtonItem *)barButtonItemWithToolbarButton:(FYLToolbarButton *)button target:(nullable id)target action:(nullable SEL)selector;

/// 创建一个特定type的UIBarButtonItem
+ (nullable UIBarButtonItem *)barButtonItemWithType:(FYLToolbarButtonType)type title:(NSString *)title target:(nullable id)target action:(nullable SEL)selector;

/// 创建一个图标类型的UIBarButtonItem
+ (nullable UIBarButtonItem *)barButtonItemWithImage:(nullable UIImage *)image target:(nullable id)target action:(nullable SEL)selector;

@end

/**
 *  支持显示下划线的按钮，可用于需要链接的场景。下划线默认和按钮宽度一样，可通过 `underlineInsets` 调整。
 */
@interface FYLLinkButton : FYLButton

/// 控制下划线隐藏或显示，默认为NO，也即显示下划线
@property(nonatomic,assign)IBInspectable BOOL underlineHidden;

/// 设置下划线的宽度，默认为 1
@property(nonatomic,assign)IBInspectable CGFloat underlineHeight;

/// 控制下划线颜色，若设置为nil，则使用当前按钮的titleColor的颜色作为下划线的颜色。默认为 nil。
@property(nonatomic,strong,nullable)IBInspectable UIColor *underlineColor;

/// 下划线的位置是基于 titleLabel 的位置来计算的，默认x、width均和titleLabel一致，而可以通过这个属性来调整下划线的偏移值。默认为UIEdgeInsetsZero。
@property(nonatomic,assign)UIEdgeInsets underlineInsets;

@end

/**
 *  用于 `FYLGhostButton.cornerRadius` 属性，当 `cornerRadius` 为 `FYLGhostButtonCornerRadiusAdjustsBounds` 时，`FYLGhostButton` 会在高度变化时自动调整 `cornerRadius`，使其始终保持为高度的 1/2。
 */
extern const CGFloat FYLGhostButtonCornerRadiusAdjustsBounds;

/**
 *  “幽灵”按钮，也即背景透明、带圆角边框的按钮
 *
 *  可通过 `FYLGhostButtonColor` 设置几种预设的颜色，也可以用 `ghostColor` 设置自定义颜色。
 *
 *  @warning 默认情况下，`ghostColor` 只会修改文字和边框的颜色，如果需要让 image 也跟随 `ghostColor` 的颜色，则可将 `adjustsImageWithGhostColor` 设为 `YES`
 */
@interface FYLGhostButton : FYLButton

@property(nonatomic,strong,nullable)IBInspectable UIColor *ghostColor;  // 默认为 GhostButtonColorBlue
@property(nonatomic,assign)CGFloat borderWidth UI_APPEARANCE_SELECTOR;  // 默认为 1pt
@property(nonatomic,assign)CGFloat cornerRadius UI_APPEARANCE_SELECTOR; // 默认为 FYLGhostButtonCornerRadiusAdjustsBounds，也即固定保持按钮高度的一半。

/**
 *  控制按钮里面的图片是否也要跟随 `ghostColor` 一起变化，默认为 `NO`
 */
@property(nonatomic,assign)BOOL adjustsImageWithGhostColor UI_APPEARANCE_SELECTOR;

- (instancetype)initWithGhostType:(FYLGhostButtonColor)ghostType;
- (instancetype)initWithGhostColor:(nullable UIColor *)ghostColor;

@end

/**
 *  用于 `FYLFillButton.cornerRadius` 属性，当 `cornerRadius` 为 `FYLFillButtonCornerRadiusAdjustsBounds` 时，`FYLFillButton` 会在高度变化时自动调整 `cornerRadius`，使其始终保持为高度的 1/2。
 */
extern const CGFloat FYLFillButtonCornerRadiusAdjustsBounds;

/**
 *  FYLFillButton
 *  实心填充颜色的按钮，支持预定义的几个色值
 */
@interface FYLFillButton : FYLButton

@property(nonatomic,strong,nullable)IBInspectable UIColor *fillColor;   // 默认为 FillButtonColorBlue
@property(nonatomic,strong,nullable)IBInspectable UIColor *titleTextColor;  // 默认为 UIColorWhite

@property(nonatomic,assign)CGFloat cornerRadius UI_APPEARANCE_SELECTOR;// 默认为 FYLFillButtonCornerRadiusAdjustsBounds，也即固定保持按钮高度的一半。

/**
 *  控制按钮里面的图片是否也要跟随 `titleTextColor` 一起变化，默认为 `NO`
 */
@property(nonatomic,assign)BOOL adjustsImageWithTitleTextColor UI_APPEARANCE_SELECTOR;

- (instancetype)initWithFillType:(FYLFillButtonColor)fillType;
- (instancetype)initWithFillType:(FYLFillButtonColor)fillType frame:(CGRect)frame;
- (instancetype)initWithColor:(nullable UIColor *)fillColor titleTextColor:(nullable UIColor *)textColor;
- (instancetype)initWithColor:(nullable UIColor *)fillColor titleTextColor:(nullable UIColor *)textColor frame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END





