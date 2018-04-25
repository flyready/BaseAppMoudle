//
//  FDAlertView.m
//  FDAlertViewDemo
//
//  Created by fergusding on 15/5/26.
//  Copyright (c) 2015年 fergusding. All rights reserved.
//

#import "HYAlertView.h"
#define TITLE_FONT_SIZE 16
#define MESSAGE_FONT_SIZE 14
#define BUTTON_FONT_SIZE 17
#define MARGIN_TOP 20
#define MARGIN_LEFT_LARGE 30
#define MARGIN_LEFT_SMALL 15
#define MARGIN_RIGHT_LARGE 30
#define MARGIN_RIGHT_SMALL 15
#define SPACE_LARGE 20
#define SPACE_SMALL 5
#define MESSAGE_LINE_SPACE 5

@interface HYAlertView ()

@property (strong, nonatomic) UIView *backgroundView;
@property (strong, nonatomic) UIView *titleView;
@property (strong, nonatomic) UIImageView *iconImageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *messageLabel;

@property (strong, nonatomic) NSMutableArray *buttonArray;
@property (strong, nonatomic) NSMutableArray *buttonTitleArray;
@property (strong, nonatomic) UIWindow *rootWindow;

@end

CGFloat contentViewWidth;
CGFloat contentViewHeight;

@implementation HYAlertView

- (instancetype)init {
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        self.backgroundColor = [UIColor clearColor];
        if (!_backgroundView) {
            _backgroundView = [[UIView alloc] initWithFrame:self.frame];
            _backgroundView.backgroundColor = [UIColor blackColor];
            [self addSubview:_backgroundView];
        }
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title icon:(UIImage *)icon message:(NSString *)message block:(ClickAlertActionBlock)block buttonTitles:(NSString *)buttonTitles, ... NS_REQUIRES_NIL_TERMINATION {
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        //    *******  防止循环引用  *******   //
        [self removeRecordHYAlertView];
        kHYAlert.recordView = self;   ///重新记录 view
        _icon = icon;
        _title = title;
        _message = message; 
        _fBlock = block;
        _buttonArray = [NSMutableArray array];
        _buttonTitleArray = [NSMutableArray array];
        
        va_list args;
        va_start(args, buttonTitles);
        if (buttonTitles)
        {
            [_buttonTitleArray addObject:buttonTitles];
            while (1)
            {
                NSString *  otherButtonTitle = va_arg(args, NSString *);
                if(otherButtonTitle == nil) {
                    break;
                } else {
                    [_buttonTitleArray addObject:otherButtonTitle];
                }
            }
        }
        va_end(args);
        
        self.backgroundColor = [UIColor clearColor];
        
        _backgroundView = [[UIView alloc] initWithFrame:self.frame];
        _backgroundView.backgroundColor = [UIColor blackColor];
        [self addSubview:_backgroundView];
        [self initContentView];
    }
    return self;
}

- (void)setContentView:(UIView *)contentView {
    _contentView = contentView;
    _contentView.center = self.center;
    [self addSubview:_contentView];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    [self initContentView];
}

- (void)setIcon:(UIImage *)icon {
    _icon = icon;
    [self initContentView];
}

- (void)setMessage:(NSString *)message {
    _message = message;
    [self initContentView];
}

// Init the content of content view
- (void)initContentView {
    contentViewWidth = ((self.width>/* DISABLES CODE */ (320.f))?((self.width/DEVEWidth)*305.f):280.f);
    contentViewHeight = MARGIN_TOP;
    
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = [UIColor whiteColor];
    _contentView.layer.cornerRadius = 4.0;
    _contentView.layer.masksToBounds = YES;
    
    [self initTitleAndIcon];
    [self initMessage];
    [self initAllButtons];
    
    _contentView.frame = CGRectMake(0, 0, contentViewWidth, contentViewHeight);
    _contentView.center = self.center;
    [self addSubview:_contentView];
}

