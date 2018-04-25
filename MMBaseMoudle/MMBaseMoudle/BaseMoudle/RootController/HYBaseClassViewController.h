//
//  HYBaseClassViewController.h
//  HanyuSearchJoy
//
//  Created by YunShangCompany on 2017/6/22.
//  Copyright © 2017年 HCL黄. All rights reserved.
//
@interface HYBaseClassViewController : UIViewController
@property (strong, nonatomic) UIView *classView;
@property (nonatomic, strong) UserObject *user;
@property (nonatomic,assign) NSInteger type;
@property (nonatomic,strong) void(^HYBaseClassVCBlock)(void);
+ (UIViewController *)presentingVC;
- (void)popViewBack;
- (void)popRootBack:(BOOL)animated;
- (void)addBackItem;  //增加左边返回按钮
- (void)popClassCover:(UIBarButtonItem *)sender;

//- (void)showError:(NSString *)error;
//- (void)showSuccess:(NSString *)success;
//- (void)showLoadingHub;
//- (void)hideHub;

@end
