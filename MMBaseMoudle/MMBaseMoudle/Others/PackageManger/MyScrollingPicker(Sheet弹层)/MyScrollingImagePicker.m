//
//  HySideScrollingImagePicker.m
//  TestProject
//
//  Created by Apple on 15/6/25.
//  Copyright (c) 2015年 YUNSHANG ALERATION. All rights reserved.
//

#import "MyScrollingImagePicker.h"
#import "SideScrollingLayout.h"
#import "HCollectionViewCell.h"
#import "SideScrollingCheckCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "AssetsLibraryD.h"
#define kImageSpacing 5.0f
#define kCollectionViewHeight 178.0f
#define ItemHeight 50.0f
#define H [UIScreen mainScreen].bounds.size.height
#define W [UIScreen mainScreen].bounds.size.width
#define Color UIColorFromRGB(0x7a72ec)
#define kBackColor [UIColor groupTableViewBackgroundColor]
#define Spacing 8.0f


@interface MyScrollingImagePicker ()<UICollectionViewDataSource,UICollectionViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic,assign)NSInteger maxCount;

@property (nonatomic,copy)NSString *cancelStr;

@property (nonatomic,strong)NSArray *ButtonTitles;

@property (nonatomic,weak) UIView * BottomView;

@property (nonatomic,weak)UICollectionView *CollectionView;

@property (nonatomic, strong) NSMapTable *indexPathToCheckViewTable;

@property (nonatomic, strong) ALAssetsGroup *group;

@property (nonatomic, strong) NSMutableArray *allArr;

@property (nonatomic, strong) NSMutableArray *selectedIndexes;

@property (nonatomic, strong) NSMutableArray *selectedAssets;

@property (nonatomic,strong)NSIndexPath	* lastIndexPath;

@property (nonatomic,strong)NSMutableArray *assetsGroups;

@property (nonatomic,strong)AssetsLibraryD *lib;

@end

@implementation MyScrollingImagePicker

-(NSMutableArray *)assetsGroups{
    if (!_assetsGroups) {
        _assetsGroups=[[NSMutableArray alloc]init];
    }
    return _assetsGroups;
}

-(AssetsLibraryD *)lib{
    if (!_lib) {
        _lib = [[AssetsLibraryD alloc] init];
    }
    return _lib;
}