// Init the title and icon
- (void)initTitleAndIcon {
    _titleView = [[UIView alloc] init];
    if (_icon != nil) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.image = _icon;
        _iconImageView.frame = CGRectMake(0, 0, _icon.size.width, _icon.size.height);
        [_titleView addSubview:_iconImageView];
    }
    
    CGSize titleSize = [self getTitleSize];
    CGFloat titleH = titleSize.height + _iconImageView.height +
                    ([self isExitMessage]?10.f:(IS_IPHONE_6P?40.f:30.f));
    if ([self isExitTitle]) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = _title;
        _titleLabel.textColor = RGBA(28, 28, 28, 1.0);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:TITLE_FONT_SIZE];
        _titleLabel.numberOfLines = 0;
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _titleLabel.frame = CGRectMake(SPACE_SMALL, _iconImageView.maxY + 18.f,
                                       titleSize.width, titleSize.height);
        [_titleView addSubview:_titleLabel];
    }else{
        titleH -= 25.f;
    }
    CGFloat titleViewY =  10.f;
    if (_iconImageView.height) {
        titleViewY = MARGIN_TOP;
    }else{
        _titleLabel.y = _iconImageView.maxY + 8.f;
        titleH -= 5.f;
    }
    _titleView.frame = CGRectMake(0, titleViewY, SPACE_SMALL + titleSize.width, MAX(_iconImageView.frame.size.height, titleH));
    _titleView.center = CGPointMake(contentViewWidth / 2, MARGIN_TOP + _titleView.frame.size.height / 2);
    _iconImageView.x = (_titleView.width - _iconImageView.width) / 2.f;
    [_contentView addSubview:_titleView];
    contentViewHeight += _titleView.frame.size.height;
}


// Init the message
- (void)initMessage {
    if ([self isExitMessage]) {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.text = _message;
        _messageLabel.textColor = RGBA(120, 120, 120, 1.0);
        _messageLabel.numberOfLines = 0;
        _messageLabel.font = [UIFont systemFontOfSize:MESSAGE_FONT_SIZE];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineSpacing = MESSAGE_LINE_SPACE;
        NSDictionary *attributes = @{NSParagraphStyleAttributeName:paragraphStyle};
        _messageLabel.attributedText = [[NSAttributedString alloc]initWithString:_message attributes:attributes];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        
        CGSize messageSize = [self getMessageSize];
        CGFloat messageY = _titleView.maxY;
        CGFloat kDivH = 25.f;
        _messageLabel.frame = CGRectMake(MARGIN_LEFT_LARGE, messageY + SPACE_LARGE, MAX(contentViewWidth - MARGIN_LEFT_LARGE - MARGIN_RIGHT_LARGE, messageSize.width), messageSize.height);
        [_contentView addSubview:_messageLabel];
        contentViewHeight += kDivH + _messageLabel.frame.size.height;
    }
    
}

- (BOOL)isExitTitle
{
    if ((_title != nil)&&(![_title isEqualToString:@""])) {
        return YES;
    }
    return NO;
}

- (BOOL)isExitMessage
{
    if ((_message != nil)&&(![_message isEqualToString:@""])) {
        return YES;
    }
    return NO;
}

// Init all the buttons according to button titles
- (void)initAllButtons {
    if (_buttonTitleArray.count > 0) {
        CGFloat horizonY = contentViewHeight + SPACE_LARGE;
        contentViewHeight = horizonY + 48;
       
        CGFloat lineWh = .6;
        UIView *horizonSperatorView = [[UIView alloc] initWithFrame:
                          CGRectMake(0, horizonY, contentViewWidth, lineWh)];
        horizonSperatorView.backgroundColor = RGBA(218, 218, 222, 1.0);
        [_contentView addSubview:horizonSperatorView];
        
        CGFloat buttonWidth = contentViewWidth / _buttonTitleArray.count;
        for (NSString *buttonTitle in _buttonTitleArray) {
            NSInteger index = [_buttonTitleArray indexOfObject:buttonTitle];
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(index * buttonWidth, horizonSperatorView.frame.origin.y + horizonSperatorView.frame.size.height, buttonWidth, 48)];
            button.titleLabel.font = [UIFont systemFontOfSize:BUTTON_FONT_SIZE];
            [button setTitle:buttonTitle forState:UIControlStateNormal];
            [button setTitleColor:RGBA(70, 130, 180, 1.0) forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonWithPressed:) forControlEvents:UIControlEventTouchUpInside];
            [button setBackgroundImage:[UIImage imageWithColor:lGrayTintColor]
                                    forState:UIControlStateHighlighted];
            [_buttonArray addObject:button];
            [_contentView addSubview:button];
            
            if (index < _buttonTitleArray.count - 1) {
                UIView *verticalSeperatorView = [[UIView alloc] initWithFrame:CGRectMake(button.frame.origin.x + button.frame.size.width, button.frame.origin.y, lineWh, button.frame.size.height)];
                verticalSeperatorView.backgroundColor = RGBA(218, 218, 222, 1.0);
                [_contentView addSubview:verticalSeperatorView];
            }
        }
    }
}

