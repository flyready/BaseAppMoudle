//
//  HYPayAlertView.h
//  Created by YunShangCompany on 17/5/30.
//  Copyright © 2016年 YunShangCompany. All rights reserved.

#import "HYPayAlertView.h"

#define kSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define kSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
//#define kPAYMENT_WIDTH kSCREEN_WIDTH-80

static NSInteger const kPasswordCount = 6;

static CGFloat const kTitleHeight     = 50.f;
static CGFloat const kDotWidth        = 15;
static CGFloat const kKeyboardHeight  = 216;
static CGFloat const kAlertHeight     = 215;
static CGFloat const kCommonMargin    = 100;

@interface HYPayAlertView () <UITextFieldDelegate>

@property (nonatomic, strong) UIView *paymentAlert;
@property (nonatomic, strong) UIView *inputView;
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *line;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UILabel *amountLabel;
@property (nonatomic, strong) UITextField *pwdTextField;

@property (nonatomic, strong) UIWindow *showWindow;

@end

@interface HYPayAlertView ()

@property (nonatomic, strong) NSMutableArray <UILabel *> *pwdIndicators;

@end

@implementation HYPayAlertView

- (instancetype)init {
    self = [super init];
    if (self) {
        [IQKeyboardManager sharedManager].enable = NO;
        [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
        self.view.frame = [UIScreen mainScreen].bounds;
        self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4f];
        
        [self viewAddSubviews];
    }
    return self;
}

- (void)viewAddSubviews {
    [self.view addSubview:self.paymentAlert];
    [self.paymentAlert addSubview:self.titleLabel];
    [self.paymentAlert addSubview:self.closeBtn];
    [self.paymentAlert addSubview:self.line];
    [self.paymentAlert addSubview:self.detailLabel];
    [self.paymentAlert addSubview:self.amountLabel];
    [self.paymentAlert addSubview:self.inputView];
    [self.inputView addSubview:self.pwdTextField];
    
    CGFloat width = self.inputView.bounds.size.width/kPasswordCount;
    for (int i = 0; i < kPasswordCount; i ++) {
        UILabel *dot = [[UILabel alloc]initWithFrame:CGRectMake((width-kDotWidth)/2.f + i*width, (self.inputView.bounds.size.height-kDotWidth)/2.f, kDotWidth, kDotWidth)];
        dot.backgroundColor = [UIColor blackColor];
        dot.layer.cornerRadius = kDotWidth/2.;
        dot.clipsToBounds = YES;
        dot.hidden = YES;
        [self.inputView addSubview:dot];
        [self.pwdIndicators addObject:dot];
        if (i == kPasswordCount-1) {
            continue;
        }
        UILabel *line = [[UILabel alloc]initWithFrame:
                 CGRectMake((i+1)*width, 0, .8f, self.inputView.bounds.size.height)];
        line.backgroundColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:.8];
        [self.inputView addSubview:line];
    }
}


- (void)show {
    UIWindow *newWindow = [[UIWindow alloc]initWithFrame:self.view.bounds];
    newWindow.rootViewController = self;
    [newWindow makeKeyAndVisible];
    self.showWindow = newWindow;
    
    self.paymentAlert.transform = CGAffineTransformMakeScale(.9f, .9f);
    self.paymentAlert.alpha = 0;

    [UIView animateWithDuration:.3f delay:0.f usingSpringWithDamping:.7f initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [_pwdTextField becomeFirstResponder];
        _paymentAlert.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        _paymentAlert.alpha = 1.0;
    } completion:nil];
}
/*
- (void)dismissView  //  加一层  兼容以前的代码
{
    [self dismiss];
    if (self.cancelHandle) {
        self.cancelHandle();
    }
} */

- (void)dismiss {
    [self.pwdTextField resignFirstResponder];
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    [UIView animateWithDuration:.3f animations:^{
        self.paymentAlert.transform = CGAffineTransformMakeScale(0.9f, 0.9f);
        self.paymentAlert.alpha = 0;
        self.showWindow.alpha = 0;
    } completion:^(BOOL finished) {
        [self.showWindow removeFromSuperview];
        [self.showWindow resignKeyWindow];
        self.showWindow = nil;
    }];
    
}

#pragma mark - delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.text.length >= kPasswordCount && string.length) {
        return NO;
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^[0-9]*$"];
    if (![predicate evaluateWithObject:string]) {
        return NO;
    }

    return YES;
}

#pragma mark - action

- (void)textDidChange:(UITextField *)textField {
    [self setDotWithCount:textField.text.length];
    if (textField.text.length == 6) {
        if (self.completeHandle) {
            self.completeHandle(textField.text);
        }
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:.1f];
    }
}

