//
//  MyCustomSearchBar.m
//  HanyuSearchJoy
//
//
//  Created by YunShangCompany on 2017/5/18.
//  Copyright © 2017年 . All rights reserved.
//

#import "MyCustomSearchBar.h"
#import "UISearchBar+FMAdd.h"
@interface MyCustomSearchBar ()
@property (strong, nonatomic) UIButton *voiceButton;

@end

@implementation MyCustomSearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViewLoading];
    }
    return self;
}

- (void)initViewLoading {
    
    //1. 设置背景颜色
    //设置背景图是为了去掉上下黑线
    self.backgroundImage = [UIImage new];
    // 设置SearchBar的颜色主题为白色
    self.barTintColor = [UIColor whiteColor];
    
    //2. 设置圆角和边框颜色
    UITextField *searchField = [self valueForKey:@"searchField"];
    if (searchField) {
        [searchField setBackgroundColor:[UIColor whiteColor]];
        searchField.layer.cornerRadius = 14.0f;
        searchField.layer.borderColor = lGrayTintColor.CGColor;
        searchField.layer.borderWidth = .5;
        searchField.layer.masksToBounds = YES;
    }
    //3. 设置按钮文字和颜色
    [self fm_setCancelButtonTitle:@"取消"];
    
    self.tintColor = WholeColor;
    //设置取消按钮字体
    [self fm_setCancelButtonFont:[UIFont systemFontOfSize:16]];
    //修正光标颜色
    [searchField setTintColor:WholeColor];//[UIColor blackColor]
    
    //4. 设置输入框文字颜色和字体
    [self fm_setTextColor:[UIColor blackColor]];
    [self fm_setTextFont:[UIFont systemFontOfSize:14]];
    
    //5. 设置搜索Icon
    [self setImage:[UIImage imageNamed:@"default_bsearch_normal"]
            forSearchBarIcon:UISearchBarIconSearch
            state:UIControlStateNormal];
    
    //6. 实现类似微信的搜索框
    UIButton *voiceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [voiceButton setImage:[UIImage imageNamed:@"Voice_button_icon"] forState:UIControlStateNormal];
    [voiceButton addTarget:self action:@selector(tapVoiceButton:) forControlEvents:UIControlEventTouchUpInside];
    [searchField addSubview:voiceButton];
    self.voiceButton = voiceButton;
    
    //Autolayout
    voiceButton.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *views = NSDictionaryOfVariableBindings(voiceButton);
    //设置水平方向约束
    [searchField addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[voiceButton(21)]-|" options:NSLayoutFormatAlignAllRight | NSLayoutFormatAlignAllLeft metrics:nil views:views]];
    //设置高度约束
    [searchField addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[voiceButton(21)]" options:NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllBottom metrics:nil views:views]];
    //设置垂直方向居中约束
    [searchField addConstraint:[NSLayoutConstraint constraintWithItem:voiceButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:searchField attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    //设置类似QQ搜索框
    //self.minimalSearchBar.searchBarStyle = UISearchBarStyleMinimal;
    
}

- (void)initCustomSearchBar:(UISearchBar *)bar
{
    UIColor *bgColor = UIColorFromRGB(0xf7f7f7);
    //1. 设置背景颜色
    //  *******  设置背景图是为了去掉上下黑线  *******   //
    bar.backgroundImage = [UIImage imageWithColor:bgColor
                            size:CGSizeMake(bar.width, 44.f)];
    //  ******* 设置SearchBar的颜色主题为白色  *******  //
    bar.barTintColor = bgColor;
    
    //2. 设置圆角和边框颜色
    UITextField *searchField = [bar valueForKey:@"searchField"];
    if (searchField) {
        [searchField setBackgroundColor:[UIColor whiteColor]];
        searchField.layer.cornerRadius = 14.0f;
        searchField.layer.borderColor = UIColorFromRGB(0xebebeb).CGColor;
        searchField.layer.borderWidth = .5;
        searchField.layer.masksToBounds = YES;
    }
    //3. 设置按钮文字和颜色
    [bar fm_setCancelButtonTitle:@"取消"];
    
    bar.tintColor = WholeColor;
    //设置取消按钮字体
    [bar fm_setCancelButtonFont:[UIFont systemFontOfSize:16]];
    //修正光标颜色
    [searchField setTintColor:bar.tintColor];//[UIColor blackColor]
    
    //4. 设置输入框文字颜色和字体
    [bar fm_setTextColor:[UIColor blackColor]];
    [bar fm_setTextFont:[UIFont systemFontOfSize:14]];
    
    //5. 设置搜索Icon
    [bar setImage:[UIImage imageNamed:@"default_bsearch_normal"]
    forSearchBarIcon:UISearchBarIconSearch
            state:UIControlStateNormal];
    if ([bar.subviews count]) {
        if ([[[bar.subviews firstObject] subviews] count]) {
            UIImageView *lineImageView = [[[bar.subviews firstObject] subviews] firstObject];
            lineImageView.layer.borderColor = bgColor.CGColor;
            lineImageView.layer.borderWidth = 1.f;
        }
    }
    
}

- (void)initClearSearchBar:(UISearchBar *)bar
{
    //2. 设置圆角和边框颜色
    UITextField *searchField = [bar valueForKey:@"searchField"];
    if (searchField) {
        [searchField setBackgroundColor:[UIColor colorWithWhite:1.f alpha:.9]];
        searchField.layer.cornerRadius = 14.0f;
        searchField.layer.borderColor = [UIColor colorWithWhite:1.f alpha:.1].CGColor;
        searchField.layer.borderWidth = .5;
        searchField.layer.masksToBounds = YES;
    }
    //3. 设置按钮文字和颜色
    [bar fm_setCancelButtonTitle:@"取消"];
    
    bar.tintColor = WholeColor;
    //设置取消按钮字体
    [bar fm_setCancelButtonFont:[UIFont systemFontOfSize:16]];
    //修正光标颜色
    [searchField setTintColor:bar.tintColor];//[UIColor blackColor]
    
    //4. 设置输入框文字颜色和字体
    [bar fm_setTextColor:[UIColor blackColor]];
    [bar fm_setTextFont:[UIFont systemFontOfSize:14]];
    
    //5. 设置搜索Icon
    [bar setImage:[UIImage imageNamed:@"default_bsearch_normal"]
 forSearchBarIcon:UISearchBarIconSearch
            state:UIControlStateNormal];
    if ([bar.subviews count]) {
        if ([[[bar.subviews firstObject] subviews] count]) {
            UIImageView *lineImageView = [[[bar.subviews firstObject] subviews] firstObject];
            lineImageView.layer.borderColor = UIColorFromRGB(0xf7f7f7).CGColor;
            lineImageView.layer.borderWidth = 1.f;
        }
    }
}

//按钮触摸事件
- (IBAction)tapVoiceButton:(id)sender {
    NSLog(@"Tap voiceButton");
}

@end
