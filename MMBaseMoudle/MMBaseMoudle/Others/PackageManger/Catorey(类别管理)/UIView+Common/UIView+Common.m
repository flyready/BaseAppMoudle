//
//  UIView+Common.m
#import "UIView+Common.h"
#import <objc/runtime.h>

#define kTagLineViewW 1006
#define kTagLineView 1007
#define kTagYLineView 1008
#define kTagShowLabel 1866

@implementation UIView (Common)
static char LoadingViewKey, BlankPageViewKey, LoadingActViewKey;
#define kAllColor (UIColorFromRGB(0x999999))

- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size.width = size.width;
    frame.size.height = size.height;
    self.frame = frame;
}
- (void)setCenterY:(CGFloat)y{
    CGPoint center = self.center;
    center.y = y;
    self.center = center;
}
- (void)setCenterX:(CGFloat)x{
    CGPoint center = self.center;
    center.x = x;
    self.center = center;
}
/// 画虚线 框
- (void)drawDashedLineFrame:(UIColor *)strokeColor
{
    CAShapeLayer *border = [CAShapeLayer layer];
    border.strokeColor = strokeColor.CGColor;
    border.fillColor = nil;
    border.path = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    border.frame = self.bounds;
    border.lineWidth = 1.f;
    border.lineCap = @"square";
    border.lineDashPattern = @[@4, @2];
    [self.layer addSublayer:border];
}

- (UIView *)addBackViewToSupview:(CGRect)rect
{
    UIView *bg_BackView = [[UIView alloc] initWithFrame:rect];
    bg_BackView.backgroundColor = [UIColor clearColor];
    [self addSubview:bg_BackView];
    [bg_BackView addLineUp:NO andDown:YES];
    return bg_BackView;
}

+ (UIView *)headerView:(CGFloat)y
{
    UIView *header = [[UIView alloc] initWithFrame:
                      CGRectMake(0, 0, App_Frame_Width, y)];
    return header;
}

+ (UIView *)getBgView:(CGRect)rect
{
    return [UIView getBgView:rect color:[UIColor whiteColor]];
}

+ (UIView *)getBgView:(CGRect)rect color:(UIColor *)color
{
    UIView *view = [[UIView alloc] initWithFrame:rect];
    [view setBackgroundColor:color];
    return view;
}
#pragma cell 的颜色
- (void)setCellBackView
{
    UIView *backView = [[UIView alloc] initWithFrame:self.bounds];
    backView.backgroundColor = GlobalPlainColor;
    [self addSubview:backView];
    [self sendSubviewToBack:backView];
}

+ (UIImageView *)customBackgroundView
{
    return [[UIImageView alloc] initWithImage:
            [UIImage imageWithColor:[UIColor colorWithWhite:.1 alpha:.1]]];
}

- (UIView *)lineViewWithPointYY:(CGFloat)pointY andY:(CGFloat)x{
    return [self lineViewWithPointYY:pointY andColor:UIColorFromRGB(0xc8c7cc) andY:x];
}

- (UIView *)lineViewWithPointYY:(CGFloat)pointY andColor:(UIColor *)color andY:(CGFloat)x{
    UIView *lineView = [[UIView alloc] initWithFrame:
                        CGRectMake(x, pointY, WIDTH(self)-2*x, 0.5)];
    lineView.backgroundColor = color;
    return lineView;
}

- (void)addYLineLeft:(BOOL)hasLeft andMidden:(BOOL)hasMidden andRight:(BOOL)hasRight
{
    [self addYLineLeft:hasLeft andRigh:hasRight
        andMidden:hasMidden andColor:UIColorFromRGBA(0xe8e8e8, .9) andY:0.f];
}

- (void)addYdLineLeft:(BOOL)hasLeft andRight:(BOOL)hasRight andY:(CGFloat)y
{
    [self addYLineLeft:hasLeft andRigh:hasRight
                andMidden:NO andColor:UIColorFromRGBA(0xe8e8e8, .9) andY:y];
}