-(instancetype) initWithCancelStr:(NSString *)str otherButtonTitles:(NSArray *)Titles WithMaxCount:(NSInteger)maxCount{
    
    self = [super init];
    if (self) {
        __weak MyScrollingImagePicker *weakSlef = self;
        _lib = [[AssetsLibraryD alloc] init];
        weakSlef.maxCount = maxCount;
        _lib.GetImageBlock = ^(NSArray *ImgsData){
            if (ImgsData.count != 0) {
                weakSlef.cancelStr = str;
                weakSlef.ButtonTitles = Titles;
                [weakSlef LoadUI];
            }
        };
        if ([ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusRestricted) {
            DLog(@"This application is not authorized to access photo data.");
        }else if([ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusDenied){
            DLog(@"用户已经明确否认了这一应用程序访问数据的照片。");
            //[kAlert doYes:@"读取失败" body:@"请打开 设置-隐私-照片 来进行设置" yes:^{}];
            HYAlertView *alert = [[HYAlertView alloc] initWithTitle:@"读取失败" icon:nil message:@"请打开 设置-隐私-照片 来进行设置" block:^(HYAlertView *alertView, NSInteger buttonIndex) {} buttonTitles:@"知道了", nil];
            [alert show];
        }else if ([ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusAuthorized){
            DLog(@"SER已授权该应用程序访问数据的照片。");
            _cancelStr = str;
            _ButtonTitles = Titles;
            [self LoadUI];
        }else if ([ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusNotDetermined){
            DLog(@"用户还没有做出选择的问候这个应用程序");
            _cancelStr = str;
            _ButtonTitles = Titles;
            [self LoadUI];
        }
        [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    }
    return self;
}

-(void)LoadUI{
    
    self.selectedIndexes = [NSMutableArray array];
    self.allArr = [NSMutableArray array];
    self.selectedAssets = [NSMutableArray array];
    /*self*/
    [self setFrame:CGRectMake(0, 0, W, H)];
    [self setBackgroundColor:[UIColor clearColor]];
    /*end*/
    
    /*buttomView*/
    UIView *ButtomView = [[UIView alloc] init];
    
    ButtomView.backgroundColor = kBackColor;
    CGFloat height = ((ItemHeight+0.5f)+Spacing) + (_ButtonTitles.count * (ItemHeight+0.5f)) + kCollectionViewHeight;
    [ButtomView setFrame:CGRectMake(0, H, W, height)];
    _BottomView = ButtomView;
    [self addSubview:ButtomView];
    /*end*/
    
    /*CanceBtn*/
    UIButton *Cancebtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [Cancebtn setBackgroundColor:[UIColor whiteColor]];
    [Cancebtn setFrame:CGRectMake(0, CGRectGetHeight(ButtomView.bounds) - ItemHeight, W, ItemHeight)];
    [Cancebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [Cancebtn setTitle:_cancelStr forState:UIControlStateNormal];
    [Cancebtn setBackgroundImage:[CustomUtils imageFromColor:lGrayTintColor] forState:UIControlStateHighlighted];
    Cancebtn.titleLabel.font = [UIFont systemFontOfSize:19.f];
    [Cancebtn addTarget:self action:@selector(SelectedButtons:) forControlEvents:UIControlEventTouchUpInside];
    [Cancebtn setTag:100];
    [_BottomView addSubview:Cancebtn];
    /*end*/

    /*Items*/
    for (NSString *Title in _ButtonTitles) {
        
        NSInteger index = [_ButtonTitles indexOfObject:Title];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setBackgroundColor:[UIColor whiteColor]];
        
        CGFloat hei = (50.5 * _ButtonTitles.count)+Spacing;
        CGFloat y = (CGRectGetMinY(Cancebtn.frame) + (index * (ItemHeight+0.5))) - hei;
        
        [btn setFrame:CGRectMake(0, y, W, ItemHeight)];
        [btn setTag:(index + 100)+1];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:Title forState:UIControlStateNormal];
        [btn setBackgroundImage:[CustomUtils imageFromColor:lGrayTintColor] forState:UIControlStateHighlighted];
        btn.titleLabel.font = [UIFont systemFontOfSize:19.f];
        [btn addTarget:self action:@selector(SelectedButtons:) forControlEvents:UIControlEventTouchUpInside];
        [_BottomView addSubview:btn];
    }
    /*END*/
    /*CollectionView*/
    // Configure the flow layout
    SideScrollingLayout *flow = [[SideScrollingLayout alloc] init];
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flow.minimumInteritemSpacing = kImageSpacing;
    
    // Configure the collection view
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flow];
    //collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.allowsMultipleSelection = YES;
    collectionView.allowsSelection = YES;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.collectionViewLayout = flow;
    [collectionView registerClass:[HCollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    [collectionView registerClass:[SideScrollingCheckCell class] forSupplementaryViewOfKind:@"check" withReuseIdentifier:@"CheckCell"];
    collectionView.contentInset = UIEdgeInsetsMake(0, 6, 0, 6);
    
    [ButtomView addSubview:collectionView];
    self.CollectionView = collectionView;
    
    self.CollectionView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    
    self.indexPathToCheckViewTable = [NSMapTable strongToWeakObjectsMapTable];
    
    [self.CollectionView setFrame:CGRectMake(0, 5, W, kCollectionViewHeight-10)];
    
    UIActivityIndicatorView *act = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.CollectionView.bounds)/2-10.f , CGRectGetHeight(self.CollectionView.bounds)/2.f-10.f, 20.f, 20.f)];
    act.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    [act startAnimating];
    [self.CollectionView addSubview:act];
    
    /*enb*/
    WEAKSELF
    /*//高清图片
     [weakSelf.allArr addObject:[UIImage imageWithCGImage:
     [asset.defaultRepresentation fullScreenImage]]];*/
    _lib.GetImageBlock = ^(NSArray *ImgsData){
        [ImgsData enumerateObjectsUsingBlock:^(ALAsset *asset, NSUInteger idx, BOOL *stop){
            [weakSelf.allArr addObject:[UIImage
                imageWithCGImage:[asset aspectRatioThumbnail]]];
        }];
        [weakSelf.CollectionView reloadData];
        [act stopAnimating];
    };
    
    [UIView animateWithDuration:.5f delay:0 usingSpringWithDamping:0.9f initialSpringVelocity:0.7f options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionLayoutSubviews animations:^{
        
        [weakSelf setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f]];
        //[ButtomView setFrame:CGRectMake(0, H - height, W, height+10)];
        [ButtomView setFrame:CGRectMake(0, H - height, W, height)];
    } completion:^(BOOL finished) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:weakSelf action:@selector(dismiss:)];
        tap.delegate = self;
        [weakSelf addGestureRecognizer:tap];
        //[ButtomView setFrame:CGRectMake(0, H - height, W, height)];
    }];
}

