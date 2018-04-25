//
//  PayView.m
//  HanyuSearchJoy
//
//  Created by charmer on 17/2/16.
//  Copyright © 2017年 HCL黄. All rights reserved.
//

#import "PayView.h"

@interface PayView()

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIButton *balancePayBtn;//钱包余额支付
@property (weak, nonatomic) IBOutlet UIButton *ZFBPayBtn;//支付宝支付
@property (weak, nonatomic) IBOutlet UIButton *weChatPayBtn;//微信支付
@property (weak, nonatomic) IBOutlet UIView *backView;//门板view
@property(nonatomic,strong)UIButton * NowSelect_BT;
@property (nonatomic, strong) NSMutableArray *myArray;
@end

@implementation PayView

- (void)awakeFromNib
{
    [super awakeFromNib];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTap)];
    [self.backView addGestureRecognizer:tap];
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObject:self.balancePayBtn];
    [arr addObject:self.ZFBPayBtn];
    [arr addObject:self.weChatPayBtn];
    self.balancePayBtn.selected = YES;
    self.NowSelect_BT = self.balancePayBtn;
    self.myArray = arr;
    
}

- (void)clickTap   // 加手势
{
    [self clickDoorView:NO];
}

//  门板点击事件
- (void)clickDoorView:(BOOL)doAction
{
    
    [UIView animateWithDuration:.25 animations:^{
        [self.bgView setTransform:CGAffineTransformMakeScale(.95, .95)];
        [self setAlpha:0.f];
    } completion:^(BOOL finished) {
        [self.bgView removeFromSuperview];
        self.bgView = nil;
        [self removeFromSuperview];
        if (doAction) {
            if (self.payWayBlock) {
                self.payWayBlock(_NowSelect_BT.tag);
            }
        }
    }];
}

+ (instancetype)loadPayView
{
    return  [[[NSBundle mainBundle] loadNibNamed:@"PayView" owner:self options:nil] lastObject];
}
//选择支付方式（1001余额支付，1002支付宝，1003微信,1000表示什么也没选择）
- (IBAction)selectWayToPay:(UIButton *)sender {
    _NowSelect_BT.selected = NO;
    _NowSelect_BT = sender;
    _NowSelect_BT.selected = YES;

//    [self.myArray enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        
//        
//        if (sender.tag == obj.tag) {
//            sender.selected = !sender.selected;
//        } else {
//            obj.selected = NO;
//        }
//        if (obj.selected) {
//            NSUserDefaults *pay = [NSUserDefaults standardUserDefaults];
//            [pay setInteger:sender.tag forKey:@"payWay"];
//            [pay synchronize];
//        }
//    }];
}

//点击了确定
- (IBAction)selectPayBtn:(UIButton *)sender {
    [self clickDoorView:YES];
}


@end
