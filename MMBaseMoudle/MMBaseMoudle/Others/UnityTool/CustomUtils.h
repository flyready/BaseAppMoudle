//
//  CustomUtils.h
//  Common
//
//  Created by nanfang on 14/11/11.
//  Copyright (c) 2014年 FamilyAlbum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CustomUtils : NSObject

#pragma mark - UIAlertView

+ (CGSize)sizeOfString:(NSString *)string sizeWithFont:(UIFont *)font lineBreakMode:(NSLineBreakMode)lineBreakMode maxSize:(CGSize)maxSize;

+ (id)dataHandle:(id)data;

+ (NSDictionary *)AllObjectsInDicConvertToNSString:(NSDictionary *)dict;

+ (NSArray *)AllObjectsInArrayConvertToNSString:(NSArray *)array;

//获取随机颜色color
+ (UIColor *)getRandomColor;

+ (UIImage *)imageFromColor:(UIColor *)color;
//根据比例（0...1）在min和max中取值
+ (CGFloat)lerp:(float)percent min:(float)nMin max:(float)nMax;

//对图片尺寸进行压缩--
+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
//  *****************  图片 旋转 角度   *****************************************  //
+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation;

//    改变图片的颜色
+ (UIImage *)imageWithColor:(UIColor *)color withImage:(UIImage *)image;

+ (UIImage *)getImageFromView:(UIView *)view;

+ (void)avstarAnimation:(UIImageView *)avstar;

+ (NSTimeInterval)keyBoardAnimationTime:(NSDictionary *)dict;

+ (BOOL)judustString:(NSString *)content title:(NSString *)title;

+ (BOOL)ISNULL:(id)string;

+ (void)alertWithError:(NSError *)error;

//+ (void)addShadowLabel:(THLabel *)label;

// 字典转 josn 字符串
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;

+ (NSString *)paramsForGet:(NSDictionary *)params;

@end
