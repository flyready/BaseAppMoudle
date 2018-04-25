//
//  TrackContentView.m
//  PYSearchExample
//
//  Created by YunShangCompany on 2017/4/27.
//  Copyright © 2017年 CoderKo1o. All rights reserved.
//

#import "TrackContentView.h"

@interface TrackContentView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *myTableView;

@end

@implementation TrackContentView
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.bounds];
        tableView.delegate = self;
        tableView.dataSource =self;
        tableView.scrollEnabled = NO;
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"TrackContentCellID"];
        [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self addSubview:tableView];
        self.myTableView = tableView;
    }
    return self;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TrackContentCellID"
                             forIndexPath:indexPath];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:16];
    cell.textLabel.textColor = [UIColor blackColor];
    [cell setWidth:App_Frame_Width];
    cell.selectedBackgroundView = [UIView customBackgroundView];
    //cell.imageView.image = [NSBundle py_imageNamed:@"search_history"];
    cell.textLabel.text = [NSString stringWithFormat:@" 搜索: %@",_searcText];
    [cell addLineUp:NO andDown:YES];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self setHidden:YES];
    if (_trackResultBlock) {
        _trackResultBlock(_searcText);
    }
}

- (void)setSearcText:(NSString *)searcText
{
    if (_searcText != searcText) {
        _searcText = searcText;
    }
    [self.myTableView reloadData];
}

@end
