//
//  CustomUtil.h
//  Common
//  Created by nanfang on 17/3/24.
//  Copyright (c) 2015年 YUNSHANG ALERATION. All rights reserved.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CustomUtil : NSObject

//把可变数组写入文件
+ (BOOL)writeMutableArrToFile:(NSMutableArray *)arr fileName:(NSString *)file;

//把数组写入文件
+ (BOOL)writeArrToFile:(NSArray *)arr fileName:(NSString *)file;

//把可变字典写入文件
+ (BOOL)writeObjectToFile:(id)object fileName:(NSString *)file;

//把字典写入文件
+ (BOOL)writeDicToFile:(NSDictionary *)object fileName:(NSString *)file;

//解析文件得到数组
+ (NSArray *)parseArrFromFile:(NSString *)file;

+ (NSMutableArray *)parseMutableArrFromFile:(NSString *)file;

//解析文件得到可变字典
+ (id)parseObjectFromFile:(NSString *)file;

//解析文件得到字典
+ (NSDictionary *)parseDicFromFile:(NSString *)file;

+ (NSString *)parseStringFromFile:(NSString *)file;
//移除文件
+ (void)removeFile:(NSString *)fileName;


@end
