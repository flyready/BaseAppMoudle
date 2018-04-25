//
//  OC_PickerManager.h
//  Common
//  Created by jiangmm on 17/4/14.
//  Copyright (c) 2015年 YUNSHANG ALERATION. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kPickerManager [OC_PickerManager sharedManager]
@interface OC_PickerManager : NSObject
@property (strong, nonatomic) NSArray *xianArray, *shiArray;

+ (OC_PickerManager *)sharedManager;

@end
