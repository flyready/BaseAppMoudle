//
//  DKProgressHUD.h
//  portfolio
//
//  Created by 张奥 on 14-9-15.
//  Copyright (c) 2014年 DKHS. All rights reserved.
//

#import "MBProgressHUD.h"

#define LENGTH_SHORT (2)
#define LENGTH_LONG  (3.5)

@interface DKProgressHUD : MBProgressHUD

@end

CG_EXTERN  MBProgressHUD* _showTipsView(NSString* text, float duration_time, UIView* view);
CG_EXTERN  MBProgressHUD* _showSuccessView(NSString * text, float duration_time, UIView *view);
CG_EXTERN  MBProgressHUD* _showErrorView(NSString * text, float duration_time, UIView *view);
CG_EXTERN  MBProgressHUD* _showTinyClearIndicator(UIView *view);

#define ShowTipsView(text, duration_time, view) _showTipsView(text, duration_time, view)

#define ShowTips(text)                          ShowTipsView(text, LENGTH_SHORT, self.view)
#define ShowTipsWithDuration(text, duration)    ShowTipsView(text, duration, self.view)
#define ShowTipsOnView(text,view)               ShowTipsView(text, LENGTH_SHORT, view)

#define HideTips()                      [MBProgressHUD hideHUDForView:self.view animated:YES];
#define HideTipsOnView(view)            [MBProgressHUD hideHUDForView:view animated:YES];

#define HideIndicatorInView(view)      [MBProgressHUD hideHUDForView:view animated:YES];
#define ShowIndicatorInView(view)      do{ HideIndicatorInView(view);\
                                            /*MBProgressHUD *hud = */[DKProgressHUD showHUDAddedTo:view animated:YES]; /*hud.labelText = @"正在加载";*/}while(0)

#define ShowIndicatorTextInView(view,text) do{ HideIndicatorInView(view);\
                                                 MBProgressHUD *hud = [DKProgressHUD showHUDAddedTo:view animated:YES]; hud.labelText = text;}while(0)

//#define ShowIndicatorText(text)         ShowIndicatorTextInView(self.view,text)
//#define ShowIndicatorText(text)         ShowIndicatorTextInView(self.view,@"")

#define ShowIndicator()                 ShowIndicatorInView(self.view);

#define ShowTinyClearIndicatorInView(view)      _showTinyClearIndicator(view)
#define ShowTinyClearIndicator()                ShowTinyClearIndicatorInView(self.view);

#define ShowSuccessView(text, duration_time, view)  _showSuccessView(text, duration_time, view)

#define ShowSuccess(text)                           ShowSuccessView(text, LENGTH_SHORT, self.view)
#define ShowSuccessWithDuration(text, duration)     ShowSuccessView(text, duration, self.view)
#define ShowSuccessOnView(text, view)               ShowSuccessView(text, LENGTH_SHORT, view)

#define ShowErrorView(text, duration_time, view)  _showErrorView(text, duration_time, view)

#define ShowError(text)                           ShowErrorView(text, LENGTH_SHORT, self.view)
#define ShowErrorWithDuration(text, duration)     ShowErrorView(text, duration, self.view)
#define ShowErrorOnView(text, view)               ShowErrorView(text, LENGTH_SHORT, view)

//#define ShowError(text)                 do{ HideIndicator_InView(self.view); \
//                                            [MBProgressHUD showError:text toView:self.view];}while(0)
#define HideIndicator()                 HideIndicatorInView(self.view)

#define ShowSuccessOnWindow(text)  _showSuccessView(text, 2.f, [[UIApplication sharedApplication] keyWindow])
#define ShowErrorOnWindow(text)  _showErrorView(text, 2.f, [[UIApplication sharedApplication] keyWindow])

