//
//  UIBarButtonItem+Extension.m
//  HanyuSearchJoy
//
//  Created by HCL黄 on 2017/1/9.
//  Copyright © 2017年 HCL黄. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+(UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageNmae target:(id)target action:(SEL)action{
    
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:imageName] forState:(UIControlStateNormal)];
    [button setImage:[UIImage imageNamed:highImageNmae] forState:(UIControlStateHighlighted)];
    button.size = CGSizeMake(34, 34);
    
    //监听按钮点击
    [button addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}
+(UIBarButtonItem *)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    UIButton *button = [[UIButton alloc] init];
    [button setTitleColor:[UIColor whiteColor] forState:0];
    [button setTitle:title forState:0];
    button.titleLabel.font = [UIFont systemFontOfSize:15.0];
    //设置按钮的尺寸
    button.size = CGSizeMake(34, 34);
    
    //监听按钮点击
    [button addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)itemLeftTarget:(id)target action:(SEL)action{
    UIButton *letfButton = [[UIButton alloc]initWithFrame:
                    CGRectMake(0, 0, 30, 40)];
    [letfButton setImage:[UIImage imageNamed:@"icon_navbackitem"] forState:UIControlStateNormal];
    letfButton.contentHorizontalAlignment = 1;
    //监听按钮点击
    [letfButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:letfButton];
}

+ (UIBarButtonItem *)itemLeftWithImage:(NSString *)imageName target:(id)target action:(SEL)action{
    UIButton *letfButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
    [letfButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    letfButton.contentHorizontalAlignment = 1;
    //监听按钮点击
    [letfButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:letfButton];
}

+ (UIBarButtonItem *)itemWithImage:(NSString *)imageName target:(id)target action:(SEL)action{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 40)];
    [button setImage:[UIImage imageNamed:imageName] forState:(UIControlStateNormal)];
    button.contentHorizontalAlignment = 2;
    //监听按钮点击
    [button addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
