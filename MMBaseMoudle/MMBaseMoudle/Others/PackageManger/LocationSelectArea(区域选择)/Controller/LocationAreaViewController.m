//
//  CityViewController.m
//  MySelectCityDemo
//
//  Created by 李阳 on 15/9/1.
//  Copyright (c) 2015年 WXDL. All rights reserved.
//

#import "LocationAreaViewController.h"
#import "CustomTopView.h"
#import "CustomSearchView.h"
#import "ResultCityController.h"
#import "CityModel.h"
#import "AreaTableViewCell.h"
#import "OC_PickerManager.h"
//#define SCREEN_WIDTH    ([UIScreen mainScreen].bounds.size.width)
//#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
@interface LocationAreaViewController ()<CustomTopViewDelegate,CustomSearchViewDelegate,ResultCityControllerDelegate>
@property (nonatomic,strong) CustomTopView *navView; //自定义导航栏
@property (nonatomic,strong) CustomSearchView *searchView; //searchBar所在的view
@property (nonatomic,strong)UIView *blackView; //输入框编辑时的黑色背景view
//@property (nonatomic,retain)NSDictionary *bigDic; // 读取本地plist文件的字典
@property (nonatomic,strong)NSMutableArray *sectionTitlesArray; // 区头数组
@property (nonatomic,strong)NSMutableArray *rightIndexArray; // 右边索引数组
@property (nonatomic,strong)NSMutableArray *dataArray;// cell数据源数组
@property (nonatomic,strong)NSMutableArray *pinYinArray; // 地区名字转化为拼音的数组
@property (nonatomic,strong)ResultCityController *resultController;//显示结果的controller
@property (nonatomic,strong)NSArray *currentCityArray;// 当前城市
@property (nonatomic,strong)NSArray *hotCityArray; // 热门城市
//@property (nonatomic,strong)NSArray *regonArray; // 区县
@property (nonatomic,assign)BOOL selected;
/*
 *  常用城市id数组,自动管理，也可赋值
 */
@property (nonatomic, strong) NSMutableArray *commonCitys;


@end

@implementation LocationAreaViewController
@synthesize commonCitys = _commonCitys;

-(UIView *)blackView
{
    if(!_blackView)
    {
        _blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        _blackView.backgroundColor = [UIColor colorWithWhite:.1 alpha:.3];
        _blackView.alpha = 0;
        [self.view addSubview:_blackView];
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectCancelBtn)];
        [_blackView addGestureRecognizer:ges];
    }
    return _blackView;
}
-(ResultCityController *)resultController
{
    if(!_resultController)
    {
        _resultController = [[ResultCityController alloc] init];
        
        _resultController.view.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64);
        _resultController.delegate = self;
        [self.view addSubview:_resultController.view];
    }
    return _resultController;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:0];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:1];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadData];
    
    _searchView = [[CustomSearchView alloc] initWithFrame://44+kTCellHeight
                                CGRectMake(0, 0, SCREEN_WIDTH, 44.f)];
    _searchView.delegate = self;
    //_searchView.titleLabel.text = [NSString stringWithFormat:@"当前: %@%@",
                                 //_selectCityString,_regonArray[_selectIndex]];
    _tableView = [[UITableView alloc] initWithFrame:
                  CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView  = _searchView;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.sectionIndexColor = WholeColor;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    //_tableView.tableHeaderView = locationView;
    [self.view addSubview:_tableView];
    
    WEAKSELF
    _searchView.selectAreaBlock = ^(BOOL selected){  //  刷新
        weakSelf.selected = selected;
        [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:0]
                           withRowAnimation:UITableViewRowAnimationNone];
    };
    /*
    [kActionControl handleRealTimeLocation:^{
        [weakSelf.tableView reloadData];
    } pop:YES];
    */
    _navView = [[CustomTopView alloc] initWithFrame:
                    CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    _navView.delegate = self;
    [self.view addSubview:_navView];
    
}

