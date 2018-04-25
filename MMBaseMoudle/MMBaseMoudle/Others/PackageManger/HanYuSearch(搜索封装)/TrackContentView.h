//
//  TrackContentView.h
//  PYSearchExample
//
//  Created by YunShangCompany on 2017/4/27.
//  Copyright © 2017年 CoderKo1o. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TrackResultBlock) (NSString *searcText);
@interface TrackContentView : UIView
@property (nonatomic, strong) NSString *searcText;
@property (nonatomic, strong) TrackResultBlock trackResultBlock;

@end