- (void)setDotWithCount:(NSInteger)count {
    for (UILabel *dot in self.pwdIndicators) {
        dot.hidden = YES;
    }
    
    for (NSInteger i = 0; i< count; i++) {
        ((UILabel*)[self.pwdIndicators objectAtIndex:i]).hidden = NO;
    }
}


#pragma mark - setter
/*
- (void)setTitleStr:(NSString *)titleStr {
    _titleStr = titleStr;
    self.titleLabel.text = _titleStr;
} */

- (void)setDetail:(NSString *)detail {
    _detail = detail;
    self.detailLabel.text = _detail;
    if ([CustomUtils ISNULL:_detail]) {
        self.detailLabel.height = 0.f;
        self.amountLabel.y = self.detailLabel.maxY+10.f;
        self.paymentAlert.height = self.paymentAlert.height - 10.f;
        self.inputView.maxY = self.paymentAlert.height - 15.f;
        self.paymentAlert.centerY = self.paymentAlert.centerY+10.f;
    }
}

- (void)setAMount:(CGFloat)aMount {
    _aMount = aMount;
    if (_aMount > 0.f) {
        self.amountLabel.text = [NSString stringWithFormat:@"￥%.2f",aMount];
    }else{
        self.amountLabel.height = 0.f;
        self.paymentAlert.height = self.paymentAlert.height - 40.f;
        self.inputView.maxY = self.paymentAlert.height - 15.f;
        self.paymentAlert.centerY = self.paymentAlert.centerY+10.f;
    }
}

#pragma mark - getter

- (UIView *)paymentAlert {
    if (_paymentAlert == nil) {
        _paymentAlert = [[UIView alloc]initWithFrame:CGRectMake(30, kSCREEN_HEIGHT-kKeyboardHeight-kCommonMargin-kAlertHeight+15.f, kSCREEN_WIDTH-60, kAlertHeight)];
        _paymentAlert.layer.cornerRadius = 3.f;
        _paymentAlert.layer.masksToBounds = YES;
        _paymentAlert.backgroundColor = [UIColor colorWithWhite:1.f alpha:.95];
    }
    return _paymentAlert;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]initWithFrame:
                       CGRectMake(0, 0, _paymentAlert.width, kTitleHeight)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        [_titleLabel setText:@"请输入支付密码"];
    }
    return _titleLabel;
}

- (UIButton *)closeBtn {
    if (_closeBtn == nil) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setFrame:CGRectMake(0, 0, kTitleHeight, kTitleHeight)];
        [_closeBtn setTitle:@"╳" forState:UIControlStateNormal];
        [_closeBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        _closeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _closeBtn;
}

- (UILabel *)line {
    if (_line == nil) {
        _line = [[UILabel alloc]initWithFrame:
                 CGRectMake(0, kTitleHeight, _paymentAlert.width, .5f)];
        _line.backgroundColor = UIColorFromRGBA(0xe8e8e8, .9);
    }
    return _line;
}

- (UILabel *)detailLabel {
    if (_detailLabel == nil) {
        _detailLabel = [[UILabel alloc]initWithFrame:
                        CGRectMake(15, _line.maxY+15, _paymentAlert.width-30, 20)];
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        _detailLabel.textColor = [UIColor darkGrayColor];
        _detailLabel.font = [UIFont systemFontOfSize:16];
    }
    return _detailLabel;
}

- (UILabel *)amountLabel {
    if (_amountLabel == nil) {
        _amountLabel = [[UILabel alloc]initWithFrame:
                 CGRectMake(15, kTitleHeight*2, _paymentAlert.width-30, 25)];
        _amountLabel.textAlignment = NSTextAlignmentCenter;
        _amountLabel.textColor = [UIColor darkGrayColor];
        _amountLabel.font = [UIFont systemFontOfSize:33];
    }
    return _amountLabel;
}

- (UIView *)inputView {
    if (_inputView == nil) {
        _inputView = [[UIView alloc]initWithFrame:CGRectMake(20, _paymentAlert.frame.size.height-(_paymentAlert.width-30)/6-20.f, _paymentAlert.width-40, (_paymentAlert.width-30)/6)];
        _inputView.backgroundColor = [UIColor whiteColor];
        _inputView.layer.borderWidth = 1.f;
        _inputView.layer.borderColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1.].CGColor;
    }
    return _inputView;
}

- (UITextField *)pwdTextField {
    if (_pwdTextField == nil) {
        _pwdTextField = [[UITextField alloc]initWithFrame:
                         CGRectMake(0, 0, self.view.width, self.view.height)];
        _pwdTextField.hidden = YES;
        _pwdTextField.delegate = self;
        _pwdTextField.keyboardType = UIKeyboardTypeNumberPad;
        [_pwdTextField addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _pwdTextField;
}

- (NSMutableArray *)pwdIndicators {
    if (_pwdIndicators == nil) {
        _pwdIndicators = [[NSMutableArray alloc]init];
    }
    return _pwdIndicators;
}

@end
