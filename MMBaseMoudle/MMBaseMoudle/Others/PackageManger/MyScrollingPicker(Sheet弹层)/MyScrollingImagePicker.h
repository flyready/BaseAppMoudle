//
//  HySideScrollingImagePicker.h
//  TestProject
//
//  Created by Apple on 15/6/25.
//  Copyright (c) 2015年 YUNSHANG ALERATION. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CompleteAnimationBlock)(BOOL Complete);

typedef void(^SeletedImages)(NSArray *GetImages, NSInteger buttonIndex);

@interface MyScrollingImagePicker : UIView

//@property (nonatomic,assign)BOOL isMultipleSelection;

@property (nonatomic,strong) SeletedImages SeletedImages;

-(instancetype) initWithCancelStr:(NSString *)str otherButtonTitles:(NSArray *)Titles WithMaxCount:(NSInteger)maxCount;

-(void)DismissBlock:(CompleteAnimationBlock)block;

@end

typedef void(^SeletedButtonIndex)(NSInteger buttonIndex);

@interface HyActionSheet : UIView

@property (nonatomic,strong) SeletedButtonIndex ButtonIndex;

-(instancetype) initWithCancelStr:(NSString *)str otherButtonTitles:(NSArray *)Titles AttachTitle:(NSString *)AttachTitle;

-(void) ChangeTitleColor:(UIColor *)color AndIndex:(NSInteger )index;

@end
