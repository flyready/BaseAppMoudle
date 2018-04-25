//
//  CustomSearchView.h
//  MySelectCityDemo
//
//  Created by 李阳 on 15/9/2.
//  Copyright (c) 2015年 WXDL. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomSearchViewDelegate <NSObject>

-(void)searchBeginEditing;
-(void)didSelectCancelBtn;
-(void)searchString:(NSString *)string;
@end

typedef void (^SelectAreaBlock) (BOOL selected);
@interface CustomSearchView : UIView<UISearchBarDelegate>
@property (nonatomic, retain) UISearchBar *searchBar;
@property (nonatomic, retain) UIButton *cancelBtn;
@property (nonatomic, assign) id <CustomSearchViewDelegate>delegate;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) SelectAreaBlock selectAreaBlock;

@end


