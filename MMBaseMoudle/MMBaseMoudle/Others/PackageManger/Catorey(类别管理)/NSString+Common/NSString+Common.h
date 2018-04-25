//
//  NSString+Common.h
//  Coding_iOS
//
//  Created by 王 原闯 on 14-7-31.
//  Copyright (c) 2014年 Coding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Common)

+ (NSString *)userAgentStr;

- (NSString *)URLEncoding;
- (NSString *)URLDecoding;
- (NSString *)md5Str;
- (NSString*)sha1Str;
- (NSURL *)urlWithCodePath;

//- (NSString *)stringByRemoveHtmlTag;

-(BOOL)containsEmoji;

- (NSString *)emotionMonkeyName;

+ (NSString *)sizeDisplayWithByte:(CGFloat)sizeOfByte;

- (NSString *)trimWhitespace;

- (BOOL)isEmpty;
//判断是否为整形
- (BOOL)isUPureInt;
//判断是否为浮点形
- (BOOL)isPureFloat;

//转换拼音
- (NSString *)transformToPinyin;

//电话号码加*
- (NSString *)telephoneNumberEncryption;

- (NSString *)contactCharacterSetWithCharactersInString;
//字符串 去掉各种字符
- (NSString *)characterSetWithCharactersInString;
- (NSString *)characterSetWithfans;

- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (CGFloat)getHeightWithFont:(UIFont *)font constrainedToW:(CGFloat)lw;
- (CGFloat)getWidthWithFont:(UIFont *)font constrainedToH:(CGFloat)lh;
- (BOOL)isEnglish;
- (UIColor *)toUIColorByStr;

- (NSString *)stringRemoveCity;
- (BOOL)containCity;  // 是否包含城市

- (NSString *)charactorGetFirstCharactor:(BOOL)isGetFirst;
- (BOOL)isZimuWithstring;
/**
 *  截取URL中的参数
 *
 *  @return NSMutableDictionary parameters
 */
- (NSMutableDictionary *)getURLParameters;
/// 去除所有空格
- (NSString *)removeSpace;

+ (BOOL)isBlank:(NSString *)str;

@end
