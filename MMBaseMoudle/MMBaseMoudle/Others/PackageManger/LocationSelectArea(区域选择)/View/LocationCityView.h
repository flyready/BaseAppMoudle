//
//  LocationCityView.h
//  eTailor_IOS_Client
//
//  Created by YunShangCompany on 16/6/6.
//  Copyright © 2016年 YUNSHANG ALERATION. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef void (^SelectAreaBlock) (BOOL selected);
//@interface LocationCityView : UIView
//@property (nonatomic, assign) BOOL selected;
//@property (nonatomic, strong) SelectAreaBlock selectAreaBlock;
//
//@end

typedef void (^HomeSelectAreaBlock) (void);
@interface LocationCityView : UIView
@property (nonatomic, strong) UIImageView *arrowImgV;
@property (nonatomic, strong) NSString *locationStr;
@property (nonatomic, strong) HomeSelectAreaBlock homeSelectAreaBlock;

@end

typedef NS_ENUM(NSInteger ,RightNavActionType) {
    kMenuMapBtn = 300,
    kMenuMoreBtn
};
typedef void (^SelectNavIndexBlock) (NSInteger index);
@interface RightNavgationView : UIView
@property (nonatomic, strong) SelectNavIndexBlock selectNavIndexBlock;

- (id)initWithFrame:(CGRect)frame withArr:(NSArray *)imgArr;

@end

typedef void (^ClickSearchViewBlock) (void);

@interface SearchNavgationView : UIView
@property (nonatomic, strong) ClickSearchViewBlock clickSearchViewBlock;
@property (nonatomic, strong) UITextField *hSearchBar;

@end
