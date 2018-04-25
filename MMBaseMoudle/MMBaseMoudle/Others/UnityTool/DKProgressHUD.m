//
//  DKProgressHUD.m
//  portfolio
//
//  Created by 张奥 on 14-9-15.
//  Copyright (c) 2014年 DKHS. All rights reserved.
//

#import "DKProgressHUD.h"
#import "NSString+Common.h"

UIView *_getTargetView(UIView *view) {
    if ([view isKindOfClass:[UIScrollView class]]) {
        return (view.superview == nil ? view : view.superview);
    } else {
        return view;
    }
}

MBProgressHUD *_showTipsView(NSString *text, float duration_time, UIView *view) {
    UIView *targetView = _getTargetView(view);
    
    [MBProgressHUD hideHUDForView:targetView animated:NO];
    if ([NSString isBlank:text]) {
        return nil;
    }
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:targetView];
    hud.bezelView.backgroundColor = RGBCOLOR(51, 51, 51);
    hud.mode = MBProgressHUDModeText;
   // hud.detailsLabelText = text;
    hud.detailsLabel.text = text;
   // hud.detailsLabelFont = [UIFont systemFontOfSize:15];
    hud.detailsLabel.font = [UIFont systemFontOfSize:15.0];
    hud.detailsLabel.textColor = [UIColor whiteColor];
    hud.margin = 12;
    hud.removeFromSuperViewOnHide = YES;
    hud.userInteractionEnabled = NO;
    [hud setYOffset:hud.y];
    [hud setXOffset:hud.x];
    [targetView addSubview:hud];
    [hud show:YES];
    [hud hide:YES afterDelay:duration_time];
    return hud;
}

MBProgressHUD *_showSuccessView(NSString *text, float duration_time, UIView *view) {
    UIView *targetView = _getTargetView(view);
    
    [MBProgressHUD hideHUDForView:targetView animated:NO];
    if ([NSString isBlank:text]) {
        return nil;
    }
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:targetView];
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hub_success"]];
    hud.detailsLabelText = text;
    hud.detailsLabelFont = [UIFont systemFontOfSize:15];
    hud.margin = 25;
    hud.removeFromSuperViewOnHide = YES;
    hud.userInteractionEnabled = NO;
    [hud setYOffset:hud.y];
    [hud setXOffset:hud.x];
    [targetView addSubview:hud];
    [hud show:YES];
    [hud hide:YES afterDelay:duration_time];
    return hud;
}

MBProgressHUD *_showErrorView(NSString *text, float duration_time, UIView *view) {
    UIView *targetView = _getTargetView(view);
    
    [MBProgressHUD hideHUDForView:targetView animated:NO];
    if ([NSString isBlank:text]) {
        return nil;
    }
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:targetView];
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hub_alert"]];
    hud.detailsLabelText = text;
    hud.detailsLabelFont = [UIFont systemFontOfSize:15];
    hud.margin = 25;
    hud.removeFromSuperViewOnHide = YES;
    hud.userInteractionEnabled = NO;
    [hud setYOffset:hud.y];
    [hud setXOffset:hud.x];
    [targetView addSubview:hud];
    [hud show:YES];
    [hud hide:YES afterDelay:duration_time];
    return hud;
}

MBProgressHUD *_showTinyClearIndicator(UIView *view) {
    UIView *targetView = _getTargetView(view);
    
    [MBProgressHUD hideHUDForView:targetView animated:NO];
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:targetView];
    hud.mode = MBProgressHUDModeCustomView;
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [indicatorView startAnimating];
    hud.customView = indicatorView;
    hud.color = [UIColor clearColor];
    hud.removeFromSuperViewOnHide = YES;
    [targetView addSubview:hud];
    [hud show:YES];
    return hud;
}

@implementation DKProgressHUD

- (instancetype)initWithView:(UIView *)view {
    self = [super initWithView:view];
    if (self) {
//        self.opacity = 0.3;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    [self setNeedsDisplay];
}

@end
