//
//  LocationCityView.m
//  eTailor_IOS_Client
//
//  Created by YunShangCompany on 16/6/6.
//  Copyright © 2016年 YUNSHANG ALERATION. All rights reserved.
//
/*
#import "LocationCityView.h"
@interface LocationCityView ()
@property (nonatomic, strong) UIImageView *arrowImgV;

@end
@implementation LocationCityView
#define lFont SYSTEMFONT(12)

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){//self.backgroundColor = [UIColor redColor];
        [self setFrame:CGRectMake(App_Frame_Width-85, 0, 70.f, kTCellHeight)];
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc]
                         initWithTarget:self action:@selector(tapLocationv)]];

        //  arrow 图片
        UIImage *aImg = [UIImage imageNamed:@"arrow_down_normal"];
        CGFloat aImgW = IMAGEWIDTH(aImg);
        CGFloat aImgH = IMAGEHEIGHT(aImg);
        UIImageView *arrowImgV = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH(self)-aImgW-5.f, (HEIGHT(self)-aImgH)/2.f, aImgW, aImgH)];
        [arrowImgV setImage:aImg];
        [self addSubview:arrowImgV];
        self.arrowImgV = arrowImgV;
       
        //  定位城市  label
        UILabel *locationLab = [[UILabel alloc] initWithFrame:self.bounds];
        [locationLab setWidth:WIDTH(self)];
        locationLab.textColor = LBlackTintColor;
        locationLab.font = lFont;
        [locationLab setText:@"选择区县"];
        [self addSubview:locationLab];
       
    }
    return self;
}

- (void)tapLocationv
{
    _selected = !_selected;
    if (_selectAreaBlock) {
        _selectAreaBlock(_selected);
    }
}

- (void)setSelected:(BOOL)selected
{
    if (_selected != selected) {
        _selected = selected;
    }
    self.arrowImgV.transform = CGAffineTransformMakeRotation(_selected?M_PI:0.f);
}

@end
*/

//
//  LocationCityView.m
//  eTailor_IOS_Client
//
//  Created by YunShangCompany on 17/3/6.
//  Copyright © 2016年 YUNSHANG ALERATION. All rights reserved.
//

#import "LocationCityView.h"
@interface LocationCityView ()
@property (nonatomic, strong) UILabel *locationLab;

@end
@implementation LocationCityView
#define lFont SYSTEMFONT_14

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        
        [self setFrame:CGRectMake(0, 0, 110.f, 35.f)];
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                    initWithTarget:self action:@selector(tapLocationv)]];
        //  定位城市  label
        UILabel *locationLab = [[UILabel alloc] initWithFrame:self.bounds];
       
        locationLab.textColor = RGBCOLOR(51, 51, 51);
        locationLab.font = lFont;
        locationLab.textAlignment = NSTextAlignmentCenter;
        locationLab.center = self.center;
        [self addSubview:locationLab];
        self.locationLab = locationLab;
        
        //  arrow 图片
        UIImage *aImg = [UIImage imageNamed:@"arrow_down_normal"];
        CGFloat aImgW = IMAGEWIDTH(aImg)*4/5;
        CGFloat aImgH = IMAGEHEIGHT(aImg)*4/5;
        UIImageView *arrowImgV = [[UIImageView alloc] initWithFrame:
                                  CGRectMake(0, (HEIGHT(locationLab)-aImgH)/2.f, aImgW, aImgH)];
        [arrowImgV setImage:aImg];
        [self addSubview:arrowImgV];
        self.arrowImgV = arrowImgV;
    }
    return self;
}

- (void)setLocationStr:(NSString *)locationStr
{
    if (_locationStr!=locationStr) {
        _locationStr = nil;
        _locationStr = locationStr;
    }
    NSString *location = [CustomUtils ISNULL:_locationStr]?@"请选择":_locationStr;
    CGFloat labW = [location getWidthWithFont:lFont constrainedToH:HEIGHT(self.locationLab)]+5.f;
//    [self.locationLab setWidth:(labW>90.f)?90.f:labW];
    [self.locationLab setText:location];
   // self.width = self.locationLab.width + 10.f;
   // [self.arrowImgV setX:MaxX(self.locationLab)];
    if (labW > 90.0f) {
        labW = 90.0f;
    }
    [self.arrowImgV setX:MaxX(self.locationLab) - (self.locationLab.width - labW)/2];
}

- (void)tapLocationv
{
    self.arrowImgV.transform = CGAffineTransformMakeRotation(M_PI);
    if (_homeSelectAreaBlock) {
        _homeSelectAreaBlock();
    }
}

@end

@implementation RightNavgationView
#define kTagInt 300
- (id)initWithFrame:(CGRect)frame withArr:(NSArray *)imgArr
{
    self = [super initWithFrame:frame];
    if (self){
        CGFloat kBW = kTopBarHeight;
        self.frame = CGRectMake(0, 0, imgArr.count*kBW, kBW);
        
        for (NSInteger m = 0; m < imgArr.count; m++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = self.bounds;
            [button setX:(kBW)*m];
            [button setWidth:kBW];
            [button setImage:[UIImage imageNamed:imgArr[m]] forState:0];
            button.contentHorizontalAlignment = 2;
            button.adjustsImageWhenHighlighted = NO;
            [button addTarget:self action:@selector(navMenuClicked:)
             forControlEvents:UIControlEventTouchUpInside];
            button.tag = m + kMenuMapBtn;
            [self addSubview:button];
        }
    }
    return self;
}

- (void)navMenuClicked:(UIButton *)btn
{
    if (_selectNavIndexBlock) {
        _selectNavIndexBlock(btn.tag);
    }
}

@end

@implementation SearchNavgationView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        [self initialization];
    }
    return self;
}

- (void)initialization
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH-60.f, 27.f);
    self.backgroundColor = UIColorFromRGB(0x3d3365);
    ViewRadius(self, self.height/2.f); //3.f
    
    UITapGestureRecognizer *clickTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTap:)];
    [self addGestureRecognizer:clickTap];
    
    UIImage *bImage = [UIImage imageNamed:@"default_hsearch_normal"];
    CGFloat kw = IMAGEWIDTH(bImage);
    CGFloat kh = IMAGEHEIGHT(bImage);
#pragma 搜索图片
    UIImageView *searchImg = [[UIImageView alloc] initWithFrame:
                              CGRectMake(12.f, (self.height-kh)/2, kw, kh)];
    searchImg.userInteractionEnabled = YES;
    searchImg.image = bImage;
    [self addSubview:searchImg];
    
#pragma 昵称
    UITextField *hSearchBar = [[UITextField alloc]initWithFrame:self.bounds];
    hSearchBar.x = searchImg.maxX+8.f;
    hSearchBar.width = self.width-hSearchBar.x-STkPadding;
    hSearchBar.userInteractionEnabled = YES;
    hSearchBar.textColor = [UIColor colorWithWhite:1.f alpha:.7];
    hSearchBar.font = [UIFont systemFontOfSize:13];
    hSearchBar.enabled = NO;
    [self addSubview:hSearchBar];
    self.hSearchBar = hSearchBar;
    
}

- (void)clickTap:(id)sender
{
    self.clickSearchViewBlock ? self.clickSearchViewBlock() : nil;
}

@end


