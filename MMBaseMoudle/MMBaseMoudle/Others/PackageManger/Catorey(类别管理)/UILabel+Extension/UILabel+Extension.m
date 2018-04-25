//
//  UILabel+Extension.m
//  HanyuSearchJoy
//
//  Created by HCL黄 on 2017/1/10.
//  Copyright © 2017年 HCL黄. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)

/** 根据最大宽度，返回自适应size */
- (CGSize)textSizeWithMaxWidth:(CGFloat)maxWidth
{
    CGSize maxSize = CGSizeMake(maxWidth, MAXFLOAT);
    CGSize textSize = [self.text boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName : self.font} context:nil].size;
    return textSize;
}
@end
