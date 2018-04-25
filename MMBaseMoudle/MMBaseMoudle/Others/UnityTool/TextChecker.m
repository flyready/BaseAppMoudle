//
//  TextChecker.m
//  Common
//
//  Created by cameron on 14-7-4.
//  Copyright (c) 2014年 FamilyAlbum. All rights reserved.

#import "TextChecker.h"

@interface TextChecker ()

+ (BOOL)checkWithPattern:(NSString *)pattern text:(NSString *)text;

@end

@implementation TextChecker

+ (BOOL)checkWithPattern:(NSString *)pattern text:(NSString *)text
{
    if (!text) {
        return NO;
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    return [predicate evaluateWithObject:text];
}

+ (BOOL)isEmailAddress:(NSString *)text
{
    NSString *pattern = @"^\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b$";
    return [TextChecker checkWithPattern:pattern text:text];
}

+ (BOOL)isTelephone:(NSString *)text
{
    NSString *pattern = @"^[1][34578][0-9]{9}$";
    return [TextChecker checkWithPattern:pattern text:text];
}

+ (BOOL)isNumeric:(NSString *)text
{
    NSString *pattern = @"^[1-9]\\d*$";
    return [TextChecker checkWithPattern:pattern text:text];
   
}

+ (BOOL)isQQ:(NSString *)text
{
    NSString *pattern = @"^[1-9][0-9]{4,}$";
    return [TextChecker checkWithPattern:pattern text:text];
}

+ (BOOL)isMSN:(NSString *)text
{
    NSString *pattern = @"^\\w+@hotmail\\.com$";
    return [TextChecker checkWithPattern:pattern text:text];
}

+ (BOOL)isEmptyOrNil:(NSString *)text
{
    BOOL b = (!text || text.length == 0);
    return b;
}

+ (BOOL)isPasswordLegal:(NSString *)text
{
    NSString *pattern  =@"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$";
    return [TextChecker checkWithPattern:pattern text:text];
}

+ (BOOL)isURLString:(NSString *)text
{
    //        NSString *pattern = @"\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))";
    //        return [TextChecker checkWithPattern:pattern text:text];
    BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:text]];
    return canOpen;
}

//身份证号
+ (BOOL)isValidateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    return [TextChecker checkWithPattern:regex2 text:identityCard];
}

+ (BOOL)isNum:(NSString *)checkedNumString {
    checkedNumString = [checkedNumString stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(checkedNumString.length > 0) {
        return NO;
    }
    return YES;
}

@end
