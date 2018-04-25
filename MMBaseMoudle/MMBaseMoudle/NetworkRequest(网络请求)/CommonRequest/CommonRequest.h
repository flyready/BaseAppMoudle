//
//  CommonRequest.h
//  HanyuSearchJoy
//
//  Created by 谢泽锋 on 2017/2/21.
//  Copyright © 2017年 HCL黄. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PayResult @"PayResult"
#define Response @"response"
#define chosePayType @"chosePayType"
#define Notifi [NSNotificationCenter defaultCenter]

//  **************   支付状态 枚举  **************    //
typedef NS_ENUM(NSInteger, kPayStatusType) {   //  支付状态
    kBlanceStatus = 1,  // 余额
    kAlipayStatus,  //  支付宝
    kWechatStatus   // 微信支付
};
/**
 上传图片
 */
@interface CommonRequest : NetworkRequest

/**
 支付
 */
+(void)type : (kPayStatusType)payType //1 余额  2 支付宝 3 微信
         oid:(NSString*)order_id //订单
    viewController:(UIViewController*)vc
     success:(void (^)(NSURLSessionDataTask *task, NSDictionary * responseObject))success
     failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
公共支付
 */
+(void)POSTPayType : (kPayStatusType)payType //1 余额  2 支付宝 3 微信
      interfaceName:(NSString*)name
         parameters:(NSDictionary*)parameter //参数
     viewController:(UIViewController*)vc //视图控制器
            success:(void (^)(NSURLSessionDataTask *task, NSDictionary * responseObject))success
            failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;


@end