// Get the size fo title
- (CGSize)getTitleSize {
    UIFont *font = [UIFont systemFontOfSize:TITLE_FONT_SIZE];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize size = [_title boundingRectWithSize:CGSizeMake(contentViewWidth - (MARGIN_LEFT_SMALL + MARGIN_RIGHT_SMALL + _iconImageView.frame.size.width + SPACE_SMALL), 2000)
                                       options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:attributes context:nil].size;
    
    size.width = ceil(size.width);
    size.height = ceil(size.height);
    
    return size;
}

// Get the size of message
- (CGSize)getMessageSize {
    UIFont *font = [UIFont systemFontOfSize:MESSAGE_FONT_SIZE];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = MESSAGE_LINE_SPACE;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize size = [_message boundingRectWithSize:CGSizeMake(contentViewWidth - (MARGIN_LEFT_LARGE + MARGIN_RIGHT_LARGE), 2000)
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:attributes context:nil].size;
    
    size.width = ceil(size.width);
    size.height = ceil(size.height);
    
    return size;
}

- (void)buttonWithPressed:(UIButton *)button {
    if (_fBlock) {
        NSInteger index = [_buttonTitleArray indexOfObject:button.titleLabel.text];
        _fBlock(self, index);
    }
    [self hide];
}

- (void)show {
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    _rootWindow = [[UIWindow alloc] initWithFrame:window.bounds];
    _rootWindow.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _rootWindow.opaque = NO;
    _rootWindow.windowLevel = UIWindowLevelAlert;
    [_rootWindow makeKeyAndVisible];
    [_rootWindow addSubview:self];
    //   ********   移除 所有的动画    ********   //
    NSArray *windowViews = [window subviews];
    if(windowViews && [windowViews count] > 0){
        UIView *subView = [windowViews objectAtIndex:[windowViews count]-1];
        for(UIView *aSubView in subView.subviews){
            [aSubView.layer removeAllAnimations];
        }
    }
    [self showBackground];
    [self showAlertAnimation];
    if (kActionControl.keyboardIsVisible) {
        [window endEditing:YES];
    }
}

- (void)hide {
    [UIView animateWithDuration:0.3 animations:^{
        _backgroundView.alpha = 0.f;
        _contentView.alpha = 0.f;
        _contentView.transform = CGAffineTransformMakeScale(.9, .9);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self removeRecordHYAlertView];
    }];
}

- (void)removeRecordHYAlertView //  移除 记录的 背景view
{
    if(kHYAlert.recordView){
        [kHYAlert.recordView removeFromSuperview];
        kHYAlert.recordView = nil;
    }
    [_rootWindow removeFromSuperview];
    _rootWindow = nil;
}

- (void)setTitleColor:(UIColor *)color fontSize:(CGFloat)size {
    if (color != nil) {
        _titleLabel.textColor = color;
    }
    
    if (size > 0) {
        _titleLabel.font = [UIFont systemFontOfSize:size];
    }
}

- (void)setMessageColor:(UIColor *)color fontSize:(CGFloat)size {
    if (color != nil) {
        _messageLabel.textColor = color;
    }
    
    if (size > 0) {
        _messageLabel.font = [UIFont systemFontOfSize:size];
    }
}

- (void)setButtonTitleColor:(UIColor *)color fontSize:(CGFloat)size atIndex:(NSInteger)index {
    UIButton *button = _buttonArray[index];
    if (color != nil) {
        [button setTitleColor:color forState:UIControlStateNormal];
    }
    
    if (size > 0) {
        button.titleLabel.font = [UIFont systemFontOfSize:size];
    }
}

- (void)showBackground
{
    _backgroundView.alpha = 0;
    [UIView beginAnimations:@"fadeIn" context:nil];
    [UIView setAnimationDuration:0.35];
    _backgroundView.alpha = 0.5;
    [UIView commitAnimations];
}

-(void)showAlertAnimation
{
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.30;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [_contentView.layer addAnimation:animation forKey:nil];
}

@end

@implementation RecordHYAlertView

+ (instancetype)shareHYAlertSingleton
{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[RecordHYAlertView alloc] init];
    });
    return instance;
    
}

@end

