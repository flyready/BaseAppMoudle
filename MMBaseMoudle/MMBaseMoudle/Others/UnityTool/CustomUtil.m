//
//  CustomUtil.m
//  Common
//
//  Created by nanfang on 15/6/24.
//  Copyright (c) 2015年 YUNSHANG ALERATION. All rights reserved.
//

#import "CustomUtil.h"

@implementation CustomUtil

//把可变数组写入文件
+ (BOOL)writeMutableArrToFile:(NSMutableArray *)arr fileName:(NSString *)file
{
    NSString *filename = [PATH_OF_DOCUMENT stringByAppendingPathComponent:file];
    if ([arr writeToFile:filename  atomically:YES]) {
        return YES;
    }
    return NO;
    
}

//把数组写入文件
+ (BOOL)writeArrToFile:(NSArray *)arr fileName:(NSString *)file
{
    NSString *filename = [PATH_OF_DOCUMENT stringByAppendingPathComponent:file];
    if ([arr writeToFile:filename  atomically:YES]) {
        return YES;
    }
    return NO;
}

//把可变字典写入文件
+ (BOOL)writeObjectToFile:(id)object fileName:(NSString *)file
{
    NSString *filename = [PATH_OF_DOCUMENT stringByAppendingPathComponent:file];
    if ([object writeToFile:filename  atomically:YES]) {
        DLog(@"------------------------------      write  success   ");
        return YES;
    }
    return NO;
}

//把字典写入文件
+ (BOOL)writeDicToFile:(NSDictionary *)object fileName:(NSString *)file
{
    NSString *filename = [PATH_OF_DOCUMENT stringByAppendingPathComponent:file];
    if ([object writeToFile:filename  atomically:YES]) {
        return YES;
    }
    return NO;
}
//把任何类型 写入文件
//+ (void)writeObjectToFile:(id)object fileName:(NSString *)file;

//解析文件得到数组
+ (NSArray *)parseArrFromFile:(NSString *)file
{
    NSString *filename=[PATH_OF_DOCUMENT stringByAppendingPathComponent:file];
    //NSString *filename = [[NSBundle mainBundle] pathForResource:file/*@"personal"*/ ofType:@"plist"];
    NSArray *array=[[NSArray alloc] initWithContentsOfFile:filename];
    return array;
}

+ (NSMutableArray *)parseMutableArrFromFile:(NSString *)file
{
    NSString *filename=[PATH_OF_DOCUMENT stringByAppendingPathComponent:file];
    //NSString *filename = [[NSBundle mainBundle] pathForResource:file/*@"personal"*/ ofType:@"plist"];
    NSMutableArray *array=[[NSMutableArray alloc] initWithContentsOfFile:filename];
    return array;
}

//解析文件得到可变字典
+ (id)parseObjectFromFile:(NSString *)file
{
    NSString *filename=[PATH_OF_DOCUMENT stringByAppendingPathComponent:file];
    //NSString *filename = [[NSBundle mainBundle] pathForResource:file/*@"personal"*/ ofType:@"plist"];
    NSData *data=[NSData dataWithContentsOfFile:filename];
    return data;
}

//解析文件得到字典
+ (NSDictionary *)parseDicFromFile:(NSString *)file
{
    NSString *filename=[PATH_OF_DOCUMENT stringByAppendingPathComponent:file];
    //NSString *filename = [[NSBundle mainBundle] pathForResource:file/*@"personal"*/ ofType:@"plist"];
    NSDictionary *dictionary=[[NSDictionary alloc] initWithContentsOfFile:filename];
    
    return dictionary;
}

//解析文件得到字符串
+ (NSString *)parseStringFromFile:(NSString *)file
{
    NSString *filename=[PATH_OF_DOCUMENT stringByAppendingPathComponent:file];
    //NSString *filename = [[NSBundle mainBundle] pathForResource:file/*@"personal"*/ ofType:@"plist"];
    NSString *content=[NSString stringWithContentsOfFile:filename encoding:NSUTF8StringEncoding error:nil];
    return content;
}

//移除文件
+ (void)removeFile:(NSString *)fileName
{
    NSString *dataPath=[PATH_OF_DOCUMENT stringByAppendingPathComponent:fileName];
    NSError *error = nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:dataPath]) {
        [fileManager removeItemAtPath:dataPath error:&error];
    }
}

@end
