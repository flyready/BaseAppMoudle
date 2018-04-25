//
//  OC_PickerManager.m
//  Created by jiangmm on 17/4/14.
//  Copyright (c) 2015年 YUNSHANG ALERATION. All rights reserved.

#import "OC_PickerManager.h"

@implementation OC_PickerManager

+ (OC_PickerManager *)sharedManager {
    static OC_PickerManager *shared_manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        shared_manager = [[self alloc] init];
        shared_manager.shiArray = [self jsonObject:@"shi.json"];
        shared_manager.xianArray  = [self jsonObject:@"xian.json"];
    });
    return shared_manager;
}

+ (id)jsonObject:(NSString *)jsonStr {
    
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:jsonStr ofType:nil];
    NSData *jsonData   = [[NSData alloc] initWithContentsOfFile:jsonPath];
    NSError *error = nil;
    id jsonObject      = [NSJSONSerialization JSONObjectWithData:jsonData
                         options:NSJSONReadingAllowFragments error:&error];
    if (jsonObject) {
        return jsonObject;
    }
    return @[];
}

@end