-(void)SelectedButtons:(UIButton *)btns{
    if (self.SeletedImages) {
        self.SeletedImages(self.selectedIndexes,btns.tag-100);
    }
    [self DismissBlock:^(BOOL Complete) {}];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    return _allArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    HCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    //ALAsset *asset = _allArr[indexPath.row];
    cell.imageView.image = self.allArr[indexPath.item];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath;
{
    SideScrollingCheckCell *checkView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"CheckCell" forIndexPath:indexPath];
    [self.indexPathToCheckViewTable setObject:checkView forKey:indexPath];
    
    if ([[collectionView indexPathsForSelectedItems] containsObject:indexPath]) {
        [checkView setChecked:YES];
    }
    
    return checkView;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    [self toggleSelectionAtIndexPath:indexPath collection:collectionView];
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    [self toggleSelectionAtIndexPath:indexPath collection:collectionView];
    
}

- (void)toggleSelectionAtIndexPath:(NSIndexPath *)indexPath
                        collection:(UICollectionView *)collectionView
{
   
    UIButton *Ti = (UIButton *)[_BottomView viewWithTag:101];
    HCollectionViewCell *cell = (HCollectionViewCell *)[self.CollectionView cellForItemAtIndexPath:indexPath];
    SideScrollingCheckCell *checkmarkView = [self.indexPathToCheckViewTable objectForKey:indexPath];
    
    if ([self.selectedIndexes containsObject:cell.imageView.image]) {
        [self.selectedIndexes removeObject:cell.imageView.image];
        [cell setSelected:NO];
        [checkmarkView setChecked:NO];
    } else {
        if ([self.selectedIndexes count] >= self.maxCount) {
            //_showErrorView([NSString stringWithFormat:
                            //@"最多还能添加%ld张图片",self.maxCount], 2, self);
            return;
        }
        [collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
        [self.selectedIndexes addObject:cell.imageView.image];
        [cell setSelected:YES];
        [checkmarkView setChecked:YES];
    }
    if (!self.selectedIndexes.count) {
        [Ti setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [Ti setTitle:_ButtonTitles[Ti.tag-101] forState:UIControlStateNormal];
        
    }else{
        [Ti setTitle:[NSString stringWithFormat:@"确定(%ld张)",(unsigned long)self.selectedIndexes.count] forState:0];
        [Ti setTitleColor:Color forState:UIControlStateNormal];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    
    //ALAsset *asset = _allArr[indexPath.row];
    UIImage *imageAtPath = self.allArr[indexPath.item];
    
    CGFloat imageHeight = imageAtPath.size.height;
    CGFloat viewHeight = collectionView.bounds.size.height;
    CGFloat scaleFactor = viewHeight/imageHeight;
    
    CGSize scaledSize = CGSizeApplyAffineTransform(imageAtPath.size, CGAffineTransformMakeScale(scaleFactor, scaleFactor));
    return scaledSize;
}

-(void)DismissBlock:(CompleteAnimationBlock)block{
    
    
    WEAKSELF
    CGFloat height = ((ItemHeight+0.5f)+Spacing) + (_ButtonTitles.count * (ItemHeight+0.5f)) + kCollectionViewHeight;
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8f initialSpringVelocity:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        
        [weakSelf setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.0f]];
        [_BottomView setFrame:CGRectMake(0, H, W, height)];
        
    } completion:^(BOOL finished) {
        
        block(finished);
        [self removeFromSuperview];
        
    }];
    
}

