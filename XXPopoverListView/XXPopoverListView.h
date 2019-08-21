//
//  XXPopoverListView.h
//  XXPopoverListView
//
//  Created by Wangyun on 17/2/21.
//  Copyright © 2017年 Wangyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XXPopoverListView;

@protocol XXPopoverListViewDataSourse <NSObject>
@required
- (NSInteger)popoverListView:(XXPopoverListView *)popoverListView numberOfRowsInSection:(NSInteger)section;

- (UITableViewCell *)popoverListView:(XXPopoverListView *)popoverListView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol XXPopoverListViewDelegate <NSObject>
@optional

- (CGFloat)popoverListView:(XXPopoverListView *)popoverListView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)popoverListView:(XXPopoverListView *)popoverListView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)popoverListViewCancel:(XXPopoverListView *)popoverListView;

@end

@interface XXPopoverListView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *listView;
@property (nonatomic, strong) UILabel *titleView;
@property (nonatomic, strong) UIControl *overlayerView;
//@property (nonatomic, assign) CGFloat xwidth;
//@property (nonatomic, assign) CGFloat xheight;

@property (nonatomic, weak) id<XXPopoverListViewDelegate> delegate;
@property (nonatomic, weak) id<XXPopoverListViewDataSourse> dataSourse;

- (void)setTitle:(NSString *)title;
- (void)show;
- (void)dismiss;

@end
