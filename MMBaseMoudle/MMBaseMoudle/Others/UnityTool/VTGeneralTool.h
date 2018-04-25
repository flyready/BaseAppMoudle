//
//  VTGeneralTool.h
//  SZDT_Partents
//
//  Created by szdt on 15/3/23.
//  Copyright (c) 2015年 szdt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface VTGeneralTool : NSObject
+ (CGSize)boundingRectWithSize:(CGSize)size  font:(CGFloat)font text:(NSString *)text;
+ (UIColor *)colorWithHex:(NSString *)hexColor;
+ (UIImage *)imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;
+ (BOOL)judgePushSwitch;

+ (NSString *)getCurrentDevice;

+ (NSString*)base64forData:(NSData*)theData;

/**
 *  各种字符串判断
 *
 *  @param str
 *
 *  @return
 */
+ (Boolean)isNumberCharaterString:(NSString *)str;
+ (Boolean)isCharaterString:(NSString *)str;
+ (Boolean)isNumberString:(NSString *)str;
+ (Boolean)hasillegalString:(NSString *)str;
+ (Boolean)isValidSmsString:(NSString *)str;
+ (BOOL)verifyEmail:(NSString*)email;
+ (BOOL)verifyPhone:(NSString*)phone;
+ (BOOL)verifyMobilePhone:(NSString*)phone;
+ (NSString *)getTimeString:(NSInteger)duration; //通过时长获取时分秒的字符串
+ (NSString *)cleanPhone:(NSString *)beforeClean;

/**
 *  把color变成image
 *
 *  @param color 传来的color
 *
 *  @return 返回iamge
 */
+ (UIImage *)createImageWithColor:(UIColor *)color;
/**
 *  检查非法字符和中文
 *
 *  @param str
 *
 *  @return 
 */
+ (BOOL)checkNoChar:(NSString *)str;
/**
 *  隐藏tabbar
 */
+ (void)hiddenTabBar;
/**
 *  显示tabbar
 */
+ (void)showTabBar;
/**
 *  检查电话号码合法性
 *
 *  @param phoneNumber
 *
 *  @return
 */
+ (BOOL)checkPhoneNumInput:(NSString *)phoneNumber;
/**
 *  根据dict返回data
 *
 *  @param dict
 *
 *  @return
 */
+ (NSData*)returnDataWithDictionary:(NSDictionary*)dict;
/**
 *  根据输入的日期 返回周几的字符串
 *
 *  @param inputDate
 *
 *  @return
 */
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate;
/**
 *  获取今日日期
 *
 *  @return
 */
+ (NSString *)getDate;
/**
 *  获取当前周的日期数组
 *
 *  @param date
 *
 *  @return
 */
+ (NSArray *)getCurrentWeekDay:(NSDate *)date;
/**
 *  计算当前路径下文件大小
 *
 *  @param path
 *
 *  @return
 */
+ (float)fileSizeAtPath:(NSString *)path;
/**
 *  当前路径文件夹的大小
 *
 *  @param path
 *
 *  @return
 */
+ (float)folderSizeAtPath:(NSString *)path;
/**
 *  清除文件
 *
 *  @param path
 */
+ (void)clearCache:(NSString *)path;

/**
 *POST 提交 并可以上传图片目前只支持单张
 */
+ (NSString *)postRequestWithURL: (NSString *)url  // IN
                      postParems: (NSMutableDictionary *)postParems // IN 提交参数据集合
                     picFilePath: (NSString *)picFilePath  // IN 上传图片路径
                     picFileName: (NSString *)picFileName;  // IN 上传图片名称

/**
 * 修改图片大小
 */
+ (UIImage *) imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize) newSize;
/**
 * 保存图片
 */
+ (NSString *)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName;
/**
 * 生成GUID
 */
+ (NSString *)generateUuidString;

/**
 * 检查系统"照片"授权状态, 如果权限被关闭, 提示用户去隐私设置中打开.
 */
+ (BOOL)checkPhotoLibraryAuthorizationStatus;

/**
 * 检查系统"相机"授权状态, 如果权限被关闭, 提示用户去隐私设置中打开.
 */
+ (BOOL)checkCameraAuthorizationStatus;

/**
 *  百度转火星坐标
 *
 *  @param coord
 *
 *  @return
 */
+ (CLLocationCoordinate2D )bdToGGEncrypt:(CLLocationCoordinate2D)coord;
/**
 *  火星转百度坐标
 *
 *  @param coord
 *
 *  @return
 */
+ (CLLocationCoordinate2D )ggToBDEncrypt:(CLLocationCoordinate2D)coord;
+(NSString  *)displayDataStyleWithNumber:(NSString *)timeNumber;

//传入时间戳 返回时间格式 11月25 23:23:12
+ (NSString *)timeFormDateAndTime:(NSInteger)totalSeconds;

//传入时间戳 返回时间格式 2010-11-25
+ (NSString *)yearMothDay:(NSInteger)totalSeconds;

//传入Nsdate 返回时间格式 11月25 23:23:12
+ (NSString *)timeFormNowAndTime:(NSDate *)date;

//传入Nsdate 返回时间格式 2012-11-25 23:23:12
+ (NSString *)timeDes:(NSDate *)date;

//传入Nsdate 返回时间格式 如果是今天就返回今天 11:20 昨天 11:20 否则 2012-12-21 12:20
+ (NSString *)ifTodyOrYestetDay:(NSDate *)date;

//返回当前时间时间戳
+ (NSString *)nowTimeinterval;

//传入时间戳 返回发表时的样式 1分钟前 1小时前 1天前 1个月前
+ (NSString *)setTimeLength:(NSInteger)timeLength;

//传入类型 返回json字符串
+ (NSString *)jsonWithObj:(id)obj;

//根据传入的宽度字符及字号 返回行高度
+ (CGFloat)stringHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont*)font;

//根据传入的json数据和model名称 打印model列表
+(void)createModelWithDictionary:(NSDictionary *)dict modelName:(NSString *)modelName;
@end