-(void)dismiss:(UITapGestureRecognizer *)tap{
    
    if(!CGRectContainsPoint(self.frame, [tap locationInView:_BottomView])) {
        [self DismissBlock:^(BOOL Complete) {}];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (touch.view != self) {
        return NO;
    }
    return YES;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

@class HyActionSheet;

@interface HyActionSheet ()<UIGestureRecognizerDelegate>

@property (nonatomic,copy)      NSString *CancelStr;

@property (nonatomic,strong)    NSArray *Titles;

@property (nonatomic,weak)      UIView *buttomView;

@property (nonatomic,copy)      NSString *AttachTitle;

@end

@implementation HyActionSheet

-(instancetype) initWithCancelStr:(NSString *)str otherButtonTitles:(NSArray *)Titles AttachTitle:(NSString *)AttachTitle{

    self = [super init];
    if (self) {
        _AttachTitle = AttachTitle;
        _CancelStr = str;
        _Titles = Titles;
        [self loadUI];
        [[[UIApplication sharedApplication] keyWindow] addSubview:self];
        if (kActionControl.keyboardIsVisible) {
            [kHHKeyWindow endEditing:YES];
        }
    }
    
    return self;
}

-(void)loadUI{
    
    /*self*/
    [self setFrame:CGRectMake(0, 0, W, H)];
    [self setBackgroundColor:[UIColor clearColor]];
    /*end*/
    
    /*buttomView*/
    UIView *buttomView = [[UIView alloc] init];
    
    buttomView.backgroundColor = kBackColor;
    CGFloat height;
    //Title 的 高度
    UIFont *titleFont = [UIFont systemFontOfSize:15.f];
    CGFloat kSubTitleHeight = [_AttachTitle getHeightWithFont:titleFont constrainedToW:W-30.f]+45.f;
    if ([self isBlankString:_AttachTitle]) {
        height = ((ItemHeight+0.5f)+Spacing) + (_Titles.count * (ItemHeight+0.5f));
    }else{
        height  = ((ItemHeight+0.5f)+Spacing) + (_Titles.count * (ItemHeight+0.5f)) + kSubTitleHeight;
    }
    
    [buttomView setFrame:CGRectMake(0, H , W, height)];
    _buttomView = buttomView;
    [self addSubview:buttomView];
    ViewBorderShadow(_buttomView, 3.f, 3.f, .5);
    /*end*/
    
    /*CanceBtn*/
    UIButton *Cancebtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [Cancebtn setBackgroundColor:[UIColor whiteColor]];
    [Cancebtn setFrame:CGRectMake(0, CGRectGetHeight(buttomView.bounds) - ItemHeight, W, ItemHeight)];
    [Cancebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [Cancebtn setTitle:_CancelStr forState:UIControlStateNormal];
    [Cancebtn setBackgroundImage:[CustomUtils imageFromColor:lGrayTintColor] forState:UIControlStateHighlighted];
    Cancebtn.titleLabel.font = [UIFont systemFontOfSize:17.f];
    [Cancebtn addTarget:self action:@selector(SelectedButtons:) forControlEvents:UIControlEventTouchUpInside];
    [Cancebtn setTag:100];
    [_buttomView addSubview:Cancebtn];
    /*end*/
    /*Items*/
    for (NSString *Title in _Titles) {
        
        NSInteger index = [_Titles indexOfObject:Title];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setBackgroundColor:[UIColor whiteColor]];
        
        CGFloat hei = (50.5 * _Titles.count)+Spacing;
        CGFloat y = (CGRectGetMinY(Cancebtn.frame) + (index * (ItemHeight+0.5))) - hei;
        
        [btn setFrame:CGRectMake(0, y, W, ItemHeight)];
        [btn setTag:(index + 100)+1];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:Title forState:UIControlStateNormal];
        [btn setBackgroundImage:[CustomUtils imageFromColor:lGrayTintColor] forState:UIControlStateHighlighted];
        btn.titleLabel.font = [UIFont systemFontOfSize:19.f];
        [btn addTarget:self action:@selector(SelectedButtons:) forControlEvents:UIControlEventTouchUpInside];
        [_buttomView addSubview:btn];
    }
    /*END*/
    
    if (![self isBlankString:_AttachTitle]) {
        UIView *Bg_TitleView = [[UIView alloc] initWithFrame:
                                CGRectMake(0, 0, W, kSubTitleHeight)];
        Bg_TitleView.backgroundColor = [UIColor whiteColor];
        [_buttomView addSubview:Bg_TitleView];
        
        CGRect frame = Bg_TitleView.bounds;
        frame.origin.x = 15.f;
        frame.size.width = WIDTH(Bg_TitleView)-30.f;
        UILabel *AttachTitleView = [[UILabel alloc] initWithFrame:frame];
        
        AttachTitleView.backgroundColor = [UIColor clearColor];
        AttachTitleView.font = titleFont;
        AttachTitleView.textColor = [UIColor grayColor];
        AttachTitleView.text = _AttachTitle;
        AttachTitleView.textAlignment = 1;
        AttachTitleView.numberOfLines = 0;
        
        [Bg_TitleView addSubview:AttachTitleView];
    }
    
    WEAKSELF
   [UIView animateWithDuration:0.45 delay:0 usingSpringWithDamping:0.9f initialSpringVelocity:0.7f options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionLayoutSubviews animations:^{
        [weakSelf setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3f]];
        //[ButtomView setFrame:CGRectMake(0, H - height, W, height+10)];
        [_buttomView setFrame:CGRectMake(0, H - height, W, height)];
    } completion:^(BOOL finished) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:weakSelf action:@selector(dismiss:)];
        tap.delegate = self;
        [weakSelf addGestureRecognizer:tap];
        //[ButtomView setFrame:CGRectMake(0, H - height, W, height)];
    }];
    
}

