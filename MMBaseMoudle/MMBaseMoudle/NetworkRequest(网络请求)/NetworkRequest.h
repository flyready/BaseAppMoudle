//
//  NetworkRequest.h
//  HanyuSearchJoy
//
//  Created by 谢泽锋 on 2017/2/20.
//  Copyright © 2017年 HCL黄. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
typedef NS_ENUM(NSInteger, OperationType) {
    OperationTypeNone,
    OperationTypeEnd,
    OperationTypeUnHeart,
    OperationTypeHeart,
    OperationTypeSkip,
    OperationTypeBan,
    OperationTypePlay
};
@interface NetworkRequest : NSObject



/**
 *  实时检测网络状态
 *
 *  block 返回
 */
typedef void (^WYQNetworkStatusBlock)(BOOL networkStatus);

/**
 post请求

 @param InterfaceName 接口名
 @param parameters    参数

 */
+(void)POSTRequest:(NSString *)InterfaceName
        parameters:(id)parameters
           success:(void (^)(NSURLSessionDataTask *task, NSDictionary * responseObject))success
           failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
/**
Get请求
 
 @param InterfaceName 接口名
 @param parameters    参数

 */
+(void)GETRequest:(NSString *)InterfaceName
        parameters:(id)parameters
           success:(void (^)(NSURLSessionDataTask *task, NSDictionary * responseObject))success
           failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;




/**
 *  网络壮态
 */
+ (void)startMonitoring:(WYQNetworkStatusBlock)block;

/**
 *  添加购物车
 */
//+ (void)requestShopCartWith:(NSString *)activityId good_id:(NSString *)good_id success:(void (^)(NSURLSessionDataTask *task, NSDictionary * responseObject))success;











@end
