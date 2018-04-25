//
//  UIView+Common.h
//#import "UITTTAttributedLabel.h"

@class EaseLoadingView, EaseBlankPageView, EaseActLoadingView;

typedef NS_ENUM(NSInteger, EaseBlankPageType){
    NoHasRouteFillView = 10,
    NoHasRouteTypeView,  //  路线
    NoHasDataFriendCircle,  // 朋友圈
    NoRequestWebFailor
    //NoHasRadarNetWork       // 网络错误 无法使用
};

@interface UIView (Common)

- (void)setY:(CGFloat)y;
- (void)setX:(CGFloat)x;
- (void)setHeight:(CGFloat)height;
- (void)setWidth:(CGFloat)width;
- (void)setSize:(CGSize)size;
- (void)setCenterY:(CGFloat)y;
- (void)setCenterX:(CGFloat)x;
- (UIView *)addBackViewToSupview:(CGRect)rect;
+ (UIView *)headerView:(CGFloat)y;
+ (UIView *)getBgView:(CGRect)rect;
+ (UIView *)getBgView:(CGRect)rect color:(UIColor *)color;
/// 画虚线 框
- (void)drawDashedLineFrame:(UIColor *)strokeColor;

#pragma cell 的颜色
- (void)setCellBackView;
+ (UIImageView *)customBackgroundView;

- (void)addWhiteLineUp:(BOOL)hasUp andDown:(BOOL)hasDown;
- (void)addWhiteLineUp:(BOOL)hasUp andDown:(BOOL)hasDown andX:(CGFloat)x;
- (void)addLineUp:(BOOL)hasUp andDown:(BOOL)hasDown andX:(CGFloat)x;
- (void)addLineUp:(BOOL)hasUp andDown:(BOOL)hasDown;
- (void)addLineUp:(BOOL)hasUp andDown:(BOOL)hasDown andColor:(UIColor *)color andX:(CGFloat)x;

- (void)addYLineLeft:(BOOL)hasLeft andMidden:(BOOL)hasMidden andRight:(BOOL)hasRight;
- (void)addYdLineLeft:(BOOL)hasLeft andRight:(BOOL)hasRight andY:(CGFloat)y;
- (void)addYLineLeft:(BOOL)hasLeft andRigh:(BOOL)hasRight andMidden:(BOOL)hasMidden andColor:(UIColor *)color andY:(CGFloat)y;

- (void)removeViewWithTag:(NSInteger)tag;

- (UIView *)lineViewWithPointYY:(CGFloat)pointY andY:(CGFloat)x;
- (UIView *)lineViewWithPointYY:(CGFloat)pointY andColor:(UIColor *)color andY:(CGFloat)x;

- (void)addGradientLayerWithColors:(NSArray *)cgColorArray;
- (void)addGradientLayerWithColors:(NSArray *)cgColorArray locations:(NSArray *)floatNumArray startPoint:(CGPoint )aPoint endPoint:(CGPoint)endPoint;

- (void)startRotationView:(NSString *)rotationName duration:(CGFloat)duration;
- (void)removeRotationAnimation:(NSString *)rotationName;
- (void)setViewGradientLayer;

#pragma mark LoadingView
@property (strong, nonatomic) EaseLoadingView *loadingView;
- (void)startRoLoading;
- (void)stopRoLoading;

#pragma mark LoadActingView
@property (strong, nonatomic) EaseActLoadingView *loadingActView;
- (void)startHLoading;
- (void)startHudLoading:(NSString *)text;
- (void)stopHudLoading;

#pragma mark BlankPageView
@property (strong, nonatomic) EaseBlankPageView *blankPageView;
- (void)configBlankPage:(EaseBlankPageType)blankPageType hasData:(BOOL)hasData;
- (void)reloadButtonBlock:(void(^)(id sender))block hasData:(BOOL)hasData;

@end

//   自定义的动画
@interface EaseLoadingView : UIView
@property (assign, nonatomic, readonly) BOOL isLoading;
@property (strong, nonatomic) UIImageView *loopView;
//@property (strong, nonatomic) THLabel *loopViewLabel;

- (void)startAnimating;
- (void)stopAnimating;

@end

//   自定义ActIndicator 系统 的动画
@interface EaseActLoadingView : UIView
@property (strong, nonatomic) UIImageView *loopView;
@property (assign, nonatomic, readonly) BOOL isLoading;

- (instancetype)initWithFrame:(CGRect)frame withStr:(NSString *)loadingStr;
- (void)startHudLoadingAnimation;
- (void)stopHudLoadingAnimation;

@end


#pragma mark EaseBlankPageView
@interface EaseBlankPageView : UIView
@property (strong, nonatomic) UIButton *fillButton;
@property (strong, nonatomic) UIImageView *fillView;
@property (strong, nonatomic) UIView *loadingFinishView;
@property (strong, nonatomic) UILabel *tipLabel;
@property (copy, nonatomic) void(^reloadButtonBlock)(id sender);

- (void)configWithType:(EaseBlankPageType)blankPageType hasData:(BOOL)hasData;
- (void)reloadButtonBlock:(void(^)(id sender))block;

@end


