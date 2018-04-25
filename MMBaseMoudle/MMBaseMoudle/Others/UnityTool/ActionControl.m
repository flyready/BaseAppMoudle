//
//  VersionControl.m
//  HanyuSearchJoy
//
//  Created by YunShangCompany on 2017/4/19.
//  Copyright © 2017年 HCL黄. All rights reserved.
//

#import "ActionControl.h"

@implementation ActionControl

+ (ActionControl *)shareVerSington
{
    static ActionControl *verSingleton;
    @synchronized(self)
    {
        if (!verSingleton){
            verSingleton = [[ActionControl alloc] init];
        }
        return verSingleton;
    }
}

- (id)init{
    self = [super init];
    if (self) {
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center addObserver:self selector:@selector(keyboardDidShow)
                       name:UIKeyboardDidShowNotification object:nil];
        [center addObserver:self selector:@selector(keyboardDidHide)
                       name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}



- (void)keyboardDidShow
{
    _keyboardIsVisible = YES;
}

- (void)keyboardDidHide
{
    _keyboardIsVisible = NO;
}

- (BOOL)keyboardIsVisible
{
    return _keyboardIsVisible;
}



@end
