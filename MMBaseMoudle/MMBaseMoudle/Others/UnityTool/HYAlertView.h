//
//  Created by YunShangCompany on 2017/4/8.
//  Copyright © 2017年 HanYu. All rights reserved.

#import "ActionControl.h"
@class HYAlertView;

typedef void (^ClickAlertActionBlock) (HYAlertView *alertView, NSInteger buttonIndex);
@interface HYAlertView : UIView

@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) UIImage *icon;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *message;
@property (nonatomic, strong) ClickAlertActionBlock fBlock;

- (instancetype)initWithTitle:(NSString *)title icon:(UIImage *)icon message:(NSString *)message block:(ClickAlertActionBlock)block buttonTitles:(NSString *)buttonTitles, ... NS_REQUIRES_NIL_TERMINATION;

// Show the alert view in current window
- (void)show;

// Hide the alert view
- (void)hide;

// Set the color and font size of title, if color is nil, default is black. if fontsize is 0, default is 14
- (void)setTitleColor:(UIColor *)color fontSize:(CGFloat)size;

// Set the color and font size of message, if color is nil, default is black. if fontsize is 0, default is 12
- (void)setMessageColor:(UIColor *)color fontSize:(CGFloat)size;

// Set the color and font size of button at the index, if color is nil, default is black. if fontsize is 0, default is 16
- (void)setButtonTitleColor:(UIColor *)color fontSize:(CGFloat)size atIndex:(NSInteger)index;

@end

#define kHYAlert [RecordHYAlertView shareHYAlertSingleton]
@interface RecordHYAlertView : NSObject
@property (nonatomic, strong) UIView *recordView;
//单例
+ (instancetype)shareHYAlertSingleton;

@end


