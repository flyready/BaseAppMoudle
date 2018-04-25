//
//  HYBaseClassViewController.m
//  HanyuSearchJoy
//
//  Created by YunShangCompany on 2017/6/22.
//  Copyright © 2017年 HCL黄. All rights reserved.
//

#import "HYBaseClassViewController.h"
#import "UIViewController+NavExtension.h"

@interface HYBaseClassViewController ()

@end

@implementation HYBaseClassViewController

-(UserObject *)user
{
    return [UserObject shareUser];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initObtion];
    if (self.type == 2) {
        [self setupNav];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    // 这里设置横竖屏不同颜色的statusbar
    // if (ZFPlayerShared.isLandscape) {
    //    return UIStatusBarStyleDefault;
    // }
    return UIStatusBarStyleDefault;
}

- (void)setupNav
{
    UIButton *letfButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    letfButton.contentHorizontalAlignment = 1;
    [letfButton setImage:[UIImage imageNamed:@"icon_navbackitem"] forState:UIControlStateNormal];
    
    [letfButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:letfButton];
   
    
}

- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
    if (self.HYBaseClassVCBlock) {
        self.HYBaseClassVCBlock();
    }
}

- (void)initObtion
{
    self.view.backgroundColor = ViewBackColor;
    
    self.classView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.classView setHeight:(self.view.height-64.f)];
    [self.view addSubview:self.classView];
    
}

+ (UIViewController *)presentingVC{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    UIViewController *result = window.rootViewController;
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [(UINavigationController *)result topViewController];
    }
    return result;
}

- (void)addBackItem  //增加左边返回按钮
{
    UIButton *letfButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    letfButton.contentHorizontalAlignment = 1;
    [letfButton setImage:[UIImage imageNamed:@"icon_navback"] forState:0];
    [letfButton addTarget:self action:@selector(popClassCover:)
                     forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:letfButton];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
}

- (void)popClassCover:(UIBarButtonItem *)sender
{
    NSArray *vControllers = [self currentNavViewControllers];
    if (vControllers.count >= 4) {
        [self.navigationController popToViewController:
         vControllers[vControllers.count-4] animated:YES];
    }else{
        [self popViewBack];
    }
}
/*
- (void)showError:(NSString *)error
{
    //_showErrorView(error, 2.f, self.classView);
}

- (void)showSuccess:(NSString *)success
{
    //_showSuccessView(success, 2.f, self.classView);
}

- (void)showLoadingHub
{
    //ShowIndicatorInView(self.classView);
}

- (void)hideHub
{
    //HideIndicatorInView(self.classView)
}
*/
- (void)popViewBack  // 返回上一级
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)popRootBack:(BOOL)animated
{
    [self.navigationController popToRootViewControllerAnimated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
