//
//  UIView+Extension.m
//  TheWisdomHui
//
//  Created by apple on 16/4/7.
//  Copyright © 2016年 com.gdzwhy. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)
/*********************************/
-(void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
-(CGFloat)x{
    return self.frame.origin.x;
}
/*********************************/
-(void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
-(CGFloat)y{
    return self.frame.origin.y;
}
/*********************************/
- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}
- (CGFloat)centerX
{
    return self.center.x;
}
/*********************************/
- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}
- (CGFloat)centerY
{
    return self.center.y;
}
/*********************************/
-(void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
-(CGFloat)width{
    return self.frame.size.width;
}
/*********************************/
-(void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
-(CGFloat)height{
    return self.frame.size.height;
}
/*********************************/
-(void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
-(CGSize)size{
    return self.frame.size;
}
/*********************************/
- (void)setMaxX:(CGFloat)maxX
{
    self.x = maxX - self.width;
}
- (CGFloat)maxX
{
    return CGRectGetMaxX(self.frame);
}
/*********************************/
- (void)setMaxY:(CGFloat)maxY
{
    self.y = maxY - self.height;
}

- (CGFloat)maxY
{
    return CGRectGetMaxY(self.frame);
}

- (CGFloat)right
{
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)bottom
{
    return CGRectGetMaxY(self.frame);
}

- (void)setRight:(CGFloat)right
{
    self.x = right - self.width;
}

- (void)setBottom:(CGFloat)bottom
{
    self.y = bottom - self.height;
}


- (CGFloat) top
{
    return self.frame.origin.y;
}

- (void) setTop: (CGFloat) newtop
{
    CGRect newframe = self.frame;
    newframe.origin.y = newtop;
    self.frame = newframe;
}


+ (instancetype)viewFromXIB
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil]
            lastObject];
    
}

- (void)startTransitionAnimation {
    CATransition * transition = [CATransition animation];
    transition.duration = 0.5f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    [self.layer addAnimation:transition forKey:nil];
}
///** 显示HUD */
//+ (void)showHUDWithTitle:(NSString *)title
//{
//    [SVProgressHUD showWithStatus:title];
//    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
//}
///** 隐藏HUD */
//+ (void)dismissHUD
//{
//    [SVProgressHUD dismiss];
//}
///** 隐藏HUD带时间参数 */
//+ (void)dismissHUDWithDelay:(NSTimeInterval)delay
//{
//    [SVProgressHUD dismissWithDelay:delay];
//}
///** 成功HUD */
//+ (void)showSuccessHUDWithTitle:(NSString *)title
//{
//    [SVProgressHUD showSuccessWithStatus:title];
//    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
//    [self dismissHUDWithDelay:1.0];
//}
///** 失败HUD */
//+ (void)showErrorHUDWithTitle:(NSString *)title
//{
//    [SVProgressHUD showErrorWithStatus:title];
//    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
//    [self dismissHUDWithDelay:1.0];
//}
@end
