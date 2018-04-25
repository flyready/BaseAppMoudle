//
//  UIImage+Extension.h
//  HanyuSearchJoy
//
//  Created by HCL黄 on 2017/1/6.
//  Copyright © 2017年 HCL黄. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface UIImage (Extension)

/** 根据size和color，返回一张图片 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/** 根据图片名拉伸图片，返回一张图片 */
+ (UIImage *)resizedImage:(NSString *)name left:(CGFloat)leftScale top:(CGFloat)topScale;

/** 根据宽度计算高度，按照宽高比绘制一张新的图片 */
- (UIImage *)imageWithScale:(CGFloat)width;

+ (UIImage*)createQRCode:(NSString*)code;

- (UIImage *) resizedImageByMagick: (NSString *) spec;
- (UIImage *) resizedImageByWidth:  (NSUInteger) width;
- (UIImage *) resizedImageByHeight: (NSUInteger) height;
- (UIImage *) resizedImageWithMaximumSize: (CGSize) size;
- (UIImage *) resizedImageWithMinimumSize: (CGSize) size;

+ (UIImage *)imageWithColor:(UIColor *)aColor;
+ (UIImage *)imageWithColor:(UIColor *)aColor withFrame:(CGRect)aFrame;
- (UIImage*)scaledToSize:(CGSize)targetSize;
- (UIImage*)scaledToSize:(CGSize)targetSize highQuality:(BOOL)highQuality;
- (UIImage*)scaledToMaxSize:(CGSize )size;
+ (UIImage *)fullResolutionImageFromALAsset:(ALAsset *)asset;
+ (UIImage *)fullScreenImageALAsset:(ALAsset *)asset;

+ (UIImage *)se_getScreenShotWithView:(UIView *)view;

-(UIImage*)scaleToSize:(CGSize)size;

- (UIImage *)fixOrientation;

@end