-(void)SelectedButtons:(UIButton *)btns{
    if (self.ButtonIndex) {
        self.ButtonIndex(btns.tag-100);
    }
    [self DismissBlock:^(BOOL Complete) {
    }];
    
}

-(void) ChangeTitleColor:(UIColor *)color AndIndex:(NSInteger )index{
    
    UIButton *btn = (UIButton *)[_buttomView viewWithTag:index + 100];
    [btn setTitleColor:color forState:UIControlStateNormal];
    
}

-(void)dismiss:(UITapGestureRecognizer *)tap{
    
    if( CGRectContainsPoint(self.frame, [tap locationInView:_buttomView])) {
        NSLog(@"tap");
    } else{
        [self DismissBlock:^(BOOL Complete) {}];
    }
}

-(void)DismissBlock:(CompleteAnimationBlock)block{
    
    
    WEAKSELF
    CGFloat height = ((ItemHeight+0.5f)+Spacing) + (_Titles.count * (ItemHeight+0.5f)) + kCollectionViewHeight;
    
    [UIView animateWithDuration:0.45 delay:0 usingSpringWithDamping:0.9f initialSpringVelocity:0.7f options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionLayoutSubviews animations:^{
        
        [weakSelf setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.0f]];
        [_buttomView setFrame:CGRectMake(0, H, W, height)];
        
    } completion:^(BOOL finished) {
        
        block(finished);
        [self removeFromSuperview];
        
    }];
    
}

- (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

@end
