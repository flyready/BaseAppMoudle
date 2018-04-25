//
//  CityViewController.h
//  MySelectCityDemo
//
//  Created by 李阳 on 15/9/1.
//  Copyright (c) 2015年 WXDL. All rights reserved.
//

#define     MAX_COMMON_CITY_NUMBER      6
#define     COMMON_CITY_DATA_KEY        @"CityPickerCommonCityArray"

@interface LocationAreaViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,copy) void(^selectString)(NSString *string,
                                NSString *regon, NSInteger index);
@property (nonatomic,copy) void(^dismissVcBlock) (void);
@property (nonatomic,strong)NSString *selectCityString;
@property (nonatomic,assign)NSInteger selectIndex;

@end