- (void)addYLineLeft:(BOOL)hasLeft andRigh:(BOOL)hasRight andMidden:(BOOL)hasMidden andColor:(UIColor *)color andY:(CGFloat)y
{
    [self removeViewWithTag:kTagYLineView];
    CGRect rect = CGRectMake(0.f, y, 0.5, HEIGHT(self)-2*y);
    if (hasLeft) {
        UIView *leftView = [[UIView alloc] initWithFrame:rect];
        [leftView setX:0.f];
        [leftView setWidth:.5];
        leftView.backgroundColor = color;
        leftView.tag = kTagYLineView;
        [self addSubview:leftView];
    }
    if (hasRight) {
        UIView *rightView = [[UIView alloc] initWithFrame:rect];
        [rightView setX:WIDTH(self)-0.5];
        rightView.tag = kTagYLineView;
        rightView.backgroundColor = color;
        [self addSubview:rightView];
    }
    if (hasMidden) {
        UIView *middenView = [[UIView alloc] initWithFrame:rect];
        [middenView setX:WIDTH(self)/2-0.25];
        middenView.tag = kTagYLineView;
        middenView.backgroundColor = color;
        [self addSubview:middenView];
    }      // 招聘的地方
}
//[UIColor colorWithWhite:1.f alpha:.1]
- (void)addWhiteLineUp:(BOOL)hasUp andDown:(BOOL)hasDown
{
    [self addWhiteLineUp:hasUp andDown:hasDown andX:0.f];
}

- (void)addWhiteLineUp:(BOOL)hasUp andDown:(BOOL)hasDown andX:(CGFloat)x{
    [self addLineUp:hasUp andDown:hasDown andColor:
                    [UIColor colorWithWhite:1.f alpha:.1] andX:x];
}

- (void)addLineUp:(BOOL)hasUp andDown:(BOOL)hasDown{
    [self addLineUp:hasUp andDown:hasDown andColor:UIColorFromRGBA(0xe8e8e8, .9) andX:0.f];
}

- (void)addLineUp:(BOOL)hasUp andDown:(BOOL)hasDown andX:(CGFloat)x
{
    [self addLineUp:hasUp andDown:hasDown andColor:UIColorFromRGBA(0xe8e8e8, .9) andX:x];
}

- (void)addLineUp:(BOOL)hasUp andDown:(BOOL)hasDown andColor:(UIColor *)color andX:(CGFloat)x{
    [self removeViewWithTag:kTagLineView];
    if (hasUp) {
        UIView *upView = [self lineViewWithPointYY:0 andColor:color andY:x];
        upView.tag = kTagLineView;
        [self addSubview:upView];
    }
    if (hasDown) {
        UIView *downView = [self lineViewWithPointYY:CGRectGetMaxY(self.bounds)-0.5 andColor:color andY:x];
        downView.tag = kTagLineView;
        [self addSubview:downView];
    }
}
- (void)removeViewWithTag:(NSInteger)tag{
    for (UIView *aView in [self subviews]) {
        if (aView.tag == tag) {
            [aView removeFromSuperview];
        }
    }
}
- (void)addGradientLayerWithColors:(NSArray *)cgColorArray{
    [self addGradientLayerWithColors:cgColorArray locations:nil startPoint:CGPointMake(0.0, 0.5) endPoint:CGPointMake(1.0, 0.5)];
}

- (void)addGradientLayerWithColors:(NSArray *)cgColorArray locations:(NSArray *)floatNumArray startPoint:(CGPoint )startPoint endPoint:(CGPoint)endPoint{
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = self.bounds;
    if (cgColorArray && [cgColorArray count] > 0) {
        layer.colors = cgColorArray;
    }else{
        return;
    }
    if (floatNumArray && [floatNumArray count] == [cgColorArray count]) {
        layer.locations = floatNumArray;
    }
    layer.startPoint = startPoint;
    layer.endPoint = endPoint;
    [self.layer addSublayer:layer];
}

- (void)startRotationView:(NSString *)rotationName duration:(CGFloat)duration
{
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI * 2.0];
    rotationAnimation.duration = 1.f;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = INFINITY;
    rotationAnimation.removedOnCompletion = NO;
    [self.layer addAnimation:rotationAnimation forKey:rotationName];
}

- (void)removeRotationAnimation:(NSString *)rotationName
{
    [self.layer removeAnimationForKey:rotationName];
}

- (void)setViewGradientLayer
{
    UIView *jianBian = [[UIView alloc] initWithFrame:self.bounds];
    [jianBian setHeight:64.f];
    [self addSubview:jianBian];
    
    //  *****  图层渐变 处理  *********    ///
    CAGradientLayer* mylayer = [CAGradientLayer layer];
    mylayer.frame = jianBian.bounds;
    [jianBian.layer addSublayer:mylayer];
    mylayer.startPoint = CGPointMake(0, 1);
    mylayer.endPoint = CGPointMake(0, 0);
    mylayer.colors = @[(__bridge id)[UIColor clearColor].CGColor,
                   (__bridge id)[UIColor colorWithWhite:.0 alpha:.2].CGColor];
    mylayer.locations = @[@(0.0f) ,@(1.0f)];
}

