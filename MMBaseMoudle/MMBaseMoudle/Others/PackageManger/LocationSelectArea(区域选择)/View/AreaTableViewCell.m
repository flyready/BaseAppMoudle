//
//  CityTableViewCell.m
//  MySelectCityDemo
//
//  Created by ZJ on 15/10/28.
//  Copyright © 2015年 WXDL. All rights reserved.
//

#import "AreaTableViewCell.h"
//#define  ScreenWidth [UIScreen mainScreen].bounds.size.width
@implementation AreaTableViewCell
#define kJTag 10

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cityArray:(NSArray*)array
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.clipsToBounds = YES;
        _cityArray =array;
        //DLog(@" - -- - - - - -  _cityArray - - - %@",_cityArray);
        for(NSInteger i=0;i<array.count;i++){
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.center = CGPointMake(SCREEN_WIDTH/6+(SCREEN_WIDTH/3-10)*(i%3), 30+(30+15)*(i/3));
            btn.tag = i+kJTag;
            btn.bounds = CGRectMake(0, 0, SCREEN_WIDTH/3-30, 35);
            [btn setTitleColor:[UIColor colorWithRed:54/255.0 green:54/255.0 blue:54/255.0 alpha:1] forState:0];
            [btn setTitle:array[i] forState:0];
            [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            btn.layer.borderWidth = 0.5;
            btn.layer.borderColor = [UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:.8].CGColor;
            btn.layer.cornerRadius = 2.f;
        }
    }
    return self;
}

- (void)setIndex:(NSInteger)index
{
    if (_index != index) {
        _index = index;
    }
    for (NSInteger m = 0; m < _cityArray.count; m++) {
        UIButton *btn = VIEWWITHTAG(self, m+kJTag);
        if (m == _index) {
            [btn setBackgroundColor:lGrayTintColor];
        }else{
            [btn setBackgroundColor:[UIColor whiteColor]];
        }
    }
}

+ (CGFloat)getHeightWithContent:(NSArray *)arr select:(BOOL)select
{
    if (([arr count])&&(!select)) return 0.f;
    CGFloat IntervalY = 10.f;
    NSInteger count = arr.count;
    CGFloat contentHeight = ceilf((float)count/3)*(35+IntervalY);
    return contentHeight+15.f;
}

-(void)click:(UIButton *)btn
{
    if (self.didSelectedBtn) {
        self.didSelectedBtn((int)btn.tag-kJTag);
    }
}

@end