#pragma mark --UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sectionTitlesArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section < 3){ //4
        return 1;
    }else{
        return [self.dataArray[section] count];
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGRect lRect = CGRectMake(15, 0, 250, 30.f);
    //if (section) {
    static NSString *HeaderIdentifier = @"header";
    UITableViewHeaderFooterView * headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeaderIdentifier];
    if(!headerView){
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:HeaderIdentifier];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:lRect];
        titleLabel.tag = 1;
        titleLabel.textColor = [UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1];
        titleLabel.font = [UIFont systemFontOfSize:15];
        [headerView.contentView addSubview:titleLabel];
    }
    UILabel *label = (UILabel *)[headerView viewWithTag:1];
    //        if (section == 1) {
    //            label.text = @"定位城市";
    //        }else if(section == 2){
    //            label.text = @"历史记录";
    //        }else if(section == 3){
    //            label.text = @"热门城市";
    //        }else{
    //            label.text = self.sectionTitlesArray[section];
    //        }
    if(section == 0){
        label.text = @"定位城市";
    }else if(section == 1){
        label.text = @"历史记录";
    }else if(section == 2){
        label.text = @"热门城市";
    }else{
        label.text = self.sectionTitlesArray[section];
    }
    return headerView;
    //}
    //return @"定位城市";//nil;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if(indexPath.section==0){
