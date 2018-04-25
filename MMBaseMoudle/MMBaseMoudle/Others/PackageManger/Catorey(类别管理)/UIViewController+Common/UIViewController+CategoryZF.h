//
//  UIViewController+CategoryZF.h
//  show
//
//  Created by 谢泽锋 on 2017/3/2.
//  Copyright © 2017年 xiezefeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (CategoryZF)
- (void)showLoading;
- (void)showLoadingAtWindow;
- (void)showMessage:(NSString*)message;
- (void)showMessage:(NSString*)message MessageDetail:(NSString*)Detail;
- (void)determinateExample:(UIButton *)sender ;
- (void)showMessageWithCancel:(NSString*)message;
- (void)showMessage:(NSString*)message ImageName:(NSString*)imageName;
- (void)showSuccess:(NSString*)message;
- (void)showError:(NSString*)message;
- (void)showSuccessAtWindow:(NSString*)message;
- (void)showErrorAtWindow:(NSString*)message;
- (void)dismissLoading;

@end
