//
//  PayView.h
//  HanyuSearchJoy
//
//  Created by charmer on 17/2/16.
//  Copyright © 2017年 HCL黄. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayView : UIView
@property (nonatomic, copy) void(^payWayBlock)(NSInteger tag);//根据tag判断支付方式
//@property (nonatomic, copy) void(^clickBackViewBlock)();//门板点击Block
+ (instancetype)loadPayView;
@end
