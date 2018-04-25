//
//  GitHub: https://github.com/iphone5solo/PYSearch
//  Created by CoderKo1o.
//  Copyright © 2016 iphone5solo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PYSearchSuggestionDidSelectCellBlock)(UITableViewCell *selectedCell, id data);

@protocol PYSearchSuggestionViewDataSource <NSObject, UITableViewDataSource>

@required
- (UITableViewCell *)searchSuggestionView:(UITableView *)searchSuggestionView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)searchSuggestionView:(UITableView *)searchSuggestionView numberOfRowsInSection:(NSInteger)section;
@optional
- (NSInteger)numberOfSectionsInSearchSuggestionView:(UITableView *)searchSuggestionView;
- (CGFloat)searchSuggestionView:(UITableView *)searchSuggestionView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

typedef void (^FirstResponderBlock) (void);
@interface PYSearchSuggestionViewController : UITableViewController
@property (nonatomic, strong) FirstResponderBlock firstResponderBlock;
@property (nonatomic, weak) id<PYSearchSuggestionViewDataSource> dataSource;
@property (nonatomic, copy) NSArray<id> *searchSuggestions;
@property (nonatomic, copy) PYSearchSuggestionDidSelectCellBlock didSelectCellBlock;

+ (instancetype)searchSuggestionViewControllerWithDidSelectCellBlock:(PYSearchSuggestionDidSelectCellBlock)didSelectCellBlock;

@end
