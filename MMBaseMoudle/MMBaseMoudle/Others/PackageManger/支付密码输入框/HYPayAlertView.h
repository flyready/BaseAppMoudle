//
//  HYPayAlertView.h

NS_ASSUME_NONNULL_BEGIN

@interface HYPayAlertView : UIViewController
@property (nonatomic, strong) NSString *titleStr;
@property (nonatomic, strong) NSString *detail;
@property (nonatomic, assign) CGFloat aMount;

@property (nonatomic, copy) void (^completeHandle)(NSString *inputPwd);
//@property (nonatomic, copy) void (^cancelHandle)(void);

- (void)show;

@end

NS_ASSUME_NONNULL_END