#pragma mark BlankPageView
- (void)setBlankPageView:(EaseBlankPageView *)blankPageView{
    [self willChangeValueForKey:@"BlankPageViewKey"];
    objc_setAssociatedObject(self, &BlankPageViewKey,
                             blankPageView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"BlankPageViewKey"];
}
- (EaseBlankPageView *)blankPageView{
    return objc_getAssociatedObject(self, &BlankPageViewKey);
}

//  有错误哦
- (void)reloadButtonBlock:(void(^)(id sender))block hasData:(BOOL)hasData
{
    if (hasData) return;
    /*
    if (!self.blankPageView) {
        EaseBlankPageView *view = [[EaseBlankPageView alloc] initWithFrame:self.bounds];
        self.blankPageView = view;
    }
    self.blankPageView.hidden = NO;
    [self.blankPageContainer insertSubview:self.blankPageView atIndex:0];
    [self.blankPageView reloadButtonBlock:block];
     */
}

- (void)configBlankPage:(EaseBlankPageType)blankPageType hasData:(BOOL)hasData{
    if (hasData) {
        if (self.blankPageView) {
            self.blankPageView.hidden = YES;
            [self.blankPageView removeFromSuperview];
            self.blankPageView = nil;
        }
    }else{
        if (!self.blankPageView) {
            EaseBlankPageView *view = [[EaseBlankPageView alloc] initWithFrame:self.bounds];
            self.blankPageView = view;
        }
        self.blankPageView.hidden = NO;
        [self.blankPageContainer insertSubview:self.blankPageView atIndex:0];
        [self.blankPageView configWithType:blankPageType hasData:hasData];
    }
}

- (UIView *)blankPageContainer{
    UIView *blankPageContainer = self;
    for (UIView *aView in [self subviews]) {
        if ([aView isKindOfClass:[UITableView class]]) {
            blankPageContainer = aView;
            [aView addSubview:self.blankPageView];
            [aView sendSubviewToBack:self.blankPageView];
        }
    }
    return blankPageContainer;
}
#pragma mark LoadingView
- (void)setLoadingView:(EaseLoadingView *)loadingView{
    [self willChangeValueForKey:@"LoadingViewKey"];
    objc_setAssociatedObject(self, &LoadingViewKey,
                             loadingView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"LoadingViewKey"];
}
- (EaseLoadingView *)loadingView{
    return objc_getAssociatedObject(self, &LoadingViewKey);
}
- (void)startRoLoading{
    for (UIView *aView in [self.blankPageContainer subviews]) {
        if ([aView isKindOfClass:[EaseBlankPageView class]] && !aView.hidden) {
        }
    }
    if (!self.loadingView) {
        //  初始化LoadingView
        EaseLoadingView *view = [[EaseLoadingView alloc] initWithFrame:self.bounds];
        self.loadingView = view;
    }
    [self addSubview:self.loadingView];
    [self.loadingView startAnimating];
}
- (void)stopRoLoading{
    if (self.loadingView) {
        [self.loadingView stopAnimating];
        [self.loadingView removeFromSuperview];
        MCRelease(self.loadingView);
    }
}
#pragma mark LoadingActView
- (void)setLoadingActView:(EaseActLoadingView *)loadingActView{
    [self willChangeValueForKey:@"LoadingActViewKey"];
    objc_setAssociatedObject(self, &LoadingActViewKey,
                             loadingActView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"LoadingActViewKey"];
}
- (EaseActLoadingView *)loadingActView{
    return objc_getAssociatedObject(self, &LoadingActViewKey);
}

- (void)startHLoading
{
    [self startHudLoading:nil];
}

- (void)startHudLoading:(NSString *)text{
    for (UIView *aView in [self.blankPageContainer subviews]) {
        if ([aView isKindOfClass:[EaseBlankPageView class]] && !aView.hidden) {
            return;
        }
    }
    if (!self.loadingActView) {
        //  初始化LoadActingView
        EaseActLoadingView *view = [[EaseActLoadingView alloc]
                                    initWithFrame:self.bounds withStr:text];
        self.loadingActView = view;
    }
    [self addSubview:self.loadingActView];
    [self.loadingActView startHudLoadingAnimation];
}

- (void)stopHudLoading{
    if (self.loadingActView) {
        [self.loadingActView stopHudLoadingAnimation];
        [self.loadingActView removeFromSuperview];
        MCRelease(self.loadingActView);
    }
}

@end

