//
//  UIView+Arrow.m
//  eTailorClient_Iphone
//
//  Created by YunShangCompany on 2017/3/27.
//  Copyright © 2017年 YunShangCompany. All rights reserved.
//

#import "UIView+Arrow.h"
#define kTagAccessoryView 2016
#define kTagArrowView 2017

@implementation UIView (Initialization)

- (void)customCreateAccessoryView:(CGFloat)cellH
{
    [self removeAccessoryView];
    if (!cellH) { cellH = self.height; }
    UIImage *accImage = [UIImage imageNamed:@"icon_rightyou"];
    CGFloat imgvW = IMAGEWIDTH(accImage);
    CGFloat imgvH = IMAGEHEIGHT(accImage);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:
          CGRectMake(self.width-imgvW-12.f, (cellH-imgvH)/2, imgvW, imgvH)];
    [imageView setImage:accImage];
    imageView.tag = kTagAccessoryView;
    [self addSubview:imageView];
}

- (void)setHideAccessoryView:(BOOL)hide
{
    UIImageView *imageView = (UIImageView *)[self viewWithTag:kTagAccessoryView];
    [imageView setHidden:hide];
}

- (void)removeAccessoryView
{
    UIImageView *imageView = (UIImageView *)[self viewWithTag:kTagAccessoryView];
    [imageView removeFromSuperview];
    imageView = nil;
}

- (void)customCreateArrowView
{
    [self customCreateArrowViewWithImg:@"public_img_in_small"];
}

- (void)customCreateArrowViewWithImg:(NSString *)imgStr
{
    CGFloat cellH = HEIGHT(self);
    UIImage *accImage = [UIImage imageNamed:imgStr];
    CGFloat imgvW = IMAGEWIDTH(accImage);
    CGFloat imgvH = IMAGEHEIGHT(accImage);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:
                              CGRectMake(WIDTH(self)-imgvW-12.f,
                            (cellH-imgvH)/2, imgvW, imgvH)];
    [imageView setImage:accImage];
    imageView.tag = kTagArrowView;
    [self addSubview:imageView];
}

- (void)setHideArrowView:(BOOL)hide
{
    UIImageView *imageView = (UIImageView *)[self viewWithTag:kTagArrowView];
    [imageView setHidden:hide];
}

- (void)removeArrowView
{
    UIImageView *imageView = (UIImageView *)[self viewWithTag:kTagArrowView];
    [imageView removeFromSuperview];
    imageView = nil;
}


@end
