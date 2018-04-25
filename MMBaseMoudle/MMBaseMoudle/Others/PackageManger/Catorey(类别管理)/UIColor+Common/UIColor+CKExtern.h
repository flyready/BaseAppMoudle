//
//  UIColor+CKExtern.h
//  ALaTranslation
//
//  Created by 何铭康 on 2017/2/15.
//  Copyright © 2017年 覃盼. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (CKExtern)

+ (instancetype)ck_colorWithHex:(uint32_t)hex;

+ (instancetype)ck_randomColor;

+ (instancetype)stringTOColor:(NSString *)str;
@end
