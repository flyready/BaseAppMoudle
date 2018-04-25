//
//  CommonRequest.m


#import "CommonRequest.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>
#import "HYPayAlertView.h"
#import "DKProgressHUD.h"
//#import "ChangePayPasswordViewController.h"

@implementation CommonRequest

+(void)POSTPayType : (kPayStatusType)payType //1 余额  2 支付宝 3 微信
      interfaceName: (NSString*)name
           parameters: (NSDictionary*)parameter //订单
     viewController: (UIViewController*)vc //视图控制器
            success: (void (^)(NSURLSessionDataTask *task, NSDictionary * responseObject))success
            failure: (void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param addEntriesFromDictionary:parameter];
    [vc dismissLoading];
    if (payType == kBlanceStatus){
        if ([UserObject shareUser].pay_password.length == 0 || [[UserObject shareUser].pay_password integerValue] == 0){//支付密码支付判断是否有设置支付密码
//            ChangePayPasswordViewController *pwdVc = [ChangePayPasswordViewController controllerFormSTB];
//            [vc.navigationController pushViewController:pwdVc animated:YES];
            return;
        }else{
            [CommonRequest param:param name:name viewController:vc success:success failure:failure];
        }
    }
    if (payType != kBlanceStatus){
        [vc showLoading];

        [self POSTRequest:name parameters:param success:
         ^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
            [vc dismissLoading];
            if (SUCCESS) {
                //success(task,responseObject);
                if(payType == kAlipayStatus){
                    NSDictionary * responseData = responseObject[@"data"];
                    //NSLog(@"  - - - responseData   orderString - -%@",responseData[@"orderString"]);
                    [[AlipaySDK defaultService] payOrder:responseData[@"orderString"] fromScheme:@"AAlipaySevenTurnip" callback:^(NSDictionary *resultDic) {
                        if ([resultDic[@"resultStatus"] integerValue]==9000) {
                            success(task,resultDic);
                        }else{
                            [vc showError:resultDic[@"memo"]];
                        }
                    }];
                }else{
                    //微信支付
                    NSDictionary * responseData = responseObject[@"data"];
                    NSDictionary * data = responseData[@"orderString"];
                    PayReq* req             = [[PayReq alloc] init];
                    int time = [data[@"time"] intValue];
                    [WXApi registerApp:data[@"appid"]];
                    req.partnerId           = data[@"mch_id"];
                    req.prepayId            = data[@"prepay_id"];
                    req.nonceStr            = data[@"nonce_str"];
                    req.timeStamp           = time;
                    req.package             = data[@"package"];
                    req.sign                = data[@"sign"];
                    [WXApi sendReq:req];
                }
                success(task,responseObject);
            }else{
                [vc showError:ReturnMsg];
                //[PHProgressHUD showError:ErrorMessage toView:VC.view];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [vc dismissLoading];
        }];
    }
}

+ (void)param:(NSMutableDictionary *)param name:(NSString *)name viewController:(UIViewController*)vc
      success:(void (^)(NSURLSessionDataTask *task, NSDictionary * responseObject))success
      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    //DLog(@"  - -- - - - - - -- vc-----  %@",vc);
    HYPayAlertView *payAlert = [HYPayAlertView new];
    payAlert.detail = @"";
    payAlert.aMount = [param[@"amount"] floatValue];
    [payAlert show];
    WEAKSELF
    payAlert.completeHandle = ^(NSString *inputPwd) {
        [vc showLoading];
        [param setValue:[inputPwd md5Str] forKey:@"pay_password"];
        [weakSelf POSTRequest:name parameters:param success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
            DLog(@"-mima---->>>%@ - - -   %@",responseObject,ReturnMsg);
            [vc dismissLoading];
            NSInteger index;
            if (SUCCESS) {//failure(error);
                [vc showSuccess:ReturnMsg];
                index = kBlanceStatus;
                success(task,responseObject);
            }else{
                [vc showError:ReturnMsg];
                index = 0;
            }
            [Notifi postNotificationName:PayResult object:@(index) userInfo:nil];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [vc dismissLoading];
            failure(task, error);
        }];
    };
    /*
    payAlert.cancelHandle = ^{
        NSNotificationCenter *notify = [NSNotificationCenter defaultCenter];
        [notify postNotificationName:@"KHideKeyBoard" object:nil userInfo:nil];
    };*/
}

+(void)type : (kPayStatusType)payType //1 余额  2 支付宝 3 微信
           oid:(NSString*)order_id //订单
            viewController:(UIViewController*)vc
            success:(void (^)(NSURLSessionDataTask *task, NSDictionary * responseObject))success
            failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    HYPayAlertView *payAlert = [HYPayAlertView new];
    payAlert.detail = @"";
    payAlert.aMount = 0.f;
    [payAlert show];
    payAlert.completeHandle = ^(NSString *inputPwd) {
        [vc showLoading];
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setValue:[UserObject shareUser].token forKey:@"key"];
        [param setValue:order_id forKey:@"order_id"];
        [param setValue:@(payType) forKey:@"pay_type"];
        [param setValue:[inputPwd md5Str] forKey:@"pay_password"];
        [self POSTRequest:@"" parameters:param success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
            NSLog(@"%@",responseObject);
            [vc dismissLoading];
            if (payType == kBlanceStatus) {
                NSInteger index;
                if (SUCCESS) {
                    index = kBlanceStatus;
                    [vc showSuccess:ReturnMsg];
                }else{
                    index = 0;
                }
                [Notifi postNotificationName:PayResult object:@(index) userInfo:nil];
            }else if(payType==kAlipayStatus){
                NSDictionary * responseData = responseObject[@"responseData"];
                // NOTE: 调用支付结果开始支付
                [[AlipaySDK defaultService] payOrder:responseData[@"private_key"] fromScheme:@"AlipayHanyuSearchJoy" callback:^(NSDictionary *resultDic) {
                    //success(task,resultDic);
                }];
            }else{
                //success(task,responseObject);
                NSDictionary * responseData = responseObject[@"responseData"];
                NSDictionary * data = responseData[@"pay_data"];
                PayReq* req             = [[PayReq alloc] init];
                int time = [data[@"time"] intValue];
                [WXApi registerApp:data[@"appid"]];
                req.partnerId           = data[@"mch_id"];
                req.prepayId            = data[@"prepay_id"];
                req.nonceStr            = data[@"nonce_str"];
                req.timeStamp           = time;
                req.package             = data[@"package"];
                req.sign                = data[@"sign"];
                [WXApi sendReq:req];
            }
            //success(task,responseObject);
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [vc dismissLoading];
        }];
    };
}

@end
