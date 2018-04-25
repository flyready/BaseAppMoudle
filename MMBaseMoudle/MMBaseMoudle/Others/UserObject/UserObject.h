//
//  UserObject.h
//  communityProgram
//
//  Created by 谢泽锋 on 16/6/14.
//  strongright © 2016年 高国峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "HomeModel.h"
//@class zquarterModel;

@interface UserObject : NSObject <NSCoding>

@property (nonatomic,strong) NSString *hotel_account;
@property (nonatomic, strong)NSString * username;
@property (nonatomic, strong)NSString * hotel_pwd;
@property (nonatomic, strong)NSString * add_time;
@property (nonatomic, strong)NSString * last_login;
@property (nonatomic, strong)NSString * last_ip;
@property (nonatomic, strong) NSString *pass;
@property (nonatomic, strong) NSString *huanxin_pwd;
@property (nonatomic, strong) NSString *huanxin;
@property (nonatomic,strong) NSString *service;
@property (nonatomic,strong) NSString *phone;

@property(nonatomic,strong)NSString * age;
@property(nonatomic,strong)NSString * created_time;
@property(nonatomic,strong)NSString * descriptions ;
@property(nonatomic,strong)NSString * growth_value;
@property(nonatomic,strong)NSString * head_image;
@property(nonatomic,strong)NSString * id;
@property(nonatomic,strong)NSString * images;
@property(nonatomic,strong)NSString * nickname;
@property(nonatomic,strong)NSString * pay_password;
@property(nonatomic,strong)NSString * phone_level;
@property(nonatomic,strong)NSString * phone_number;
@property(nonatomic,strong)NSString * qrcode;
@property(nonatomic,strong)NSString * sex;
@property(nonatomic,strong)NSString * token;
@property(nonatomic,strong)NSString * updated_time;
@property(nonatomic,strong)NSString * user_address;
@property(nonatomic,strong)NSString * user_online;
@property(nonatomic,strong)NSString * user_status;
@property(nonatomic,strong)NSString * hotel_id;
@property(nonatomic,strong)NSString * table_id;
@property(nonatomic,strong)NSMutableArray * allType;
@property(nonatomic,strong)NSString * city;
@property(nonatomic,strong)NSString * regon;
@property(nonatomic,strong)NSString * huanxin_number;
@property(nonatomic,strong)NSString * huanxin_password;
@property(nonatomic,copy)NSString * type;
@property(nonatomic,copy)NSString * group_name;
@property(nonatomic,copy)NSString * group_id;
@property(nonatomic,copy)NSString * user_id;
@property(nonatomic,copy)NSString * owner;
@property(nonatomic,copy)NSString * bg_cover;

@property (nonatomic, strong) NSString *hotel_name;

@property(nonatomic, strong)UIImage * localHead_Image;
@property (nonatomic, strong) NSString *address;//积分商品兑换的邮寄地址

@property(nonatomic, copy) NSString * store_name;
@property (nonatomic, copy) NSString *desc;
// 酒吧所在区域
@property(nonatomic, strong) NSString *storeCity;
@property (nonatomic, copy) NSString *head_img;
//是否是员工
@property (nonatomic, strong) NSString *manage_id;
//是否开启店铺 动态
@property (nonatomic, strong) NSString *is_valid;

@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *latitude;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *remark;


@property (nonatomic,strong) NSString *status;
@property (nonatomic,strong) NSString *avatar;
@property (nonatomic,strong) NSString *duty;
@property (nonatomic,strong) NSString *distance;

/**
 读取归档


 */
+(instancetype)GetObjectName:(NSString*)name;

+(void)WriteObject:(UserObject*)object ObjectName:(NSString*)name;

//- (void)updateInfo:(NSDictionary *)jsonData;


//- (void)encodeWithCoder:(NSCoder *)aCoder;
//- (nullable instancetype)initWithCoder:( NSCoder * _Nonnull )aDecoder;

//SingletonH(User);

/**
 创建用户对象
 
 @return user
 */
+(UserObject*)shareUser;
/**
 登录
 */
-(void)login;

/**
 退出登录
 */
-(void)outLogin;


/**
 是否已经登录
 */
+(UserObject*)isLogin;



@end
