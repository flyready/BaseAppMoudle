//
//  UserYTJ.m
//  HomeHome
//
//  Created by 谢泽锋 on 2016/10/25.
//  Copyright © 2016年 Victor. All rights reserved.
//

#import "UserObject.h"
#import <objc/runtime.h>
//#import "PHProgressHUD.h"
//#import "LocationHelper.h"
#define Path @"Documents/use.src"

static UserObject *USER;

@implementation UserObject

// 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{
             @"desc" : @"desciption"
             };
}


-(NSString *)city
{
    if (!_city) {
        _city = @"";//广州
    }
    return _city;
}

//SingletonM(User);
+(UserObject*)shareUser
{
    if (!USER) {
        USER = [[UserObject alloc]init];
    }
    return USER;
}
-(NSString *)hotel_id{
    if (!_hotel_id||(![_hotel_id integerValue])) {
        return @"";
    }
    return _hotel_id;
}

-(NSString *)nickname{
    if (!_nickname) {
        return @"";
    }
    return _nickname;
}
-(NSString *)token{
    if (!_token) {
        return @"";
    }
    return  _token;
}

-(NSString *)user_id{
    if (!_user_id) { return @""; }
    return _user_id;
}

-(NSString *)longitude{
    if ([CustomUtils ISNULL:_longitude]) { HHLog(@"无经度");
        return @"113.327855";
    }
    return _longitude;
}
-(NSString *)latitude{
    if ([CustomUtils ISNULL:_longitude]) { HHLog(@"无纬度");
        return @"23.121078";
    }
    return _latitude;
}

