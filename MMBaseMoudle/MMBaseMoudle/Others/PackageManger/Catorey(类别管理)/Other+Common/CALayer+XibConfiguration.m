//
//  CALayer+XibConfiguration.m
//  QuickBooks
//
//  Created by Nicholas on 16/12/8.
//  Copyright © 2016年 shijiabao. All rights reserved.
//

#import "CALayer+XibConfiguration.h"

@implementation CALayer (XibConfiguration)
-(void)setBorderUIColor:(UIColor*)color
{
    self.borderColor = color.CGColor;
}

-(UIColor*)borderUIColor
{
    return [UIColor colorWithCGColor:self.borderColor];
}
@end
