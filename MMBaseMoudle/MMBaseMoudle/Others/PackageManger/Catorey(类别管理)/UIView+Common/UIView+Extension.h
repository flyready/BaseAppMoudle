//
//  Created by YunShangCompany on 2017/4/2.
//  Copyright © 2017年 HanYu. All rights reserved.
#import <UIKit/UIKit.h>

@interface UIView (Extension)
@property CGFloat top;
@property(nonatomic,assign)CGFloat x;
@property(nonatomic,assign)CGFloat y;
@property(nonatomic,assign) CGFloat centerX;
@property(nonatomic,assign) CGFloat centerY;
@property(nonatomic,assign)CGFloat width;
@property(nonatomic,assign)CGFloat height;
@property(nonatomic,assign)CGSize size;

@property (nonatomic, assign) CGFloat maxX;
@property (nonatomic, assign) CGFloat maxY;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat bottom;

+ (instancetype)viewFromXIB;

///** 显示HUD */
//+ (void)showHUDWithTitle:(NSString *)title;
//
///** 隐藏HUD */
//+ (void)dismissHUD;
///** 隐藏HUD带时间参数 */
//+ (void)dismissHUDWithDelay:(NSTimeInterval)delay;
///** 成功HUD */
//+ (void)showSuccessHUDWithTitle:(NSString *)title;
///** 失败HUD */
//+ (void)showErrorHUDWithTitle:(NSString *)title;
- (void)startTransitionAnimation;
@end
