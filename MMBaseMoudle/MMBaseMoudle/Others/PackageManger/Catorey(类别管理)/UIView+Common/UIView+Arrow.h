//
//  UIView+Arrow.h
//  eTailorClient_Iphone
//
//  Created by YunShangCompany on 2017/3/27.
//  Copyright © 2017年 YunShangCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Arrow)

- (void)customCreateAccessoryView:(CGFloat)cellH;
- (void)setHideAccessoryView:(BOOL)hide;
- (void)removeAccessoryView;

- (void)customCreateArrowView;
- (void)customCreateArrowViewWithImg:(NSString *)imgStr;
- (void)setHideArrowView:(BOOL)hide;
- (void)removeArrowView;


@end
