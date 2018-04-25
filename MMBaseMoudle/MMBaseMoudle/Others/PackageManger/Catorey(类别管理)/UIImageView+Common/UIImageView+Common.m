//
//  UIImageView+Common.m
//  Coding_iOS
//
//  Created by 王 原闯 on 14-8-8.
//  Copyright (c) 2014年 Coding. All rights reserved.
//

#import "UIImageView+Common.h"

@implementation UIImageView (Common)

- (void)quartz2dLine:(CGFloat)w y:(CGFloat)y  //  画横的虚线
{
    self.frame = CGRectMake(0.f, y, w, kqh);
    UIGraphicsBeginImageContext(self.frame.size);   //开始画线
    [self.image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    //设置线条终点形状
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    
    CGFloat lengths[] = {10, 4};
    CGContextRef line = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(line, UIColorFromRGB(0xe0e0e0).CGColor);
    
    CGContextSetLineDash(line, 0, lengths, 2);  //画虚线
    CGContextMoveToPoint(line, 0.0, 0.0);    //开始画线
    CGContextAddLineToPoint(line, self.frame.size.width, self.frame.size.height);
    CGContextStrokePath(line);
    self.image = UIGraphicsGetImageFromCurrentImageContext();
}

//  绿色   //  画竖的虚线
- (void)quartz2dShu:(CGFloat)w y:(CGFloat)y
{
    UIGraphicsBeginImageContext(self.frame.size);   //开始画线
    [self.image drawInRect:CGRectMake(w, 0, 1.f, y)];
    //设置线条终点形状
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGFloat lengths[] = {1, 1};
    CGContextRef line = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(line, [UIColor whiteColor].CGColor);
    
    CGContextSetLineDash(line, 0, lengths, 1);  //画虚线
    CGContextMoveToPoint(line, 0.0, 0.0);    //开始画线
    CGContextAddLineToPoint(line, 1.f, y);
    CGContextStrokePath(line);
    self.image = UIGraphicsGetImageFromCurrentImageContext();
    
}
//弹射动画函数
- (void)shootOutAnimationFrequency:(NSInteger)n height:(CGFloat)height frame:(CGRect)frame num:(NSInteger)num durning:(CGFloat)durning withBlock:(FlexibleAnimation)block
{
    //n 为弹跳的次数 如果传入的是一个基数  那么就会自动默认加一为偶数
    //height 为第一次弹跳的最高高度 20
    //view 为传入的视图
    //frame 为传入视图的坐标
    //num 必须和传入的弹跳次数一致
    //durning 弹跳时间
    if (n<0) {
        if (block) { block(); return; }
    }
    n = n-1;
    [UIView animateWithDuration:durning delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^(void){
        self.frame = CGRectMake(frame.origin.x, frame.origin.y-((n%2)?0:(n+2)*(height/num)), frame.size.width, frame.size.height);
    } completion:^(BOOL finished){
        [self shootOutAnimationFrequency:n height:height frame:frame num:num durning:durning withBlock:block];
    }];
}

@end

//#pragma ImageView Animation
//@implementation EaseLoadingView
//
//- (instancetype)initWithFrame:(CGRect)frame{
//    self = [super initWithFrame:frame];
//    if (self) {
//        ;
//    }
//    return self;
//}
//
//- (void)mStartAnimating{
//    if (_isLoading) {
//        return;
//    }
//    _isLoading = YES;
//    [self loadingAnimation];
//}
//
//- (void)mStopAnimating{
//    [self.layer removeAnimationForKey:@"rotationAnimation"];
//    _isLoading = NO;
//}
//
//- (void)loadingAnimation{
//    
// //  **********************************    360度 不停的旋转 layer 方式    **********************************//
//    if (_isLoading) {
//        CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//        rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI * 2.0];
//        rotationAnimation.duration = 2.f;
//        rotationAnimation.cumulative = YES;
//        rotationAnimation.repeatCount = INFINITY;
//        rotationAnimation.removedOnCompletion = NO;
//        [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
//    }else{
//        [self.layer removeAnimationForKey:@"rotationAnimation"];
//    }
//
//}

//@end
