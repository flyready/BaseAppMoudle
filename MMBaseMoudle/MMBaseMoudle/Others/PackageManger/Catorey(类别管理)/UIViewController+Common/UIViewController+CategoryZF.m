//
//  UIViewController+CategoryZF.m
//  show
//
//  Created by 谢泽锋 on 2017/3/2.
//  Copyright © 2017年 xiezefeng. All rights reserved.
//

#import "UIViewController+CategoryZF.h"
//#import "PHProgressHUD.h"
@implementation UIViewController (CategoryZF)

- (void)showLoading
{
    ShowIndicatorInView(self.view);
    //[PHProgressHUD showSingleWheelInView:self.view];
}

- (void)showLoadingAtWindow
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    ShowIndicatorInView(window);
    //[PHProgressHUD showSingleWheelInView:window];
}

- (void)showMessage:(NSString*)message{
    ShowIndicatorTextInView(self.view, message);
    //[PHProgressHUD showSingeWheelWithMsg:message view:nil];
}

- (void)showMessage:(NSString*)message MessageDetail:(NSString*)Detail
{
    //[PHProgressHUD showSingleWheelWithSingelMsg:message detailMsg:Detail view:nil];
}

- (void)determinateExample:(UIButton *)sender {
    //[PHProgressHUD showSingleProgressView:nil];
    ShowIndicatorInView(self.view);
}
- (void)showMessageWithCancel:(NSString*)message {
   //[[PHProgressHUD shareManager] showSingleProgressViewWithCancle:nil singleMsg:message buttonTitle:@"取消"];
}

-(void)showMessage:(NSString*)message ImageName:(NSString*)imageName
{
    //自定义
    //[PHProgressHUD showSingleCustonImageSetmsg:message view:nil imageName:imageName setSquare:YES];
}

- (void)showSuccess:(NSString*)message
{
    HideIndicatorInView(self.view);
    //[self dismissLoading];
//    + (void)showSuccess:(NSString *)success toView:(UIView *)view
    ShowSuccessOnView(message, self.view);
    //[PHProgressHUD showSuccess:message toView:self.view];


}
- (void)showError:(NSString*)message
{
    //[self dismissLoading];
    HideIndicatorInView(self.view);
    ShowErrorOnView(message, self.view);
    //[PHProgressHUD showError:message toView:self.view];
    
}

- (void)showSuccessAtWindow:(NSString*)message
{
    //[self dismissLoading];
    HideIndicatorInView(self.view);
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //[PHProgressHUD showSuccess:message toView:window];
    ShowSuccessOnView(message, window);
}

- (void)showErrorAtWindow:(NSString*)message
{
    //[self dismissLoading];
    HideIndicatorInView(self.view);
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    ShowErrorOnView(message, window);
    
}
- (void)dismissLoading{
    HideIndicatorInView(self.view);
    //[PHProgressHUD dismissLoading];
}


@end
