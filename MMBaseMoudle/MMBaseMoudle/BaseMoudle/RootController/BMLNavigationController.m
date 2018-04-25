//
//  HHNavigationController.m
//  HanyuSearchJoy
//
//  Created by HCL黄 on 2017/1/6.
//  Copyright © 2017年 HCL黄. All rights reserved.
//

#import "BMLNavigationController.h"

@interface BMLNavigationController ()

@end

@implementation BMLNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [BMLNavigationController setAppearanceBar];
   [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
}

/*
+ (void)initialize
{
    [BMLNavigationController setAppearanceBar];
}
*/

+ (void)setAppearanceBar
{
   // UIColor *fTextColor = [UIColor whiteColor];
     UIColor *fTextColor = RGBCOLOR(51, 51, 51);
    // 自定义导航
    UINavigationBar *appearance = [UINavigationBar appearance];
    [appearance setBarTintColor:[UIColor whiteColor]];
    
    //[appearance setBarTintColor:UIColorFromRGB(0x007a87)];
//    [appearance setBackgroundImage:[UIImage imageNamed:@"STNavgationBar"]
//                     forBarMetrics:UIBarMetricsDefault];
    [appearance setShadowImage:[UIImage new]];
    [appearance setTintColor:fTextColor];
    NSDictionary *attributeName = @{
                            NSForegroundColorAttributeName : fTextColor,
                            NSFontAttributeName : SYSTEMFONT(18)
                        };
    // 3.标题
    [appearance setTitleTextAttributes:attributeName];
    UIColor *gColor = WholeColor;
    [[UISearchBar appearance] setTintColor:gColor];
    [[UITextField appearance] setTintColor:gColor];
    [[UITextView appearance] setTintColor:gColor];
    
    
}

- (void)popUpCovtroller
{
    [self popViewControllerAnimated:YES];
}

-(UIViewController *) popViewControllerAnimated:(BOOL)animated{
    UIViewController *returnController = [super popViewControllerAnimated:animated];
    return returnController;
}

-(void) pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.childViewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
        UIButton *letfButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        letfButton.contentHorizontalAlignment = 1;
        [letfButton setImage:[UIImage imageNamed:@"STYYQLeft"] forState:UIControlStateNormal];

        [letfButton addTarget:self action:@selector(popUpCovtroller) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:letfButton];
        viewController.navigationItem.leftBarButtonItem = leftBarButtonItem;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
