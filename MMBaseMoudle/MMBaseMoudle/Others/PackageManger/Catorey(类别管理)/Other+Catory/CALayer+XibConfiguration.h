//
//  CALayer+XibConfiguration.h
//  QuickBooks
//
//  Created by Nicholas on 16/12/8.
//  Copyright © 2016年 shijiabao. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (XibConfiguration)

@property(nonatomic, assign) UIColor *borderUIColor;
// 暂停动画
- (void)pauseAnimate;

// 恢复动画
- (void)resumeAnimate;


@end
