//
//  VersionControl.h
//  HanyuSearchJoy
//
//  Created by YunShangCompany on 2017/4/19.
//  Copyright © 2017年 HCL黄. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kActionControl [ActionControl shareVerSington]

@interface ActionControl : NSObject

@property (nonatomic, assign) BOOL equelVersion, keyboardIsVisible;
@property (nonatomic, strong) NSString *demand_id;  // 行业id
@property (nonatomic, strong) NSString *hAddress;//首页滑动地址
@property (nonatomic,strong) NSString *startLat;
+ (ActionControl *)shareVerSington;


@end
