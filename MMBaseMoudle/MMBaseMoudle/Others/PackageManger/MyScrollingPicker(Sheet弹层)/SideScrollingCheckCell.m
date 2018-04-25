//
//  SideScrollingCheckCell.m
//  TestProject
//
//  Created by Apple on 15/6/25.
//  Copyright (c) 2015年 YUNSHANG ALERATION. All rights reserved.
//

#import "SideScrollingCheckCell.h"

@interface SideScrollingCheckCell ()

@property (nonatomic, weak) UIImageView *imageView;

@property (nonatomic, assign)BOOL open;

@end

@implementation SideScrollingCheckCell

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *hitView = [super hitTest:point withEvent:event];
    if(!_open){
        if (hitView == self){
            return nil;
        }else{
            return hitView;
        }
    }
    return hitView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.open = YES;
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (void)setup
{
    UIImage *checkImage = [UIImage imageNamed:@"icon_unchecked"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:checkImage];
    [imageView setFrame:CGRectMake(0, 0, IMAGEWIDTH(checkImage)*.8,
                                   IMAGEHEIGHT(checkImage)*.8)];
    [self addSubview:imageView];
    self.imageView = imageView;
}

- (void)setChecked:(BOOL)checked
{
    if (checked) {
        UIImage *emptyCheckmark = [UIImage imageNamed:@"icon_checked"];
        self.imageView.image = emptyCheckmark;
        
    } else {
        UIImage *fullCheckmark = [UIImage imageNamed:@"icon_unchecked"];
        self.imageView.image = fullCheckmark;
    }
}

- (void)prepareForReuse
{
    [self setChecked:NO];
}

@end