@implementation EaseLoadingView
//- (MDRadialProgressView *)progressViewWithFrame:(CGRect)frame
//{
//    MDRadialProgressView *view = [[MDRadialProgressView alloc] initWithFrame:frame];
//    // Only required in this demo to align vertically the progress views.
//    view.center = CGPointMake(self.center.x + 80, view.center.y);
//    return view;
//}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        if (!_loopView) {
            BOOL judst = HEIGHT(self)<100.f;
            CGFloat loopW = judst?25.f:36.f;//icon_loadingmore
            CGFloat offsetY = judst?0.f:40.f;
            _loopView = [[UIImageView alloc] initWithFrame:
                         CGRectMake(0.f, 0.f, loopW, loopW)];
            [_loopView setCenter:CGPointMake(self.center.x, self.center.y-offsetY)];
            [_loopView setImage:[UIImage imageNamed:@"icon_loading"]];
            _loopView.contentMode = UIViewContentModeScaleAspectFill;
            [self addSubview:_loopView];
        }
    }
    return self;
}
- (void)startAnimating{
    
    self.hidden = NO;
    if (_isLoading) return;
    _isLoading = YES;
    //[self.loopView startAnimation];
    [self.loopView startRotationView:@"loadingRAnimation" duration:1.f];
}

- (void)stopAnimating{
    [UIView animateWithDuration:.1 animations:^{
        self.alpha = .0f;
    } completion:^(BOOL finished){
        self.hidden = YES;
        [self.loopView removeRotationAnimation:@"loadingRAnimation"];
        _isLoading = NO;
    }];
}

@end

@implementation EaseActLoadingView

- (instancetype)initWithFrame:(CGRect)frame withStr:(NSString *)loadingStr{
    self = [super initWithFrame:frame];
    if (self) {
        if (!_loopView) {
            UIFont *lFont = [UIFont systemFontOfSize:16.f];
            CGFloat lw = [loadingStr getWidthWithFont:lFont constrainedToH:MAXFLOAT];
            CGFloat maxFloat = App_Frame_Width-80.f;
            if (lw > maxFloat) {
                lw = maxFloat;
            }else{
                lw += 50.f;
            }
            CGFloat vH = 120.f;
            CGFloat loopY = 25.f;
            UIImage *loopImg = [UIImage imageNamed:@"icon_loading"];
            CGFloat loopWH = IMAGEWIDTH(loopImg)*9/10;//icon_loadingmore
            if (!loadingStr) {
                lw = 90.f; vH = lw;
                loopY = (vH-loopWH)/2.f;
            }
            CGRect lRect = CGRectMake((self.width-lw)/2.f, 0.f, lw, vH);
            UIView *loadBgView = [[UIView alloc] initWithFrame:lRect];
            [loadBgView setCenterY:(self.center.y-30.f)];
            loadBgView.backgroundColor = RGBA(46, 47, 61, .95);//RGBA(108, 108, 108, .95);
            [self addSubview:loadBgView];
            ViewRadius(loadBgView, 4.f);
            
            UIImageView *loopView = [[UIImageView alloc] initWithFrame:
                    CGRectMake((loadBgView.width-loopWH)/2, loopY, loopWH, loopWH)];
            [loopView setImage:loopImg];
            [loadBgView addSubview:loopView];
            self.loopView = loopView;
            
            UILabel *actIndiorLab = [[UILabel alloc] initWithFrame:loadBgView.bounds];
            [actIndiorLab setY:(MaxY(loopView)+8.f)];
            [actIndiorLab setHeight:45.f];
            actIndiorLab.text = loadingStr;
            actIndiorLab.font = lFont;
            actIndiorLab.numberOfLines = 2;
            actIndiorLab.textAlignment = 1;
            actIndiorLab.textColor = [UIColor whiteColor];
            [loadBgView addSubview:actIndiorLab];
            
        }
    }
    return self;
}

- (void)startHudLoadingAnimation{
    
    self.hidden = NO;
    if (_isLoading) return;
    _isLoading = YES;
    //[self.loopView startAnimation];
    [self.loopView startRotationView:@"WRAnimation" duration:1.f];
}

- (void)stopHudLoadingAnimation{
    [UIView animateWithDuration:.2 animations:^{
        self.alpha = .0f;
    } completion:^(BOOL finished){
        self.hidden = YES;
        [self.loopView removeRotationAnimation:@"WRAnimation"];
        _isLoading = NO;
    }];
}

@end

#pragma mark EaseBlankPageView
@implementation EaseBlankPageView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

