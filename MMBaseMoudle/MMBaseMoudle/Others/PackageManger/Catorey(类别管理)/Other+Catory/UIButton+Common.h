//
//  Created by YunShangCompany on 2017/4/2.
//  Copyright © 2017年 HanYu. All rights reserved.
#import <UIKit/UIKit.h>

@interface UIButton (Common)

- (void)userNameStyle;
//- (void)frameToFitTitle;
- (void)setUserTitle:(NSString *)aUserName;
- (void)setUserTitle:(NSString *)aUserName font:(UIFont *)font maxWidth:(CGFloat)maxWidth;

+ (UIButton *)tweetBtnWithFrame:(CGRect)frame alignmentLeft:(BOOL)alignmentLeft;
- (void)animateToImage:(NSString *)imageName;

//开始请求时，UIActivityIndicatorView 提示
- (void)startQueryAnimate;
- (void)stopQueryAnimate;

@end