+(void)WriteObject:(UserObject*)object ObjectName:(NSString*)name
{
    NSString * names =  [NSString stringWithFormat:@"Documents/%@.src",name];
    NSString * path =[NSHomeDirectory() stringByAppendingPathComponent:names];
    NSMutableData * data =[NSMutableData data];
    NSKeyedArchiver * archive=[[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    [archive encodeObject:object forKey:name];
    [archive finishEncoding];
    if( ![data writeToFile:path atomically:YES]){
        NSLog(@"归档失败");
    };
}

+(instancetype)GetObjectName:(NSString*)name
{
    //    NSLog(@"读取%@",name);
    NSString * names =  [NSString stringWithFormat:@"Documents/%@.src",name];
    
    //读取归档文件
    NSString * paths =[NSHomeDirectory() stringByAppendingPathComponent:names];
    NSData * content =[NSData dataWithContentsOfFile:paths];
    NSKeyedUnarchiver * unarchiver=[[NSKeyedUnarchiver alloc]initForReadingWithData:content];
    UserObject * user = [unarchiver decodeObjectForKey:name];
    //    NSLog(@"读取%@   %@",name,user.user_name);
    
    return user;//根据key 找到对象
}

+(UserObject*)isLogin
{
    NSString * path =[NSHomeDirectory() stringByAppendingPathComponent:Path];
    //读取归档文件
    NSData * content =[NSData dataWithContentsOfFile:path];
    NSKeyedUnarchiver * unarchiver=[[NSKeyedUnarchiver alloc]initForReadingWithData:content];
    USER=[unarchiver decodeObjectForKey:@"user"];//根据key 找到对象
    //    if (USER) {
    //        return YES;
    //    }
//    BBLog(@"USER.TaoBaoID =====  %@",USER.TaoBaoID);
    //    NSLog();
    return USER;
}
// 解档
- (id)initWithCoder:(NSCoder *)aDecoder{
    // 取得所有成员变量名
    NSArray *properNames = [[self class] propertyOfSelf];
    NSLog(@"%@",properNames);
    for (NSString *propertyName in properNames) {
        // 创建指向属性的set方法
        // 1.获取属性名的第一个字符，变为大写字母
        NSString *firstCharater = [propertyName substringToIndex:1].uppercaseString;
        // 2.替换掉属性名的第一个字符为大写字符，并拼接出set方法的方法名
        NSString *setPropertyName = [NSString stringWithFormat:@"set%@%@:",firstCharater,[propertyName substringFromIndex:1]];
        SEL setSel = NSSelectorFromString(setPropertyName);
        [self performSelector:setSel withObject:[aDecoder decodeObjectForKey:propertyName]];
    }
    return  self;
}
// 归档
- (void)encodeWithCoder:(NSCoder *)enCoder{
    // 取得所有成员变量名
    NSArray *properNames = [[self class] propertyOfSelf];
    
    for (NSString *propertyName in properNames) {
        // 创建指向get方法
        SEL getSel = NSSelectorFromString(propertyName);
        // 对每一个属性实现归档

        if ([self performSelector:getSel]) {
            [enCoder encodeObject:[self performSelector:getSel] forKey:propertyName];
        }

    }
}
// 返回self的所有对象名称
+ (NSArray *)propertyOfSelf{
    //    OBJC_EXPORT Ivar *class_copyIvarList(Class cls, unsigned int *outCount);
    
    unsigned int count;
    // 1. 获得类中的所有成员变量
    Ivar *ivarList = class_copyIvarList(self, &count);
    
    NSMutableArray *properNames =[NSMutableArray array];
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivarList[i];
        
        // 2.获得成员属性名
        NSString *name = [NSString stringWithUTF8String:ivar_getName(ivar)];
        
        // 3.除去下划线，从第一个角标开始截取
        NSString *key = [name substringFromIndex:1];
        
        [properNames addObject:key];
    }
    
    return [properNames copy];
}

//就这样，我们实现了对一个类实现自动归档的类，下次需要创建一个Model类时，只要继承自我们编写的这个类，就能实现自动归档啦，是不是很轻松呢。其实拿到类的属性名可以扩展很多内容，例如我们每次打印Model类的时候，都需要一个model里的属性都拼接出来，利用我们刚刚写的代码，重写description方法，就能实现在NSLog的时候把对象里的每个属性和值都打印出来了

- (NSString *)description{
    NSMutableString *descriptionString = [NSMutableString stringWithFormat:@"\n"];
    // 取得所有成员变量名
    NSArray *properNames = [[self class] propertyOfSelf];
    for (NSString *propertyName in properNames) {
        // 创建指向get方法
        SEL getSel = NSSelectorFromString(propertyName);
        NSString *propertyNameString = [NSString stringWithFormat:@"%@ - %@\n",propertyName,[self performSelector:getSel]];
        [descriptionString appendString:propertyNameString];
    }
    return [descriptionString copy];
}
- (void)outLogin
{
    NSString * path =[NSHomeDirectory() stringByAppendingPathComponent:Path];
    NSMutableData * data =[NSMutableData data];
    NSKeyedArchiver * archive=[[NSKeyedArchiver alloc]initForWritingWithMutableData:data];//二进制存储
    
    UserObject *user = [UserObject shareUser];
    user = [[UserObject alloc]init];
    USER = nil;
    user = nil;
    [archive encodeObject:user forKey:@"user"];//归档参数
    [archive finishEncoding];//结束归档
    [data writeToFile:path atomically:YES];//写入路径文件
    //  退出账号的  时候刷新 一下
//    [SZNotificationCenter postNotificationName:UpdateLoginFoot object:nil];
    
}
-(void)login
{
    //    NSString *localPath = @"Documents/use.src";
    
    NSString * path =[NSHomeDirectory() stringByAppendingPathComponent:Path];
    NSMutableData * data =[NSMutableData data];
    NSKeyedArchiver * archive=[[NSKeyedArchiver alloc]initForWritingWithMutableData:data];//二进制存储
    //    USER = [UserYTJ shareUser];
    [archive encodeObject:USER forKey:@"user"];//归档参数
    [archive finishEncoding];//结束归档
    BOOL isOK =[data writeToFile:path atomically:YES];//写入路径文件
    NSLog(@"isOK===%d",isOK);

}

@end