//  有错误哦
- (void)reloadButtonBlock:(void(^)(id sender))block
{
    self.alpha = 1.0;
    static CGFloat contentWidth = 250.0;
    CGFloat maxWidth = CGRectGetWidth(self.bounds);
    _reloadButtonBlock = nil;
    
    if (!_fillButton) {
        _fillButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fillButton addTarget:self action:@selector(reloadButtonClicked:)
                forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_fillButton];
    }
    //    文字
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _tipLabel.numberOfLines = 0;
        _tipLabel.font = SYSTEMFONT(15);
        _tipLabel.textColor = kAllColor;
        _tipLabel.textAlignment = 1;
        [self addSubview:_tipLabel];
    }
    //    图片
    UIImage *menkeyImage = [UIImage imageNamed:@"empty_failed"];
    _fillButton.frame = CGRectMake(0.f, 0.f, IMAGEWIDTH(menkeyImage), IMAGEHEIGHT(menkeyImage));
    CGPoint center = self.center;
    if (self.superview.y <= 64.f) {
        center.y = center.y - 40.f;
    }
    [_fillButton setCenter:center];
    [_fillButton setImage:menkeyImage forState:0];
    // frame
    self.tipLabel.frame = CGRectMake((maxWidth-contentWidth)/2,MaxY(_fillButton)+10.f, contentWidth, 50.f);
    self.tipLabel.text = [NSString stringWithFormat:@"网络不给力，点击屏幕重试"];
    _fillButton.hidden = NO;
    _reloadButtonBlock = block;
    
}

- (void)configWithType:(EaseBlankPageType)blankPageType hasData:(BOOL)hasData{
    
    if (hasData) {
        [self removeFromSuperview];
        return;
    }
    self.alpha = 1.0;
    static CGFloat contentWidth = 250.0;
    CGFloat maxWidth = CGRectGetWidth(self.bounds);
    _reloadButtonBlock = nil;  //  刷新block
    if (!_fillView) {
        _fillView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _fillView.contentMode = UIViewContentModeCenter;
        _fillView.layer.masksToBounds = YES;
        [self addSubview:_fillView];
    }
    //  *************   文字   **************   //
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _tipLabel.font = SYSTEMFONT(16);
        //_tipLabel.backgroundColor = [UIColor redColor];//行间距
        _tipLabel.numberOfLines = 0;
        _tipLabel.textColor = kAllColor;
        _tipLabel.textAlignment = 1;
        [self addSubview:_tipLabel];
    }
    UIColor *otherColor = LightWhiteColor;
    //  *************   空白数据   **************  //
    NSString *imageName, *tipStr;
    switch (blankPageType) {
        case NoHasRouteFillView:{
            imageName = @"STStaticPlaceholder";
        }
            break;
        case NoHasRouteTypeView:{
            imageName = @"img_merchant_noroutes";
            tipStr = @"距离很近,或者没有查找到路径";
        }
            break;
        case NoHasDataFriendCircle:{
            tipStr = @"您还没有好友动态哦，赶紧去加好友开始旅行吧--";
            _tipLabel.textColor = otherColor;
        }
            break;
        case NoRequestWebFailor:{
            imageName = @"empty_failed";
            tipStr = @"网页加载失败，请检查链接或者网络是否错误";
            _tipLabel.textColor = otherColor;
        }
            break;
        default:{
            
        }
            break;
    }
    CGPoint center = self.center;
    UIImage *fImage = [UIImage imageNamed:imageName];
    self.fillView.frame = CGRectMake(0, 0, IMAGEWIDTH(fImage), IMAGEHEIGHT(fImage));
    [self.fillView setCenter:CGPointMake(center.x, center.y-40.f)];
    [self.fillView setImage:fImage];
    // **************   frame    **************   //
    self.tipLabel.frame = CGRectMake(0 , 0, contentWidth, 40.f);
    if ([CustomUtils ISNULL:imageName]) {
        self.tipLabel.font = SYSTEMFONT(15);
        CGFloat offsetY = 20.f;
        if (blankPageType==NoHasDataFriendCircle) { offsetY = -60.f; }
        center.y -= offsetY;
        self.tipLabel.center = center;
    }else{
        if (self.superview.y <= 64.f) {
            if ([self.superview isKindOfClass:[UICollectionView class]]) {
                [self.fillView setCenterY:(center.y-40.f)];
            }
        }
        self.tipLabel.x = (maxWidth-contentWidth)/2.f;
        self.tipLabel.y = _fillView.maxY + 10.f;
    }
    self.tipLabel.text = tipStr;
    
}

- (void)reloadButtonClicked:(id)sender{
    self.hidden = YES;
    [self removeFromSuperview];
    //Dispatch_AfterCall(0.1,
    if (_reloadButtonBlock) {
        _reloadButtonBlock(sender);
    }
    //)
}

@end


