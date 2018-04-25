//
//  TextChecker.h
//  Common
//
//  Created by cameron on 14-7-4.
//  Copyright (c) 2014年 FamilyAlbum. All rights reserved.

#import <Foundation/Foundation.h>

@interface TextChecker : NSObject

+ (BOOL)isEmailAddress:(NSString *)text;
+ (BOOL)isTelephone:(NSString *)text;
+ (BOOL)isNumeric:(NSString *)text;
+ (BOOL)isEmptyOrNil:(NSString *)text;
+ (BOOL)isQQ:(NSString *)text;
+ (BOOL)isMSN:(NSString *)text;
+ (BOOL)isPasswordLegal:(NSString *)text;
+ (BOOL)isURLString:(NSString *)text;
//身份证号
+ (BOOL)isValidateIdentityCard: (NSString *)identityCard;
//检测是否位数字
+ (BOOL)isNum:(NSString *)checkedNumString;

@end
