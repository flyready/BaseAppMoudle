//
//  UILabel+Extension.h
//  HanyuSearchJoy
//
//  Created by HCL黄 on 2017/1/10.
//  Copyright © 2017年 HCL黄. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extension)

/** 根据最大宽度，返回自适应size */
- (CGSize)textSizeWithMaxWidth:(CGFloat)maxWidth;
@end
