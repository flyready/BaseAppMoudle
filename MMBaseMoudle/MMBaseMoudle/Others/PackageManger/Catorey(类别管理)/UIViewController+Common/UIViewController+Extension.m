//
//  UIViewController+Extension.m
//  HanyuSearchJoy
//
//  Created by 覃盼 on 2017/1/12.
//  Copyright © 2017年 HCL黄. All rights reserved.
//

#import "UIViewController+Extension.h"

@implementation UIViewController (Extension)
+(instancetype)controllerFormSTB
{
    UIStoryboard * story = [UIStoryboard storyboardWithName:NSStringFromClass(self) bundle:MainBunlde];
   return [story instantiateViewControllerWithIdentifier:NSStringFromClass(self)];
}


@end
