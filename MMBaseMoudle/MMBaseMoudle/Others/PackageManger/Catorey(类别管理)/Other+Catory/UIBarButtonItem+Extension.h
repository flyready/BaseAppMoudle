//
//  UIBarButtonItem+Extension.h
//  HanyuSearchJoy
//
//  Created by HCL黄 on 2017/1/9.
//  Copyright © 2017年 HCL黄. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)


+(UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageNmae target:(id)target action:(SEL)action;


+(UIBarButtonItem *)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)itemLeftTarget:(id)target action:(SEL)action;
+ (UIBarButtonItem *)itemLeftWithImage:(NSString *)imageName target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)itemWithImage:(NSString *)imageName target:(id)target action:(SEL)action;

@end
