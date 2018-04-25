//
//  NetworkRequest.m
//  HanyuSearchJoy
//
//  Created by 谢泽锋 on 2017/2/20.
//  Copyright © 2017年 HCL黄. All rights reserved.
//

#import "NetworkRequest.h"
#import "JudustLogin.h"
#import "MyScrollingImagePicker.h"


//#import "DKProgressHUD.h"
#define maxTimeOut 10.f

@implementation NetworkRequest
+(void)POSTRequest:(NSString *)InterfaceName
        parameters:(id)parameters
           success:(void (^)(NSURLSessionDataTask *task, NSDictionary * responseObject))success
           failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    NSString * requestURL = [NSString stringWithFormat:@"%@%@",HYURL,InterfaceName];
    //NSLog(@"=====requestURL ===  %@",requestURL);
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];// 请求
    [manager.requestSerializer setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    manager.requestSerializer.timeoutInterval = maxTimeOut;

    DLog(@"parameters ===  %@   -- - -   url  - -- %@",parameters,requestURL);
    //NSLog(@"InterfaceName ==== = %@",InterfaceName);

    [manager POST:requestURL parameters:parameters progress:nil success:
     ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //NSLog(@"++++++++)0000%@",responseObject);
        if ([responseObject[@"code"] integerValue] == 301) {
            failure(task, nil); //清空个人信息
            [[UserObject shareUser] outLogin];
            [[[HYAlertView alloc] initWithTitle:@"请登录后再操作" icon:nil message:nil
                            block:^(HYAlertView *alertView, NSInteger buttonIndex) {
                if (buttonIndex) {
                    Dispatch_AfterCall(.4, [JudustLogin judustUserIsLogin:[UIApplication sharedApplication].keyWindow.rootViewController])
                }
            } buttonTitles:@"取消", @"立即登录" , nil] show];
            return;
        }

        DLog(@" ===  responseObject  - -- %@",responseObject);
 
        success(task, [CustomUtils dataHandle:responseObject]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"error ===   -- - -   - -- %@",error);
        failure(task,error);
        //HideIndicatorInView(kHHKeyWindow);
        //[PHProgressHUD dismissLoading];
    }];
}
+(void)GETRequest:(NSString *)InterfaceName
       parameters:(id)parameters
          success:(void (^)(NSURLSessionDataTask *task, NSDictionary * responseObject))success
          failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    NSString * requestURL = [NSString stringWithFormat:@"%@%@", HYURL,InterfaceName];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];// 请求
    [manager.requestSerializer setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    /*
    [AFHTTPResponseSerializer serializer].acceptableContentTypes =[NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",nil];*/
    manager.requestSerializer.timeoutInterval = maxTimeOut;
    DLog(@"parameters ===  %@   -- - -   url  - -- %@",parameters,requestURL);
    [manager GET:requestURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DLog(@" ===  responseObject  - -- %@",responseObject);
        if ([responseObject[@"code"] integerValue] == 301) {
            failure(task, nil); //清空个人信息
            [[UserObject shareUser] outLogin];
             [[[HYAlertView alloc] initWithTitle:@"请登录后再操作" icon:nil message:nil block:^(HYAlertView *alertView, NSInteger buttonIndex) {
                 if (buttonIndex) {
                     Dispatch_AfterCall(.4, [JudustLogin judustUserIsLogin:[UIApplication sharedApplication].keyWindow.rootViewController])
                 }
             } buttonTitles:@"取消", @"立即登录" , nil] show];
            return;
        }
        success(task, [CustomUtils dataHandle:responseObject]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"error ===   -- - -   - -- %@",error);
        failure(task,error);
        //HideIndicatorInView(kHHKeyWindow);
        //[PHProgressHUD dismissLoading];
    }];
}

#pragma makr - 开始监听网络连接
+ (void)startMonitoring:(WYQNetworkStatusBlock)block
{
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    // 2.设置网络状态改变后的处理
    __block BOOL hasNetwork;
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status){
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                hasNetwork = YES;
                break;
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                hasNetwork = NO;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                hasNetwork = YES;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                hasNetwork = YES;
                break;
        }
        if (block) { block(hasNetwork); }
    }];
    [mgr startMonitoring];
}
/*
+ (void)requestShopCartWith:(NSString *)activityId good_id:(NSString *)good_id success:(void (^)(NSURLSessionDataTask *task, NSDictionary * responseObject))success
{
    ShowIndicatorInView(kHHKeyWindow);
    NSMutableDictionary *parma = [NSMutableDictionary dictionary];
    UserObject *user = [UserObject shareUser];
    [parma setValue:user.hotel_id forKey:@"hotel_id"];
    [parma setValue:user.token forKey:@"key"];
    [parma setValue:activityId forKey:@"activity_id"];
    [parma setValue:good_id forKey:@"goods_id"];
    [NetworkRequest POSTRequest:HY_CartAdd parameters:parma success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        //DLog(@"  -- - -  responseObject  - -- %@",responseObject);
        HideIndicatorInView(kHHKeyWindow);
        if (SUCCESS) {
            ShowSuccessOnWindow(@"添加购物车成功");
            //[SZNotificationCenter postNotificationName:RefreshShopCart object:nil userInfo:nil];
            success ? success(task,responseObject) : nil;
        }else{
            ShowErrorOnWindow(ReturnMsg);
            //[PHProgressHUD showError:ReturnMsg toView:kHHKeyWindow];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //[PHProgressHUD dismissLoading];
        HideIndicatorInView(kHHKeyWindow);
    }];
}
*/




@end
