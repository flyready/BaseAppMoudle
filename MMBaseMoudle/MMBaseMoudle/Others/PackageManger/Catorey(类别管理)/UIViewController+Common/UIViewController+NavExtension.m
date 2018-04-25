//
//  UIView+ZTExtension.m
//  BlockUseDemo
//
//  Created by quiet on 15/7/15.
//  Copyright (c) 2015年 quiet. All rights reserved.
//

#import "UIViewController+NavExtension.h"
#import "BMLNavigationController.h"

@implementation UIViewController (NavExtension)
//  获取当前 导航条里 所有的 数组
-(NSArray *)currentNavViewControllers
{
    NSArray *viewControllers = @[];
    id rNav = self.navigationController;
    //DLog(@"  - -- - - - - -   rNav   - - -  %@",rNav);
    //  自定义的  导航条
    if ([rNav isKindOfClass:[BMLNavigationController class]]) {
        viewControllers = [(BMLNavigationController *)rNav rt_viewControllers];
    }
    //  Rt导航条  防止bug
    else if ([rNav isKindOfClass:[RTContainerNavigationController class]]) {
        viewControllers = [(BMLNavigationController *)rNav rt_viewControllers];
    }
    //  系统的导航条  防止bug
    else if ([rNav isKindOfClass:[UINavigationController class]]) {
        viewControllers = [(UINavigationController *)rNav viewControllers];
    }
    return viewControllers;
}

@end
