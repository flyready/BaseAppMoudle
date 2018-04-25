//
//  UIView+ZTExtension.m
//  BlockUseDemo
//
//  Created by quiet on 15/7/15.
//  Copyright (c) 2015年 quiet. All rights reserved.
//

#import "UIView+ZTExtension.h"

@implementation UIView (ZTExtension)
-(CGFloat)x
{
    CGRect frame = self.frame;
    return frame.origin.x;
}
-(void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
-(CGFloat)y
{
    CGRect frame = self.frame;
    return frame.origin.y;
}
-(void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
-(CGFloat)width
{
    CGRect frame = self.frame;
    return frame.size.width;
}
-(void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
-(CGFloat)height
{
    CGRect frame = self.frame;
    return frame.size.height;
}
-(void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

-(void)setCornerRadius:(CGFloat)radius
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = radius;
    self.clipsToBounds = YES;
}
-(void)setbordWidth:(CGFloat)bordWidth withBorderColor:(UIColor *)bordColor
{
    self.layer.borderWidth = bordWidth;
    self.clipsToBounds = YES;
    self.layer.borderColor = bordColor.CGColor;
}
/** 获取当前View的控制器对象 */
- (UIViewController *)getCurrentViewController{
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}

@end
