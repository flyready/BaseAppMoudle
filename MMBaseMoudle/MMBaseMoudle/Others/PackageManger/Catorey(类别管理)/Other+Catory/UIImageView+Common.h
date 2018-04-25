//
//  UIImageView+Common.h
//  Coding_iOS
//
#import <UIKit/UIKit.h>

static CGFloat const kqh = .8f;
typedef void (^FlexibleAnimation) (void);
@interface UIImageView (Common)

- (void)quartz2dLine:(CGFloat)w y:(CGFloat)y;  //  画横的虚线
//  绿色   //  画竖的虚线
- (void)quartz2dShu:(CGFloat)w y:(CGFloat)y;

//弹射动画函数
- (void)shootOutAnimationFrequency:(NSInteger)n height:(CGFloat)height frame:(CGRect)frame num:(NSInteger)num durning:(CGFloat)durning withBlock:(FlexibleAnimation)block;

@end

//@interface EaseLoadingView : UIImageView
//
//@property (assign, nonatomic, readonly) BOOL isLoading;
//- (void)mStartAnimating;
//- (void)mStopAnimating;
//
//@end