//        CGFloat height = [CityTableViewCell getHeightWithContent:
//                         [self.dataArray firstObject] select:_selected];
//        return height;
//    }else
    if (indexPath.section==0){
        return 60.f;
    }else if (indexPath.section==1){
        CGFloat height = 0.f;
        if ([self.dataArray count] > 1) { //2
            height = [AreaTableViewCell getHeightWithContent:
                        self.dataArray[1] select:YES]; //2
        }
        return height;
    }else if (indexPath.section==2){
        return 150.f;
    }else{
        return kTCellHeight;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    if (section) return 30.f;
//    return CGFLOAT_MIN;
    return 30.f;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    if(section < 3){  //4
        AreaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cityCell"];
        if(cell==nil){
            cell = [[AreaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cityCell" cityArray:self.dataArray[section]];
        }
        //if (!section) { cell.index = _selectIndex; }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        __weak typeof(self) weakSelf = self;
        cell.didSelectedBtn = ^(int tag){
            if (section) {
                weakSelf.selectIndex = 0;
                if (section == 1) { //2
                    NSString *dataStr = weakSelf.commonCitys[tag];
                    weakSelf.selectString(dataStr, nil, weakSelf.selectIndex);
                    [weakSelf saveCityData:dataStr];
                }else if(section == 2){  //3
                    NSString *dataStr = weakSelf.hotCityArray[tag];
                    weakSelf.selectString(dataStr, nil, weakSelf.selectIndex);
                    [weakSelf saveCityData:dataStr];
                }else{
                   
                }
            }else{
                //if ([CustomUtils ISNULL:[UserObject shareUser].City]) {
                NSString *dataStr = [weakSelf.currentCityArray firstObject];
                weakSelf.selectString(dataStr, nil, weakSelf.selectIndex);
                //}
            }
            /*else{
                weakSelf.selectIndex = tag;
                weakSelf.selectString(weakSelf.selectCityString,
                             weakSelf.regonArray[tag], weakSelf.selectIndex);
                [weakSelf saveCityData:weakSelf.selectCityString];
            }*/
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        };
    
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if(cell==nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            [cell setHeight:kTCellHeight];
            [cell setWidth:SCREEN_WIDTH];
        }
        NSArray *array = self.dataArray[indexPath.section];
        cell.textLabel.text = array[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.textLabel.textColor = [UIColor colorWithRed:54/255.0 green:54/255.0 blue:54/255.0 alpha:1];
        [cell addLineUp:NO andDown:YES andX:10.f];
        return cell;
    }
    return nil;
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{

    if(_blackView){
        return nil;
    }else{
        return self.rightIndexArray;
    }
}
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    //此方法返回的是section的值
    NSLog(@"  -- - - -- - - - %ld",(NSInteger)index);
    if(index==0){
        [tableView setContentOffset:CGPointZero animated:YES];
        return -1;
    }else{
        return index-1; //2
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section > 2) {  //3
        NSString *string = self.dataArray[indexPath.section][indexPath.row];
        self.selectIndex = 0;
        self.selectString(string, nil, self.selectIndex);
        [self saveCityData:string];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
#pragma mark --CustomTopViewDelegate
-(void)didSelectBackButton
{
    self.dismissVcBlock ? self.dismissVcBlock() : nil;
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark --CustomSearchViewDelegate
-(void)searchString:(NSString *)string
{
    
  // ”^[A-Za-z]+$”
     NSMutableArray *resultArray  =  [NSMutableArray array];
    if([string isZimuWithstring])
    {
        //证明输入的是字母
        self.pinYinArray = [NSMutableArray array]; //和输入的拼音首字母相同的地区的拼音
        NSString *upperCaseString2 = string.uppercaseString;
        NSString *firstString = [upperCaseString2 substringToIndex:1];
        NSArray *array = @[];
        for (NSInteger m = 0; m < self.sectionTitlesArray.count; m++) {
            if ([firstString isEqualToString:self.sectionTitlesArray[m]]) {
                if (m > 2) {  //3
                    array = self.dataArray[m];
                }
                break;
            }
        }
        [array enumerateObjectsUsingBlock:^(NSString *cityName, NSUInteger idx, BOOL * _Nonnull stop) {
            CityModel *model = [[CityModel alloc] init];
            NSString *pinYin = [cityName charactorGetFirstCharactor:NO];
            model.name = cityName;
            model.pinYinName = pinYin;
            [self.pinYinArray addObject:model];
        }];
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"pinYinName BEGINSWITH[c] %@",string];
        NSArray *smallArray = [self.pinYinArray filteredArrayUsingPredicate:pred];
        [smallArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    CityModel *model = obj;
                    [resultArray addObject:model.name];
        }];
    }
    else{
        //证明输入的是汉字
        [self.dataArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if (idx > 2) {  //3
                NSArray *sectionArray  = obj;
                NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF BEGINSWITH[c] %@",string];
                NSArray *array = [sectionArray filteredArrayUsingPredicate:pred];
                [resultArray addObjectsFromArray:array];
            }
        }];
    }
    self.resultController.dataArray = resultArray;
    [self.resultController.tableView reloadData];
}
-(void)searchBeginEditing
{
    [self.view addSubview:_blackView];

    [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        self.navView.frame = CGRectMake(0, -64, SCREEN_WIDTH, 64);
        _tableView.frame = CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.blackView.alpha = 0.8;
        
    } completion:^(BOOL finished) {
        UIView *view1 = [[UIView alloc] initWithFrame:
                            CGRectMake(0, 0, SCREEN_WIDTH, 20)];
        view1.tag = 333;
        view1.backgroundColor = lGrayTintColor;
        [self.view addSubview:view1];

    }];
    [_tableView reloadData];
}
-(void)didSelectCancelBtn
{
    UIView *view1 = (UIView *)[self.view viewWithTag:333];
    [view1 removeFromSuperview];
    [_blackView removeFromSuperview];
    _blackView = nil;
    [self.resultController.view removeFromSuperview];
    self.resultController=nil;
    [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        self.navView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 64);
        _tableView.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64);
        
        [self.searchView.searchBar  setShowsCancelButton:NO animated:YES];
        [self.searchView.searchBar resignFirstResponder];

    } completion:^(BOOL finished) {
    }];
    [_tableView reloadData];
}
#pragma mark --ResultCityControllerDelegate
-(void)didScroll
{
    [self.searchView.searchBar resignFirstResponder];
}
-(void)didSelectedString:(NSString *)string
{
    self.selectIndex = 0;
    self.selectString(string, nil, self.selectIndex);
    [self saveCityData:string];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)loadData
{
    self.selectCityString = [self.selectCityString stringRemoveCity];
    
    self.rightIndexArray = [NSMutableArray array];
    self.sectionTitlesArray = [NSMutableArray array]; //区头字母数组
    self.dataArray = [NSMutableArray array]; //包含所有区数组的大数组
   
    [self sortObjectsAccordingToInitial];   //  重新排序 市县
    
    [self.sectionTitlesArray insertObject:@"$" atIndex:0];
    [self.sectionTitlesArray insertObject:@"#" atIndex:0];
    [self.sectionTitlesArray insertObject:@"&" atIndex:0];
    //[self.sectionTitlesArray insertObject:@"!" atIndex:0];
    [self.rightIndexArray addObjectsFromArray:self.sectionTitlesArray];
    [self.rightIndexArray insertObject:UITableViewIndexSearch atIndex:0];
   
    //UserObject *user = [UserObject shareUser];
    self.currentCityArray = @[[CustomUtils ISNULL:@""]?@"定位失败":@"city"];
    self.hotCityArray = @[@"上海",@"北京",@"广州",@"深圳",@"武汉",@"天津",@"西安",@"南京",@"杭州"];
    [self.dataArray insertObject:self.hotCityArray atIndex:0];
    [self.dataArray insertObject:self.commonCitys atIndex:0];
    [self.dataArray insertObject:self.currentCityArray atIndex:0];
    //[self.dataArray insertObject:self.regonArray atIndex:0];
    
}

// 按首字母分组排序数组
-(void)sortObjectsAccordingToInitial{
    
    //DLog(@"  -- - - -- - - - -- - - - -listArray  --    %@",listArray);
    NSString *newStr = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    for(NSInteger m =0; m < [newStr length]; m++){
        NSString *charC = [newStr substringWithRange:NSMakeRange(m, 1)];
        NSMutableArray *city = [NSMutableArray array];
        for (NSDictionary *dic in kPickerManager.shiArray) {
            if ([dic[@"firstchar"] isEqualToString:charC]) {
                [city addObject:dic[@"name"]];
            }
        }
        if ([city count]) {
            [self.sectionTitlesArray addObject:charC];
            [self.dataArray addObject:city];
        }
    }
    NSMutableArray *regonArray = [NSMutableArray arrayWithObject:@"全城"];
    [kPickerManager.shiArray enumerateObjectsUsingBlock:
     ^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
         NSString *ctName = [obj[@"name"] stringRemoveCity];
         if ([ctName isEqualToString:self.selectCityString]) {
             NSInteger index = [obj[@"id"] integerValue];
             [kPickerManager.xianArray enumerateObjectsUsingBlock:
              ^(NSDictionary *xObj, NSUInteger idxx, BOOL * _Nonnull stop) {
                  if ([xObj[@"parent_id"] integerValue] == index) {
                      [regonArray addObject:xObj[@"name"]];
                  }
              }];
         }
     }];
    //self.regonArray = regonArray;
}

- (void)saveCityData:(NSString *)cityStr   // 保存城市数据
{
    if (self.commonCitys.count >= MAX_COMMON_CITY_NUMBER) {
        [self.commonCitys removeLastObject];
    }
    for (NSString *str in self.commonCitys) {
        if ([cityStr isEqualToString:str]) {
            [self.commonCitys removeObject:str];
            break;
        }
    }
    
    [self.commonCitys insertObject:cityStr atIndex:0];
    //DLog(@"  - - -- - -- - - - ---commonCitys  - -  %@",self.commonCitys);
    [[NSUserDefaults standardUserDefaults] setValue:self.commonCitys forKey:COMMON_CITY_DATA_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - Setter
- (void)setCommonCitys:(NSMutableArray *)commonCitys
{
    _commonCitys = commonCitys;
    if (commonCitys != nil && commonCitys.count > 0) {
        [[NSUserDefaults standardUserDefaults] setValue:commonCitys forKey:COMMON_CITY_DATA_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (NSMutableArray *)commonCitys
{
    if (_commonCitys == nil) {
        NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:COMMON_CITY_DATA_KEY];
        _commonCitys = (array == nil ? [[NSMutableArray alloc] init] : [[NSMutableArray alloc] initWithArray:array copyItems:YES]);
    }
    return _commonCitys;
}

@end
