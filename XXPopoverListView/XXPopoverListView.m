//
//  XXPopoverListView.m
//  XXPopoverListView
//
//  Created by Wangyun on 17/2/21.
//  Copyright © 2017年 Wangyun. All rights reserved.
//

#import "XXPopoverListView.h"
#import <QuartzCore/QuartzCore.h>

#define XXWidth self.frame.size.width
#define XXHeight self.frame.size.height

@implementation XXPopoverListView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = true;
        [self shareInit];
    }
    return self;
}

- (void)shareInit{
    self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.layer.borderWidth = 1.0f;
    self.layer.cornerRadius = 10.0f;
    self.clipsToBounds = YES;
    [self addSubview:self.titleView];
    [self addSubview:self.listView];
}

- (UILabel *)titleView{
    if (!_titleView) {
        _titleView = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleView.font = [UIFont systemFontOfSize:17.0];
        _titleView.backgroundColor = [UIColor redColor];
        _titleView.textAlignment = NSTextAlignmentCenter;
        _titleView.textColor = [UIColor whiteColor];
        _titleView.lineBreakMode = NSLineBreakByTruncatingTail;
        _titleView.frame = CGRectMake(0, 0, XXWidth, 32.0);
    }
    return _titleView;
}

- (UITableView *)listView{
    if (!_listView) {
        _listView = [[UITableView alloc] initWithFrame:CGRectMake(0, 32.0, XXWidth, XXHeight-32.0) style:UITableViewStylePlain];
        _listView.scrollEnabled = true;
        _listView.delegate = self;
        _listView.dataSource = self;
    }
    return _listView;
}
//
//- (void)setWidth:(CGFloat)xwidth{
//    CGRect frame = _listView.frame;
//    frame.size.width = xwidth;
//    _listView.frame = frame;
//}
//
//- (void)setHeight:(CGFloat)xheight{
//    CGRect frame = _listView.frame;
//    frame.size.height = xheight;
//    _listView.frame = frame;
//}

- (UIControl *)overlayerView{
    if (!_overlayerView) {
        _overlayerView = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _overlayerView.backgroundColor = [UIColor cyanColor];
        [_overlayerView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        _overlayerView.userInteractionEnabled = true;
    }
    return _overlayerView;
}

#pragma mark - UITableViewDataSourse

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.dataSourse && [self.dataSourse respondsToSelector:@selector(popoverListView:numberOfRowsInSection:)]) {
        return [self.dataSourse popoverListView:self numberOfRowsInSection:section];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataSourse && [self.dataSourse respondsToSelector:@selector(popoverListView:cellForRowAtIndexPath:)]) {
        return [self.dataSourse popoverListView:self cellForRowAtIndexPath:indexPath];
    }
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.delegate && [self.delegate respondsToSelector:@selector(popoverListView:heightForRowAtIndexPath:)]) {
        return [self.delegate popoverListView:self heightForRowAtIndexPath:indexPath];
    }
    return 0.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.delegate && [self.delegate respondsToSelector:@selector(popoverListView:didSelectRowAtIndexPath:)]) {
        [self.delegate popoverListView:self didSelectRowAtIndexPath:indexPath];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.delegate && [self.delegate respondsToSelector:@selector(popoverListViewCancel:)]) {
        [self.delegate popoverListViewCancel:self];
    }
    [self dismiss];
}

- (void)setTitle:(NSString *)title{
    _titleView.text = title;
}

- (void)show{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview:self.overlayerView];
    [keyWindow addSubview:self];
    self.center = CGPointMake(keyWindow.bounds.size.width/2, keyWindow.bounds.size.height/2);
    [self transitionPresent];
}

- (void)dismiss{
    [self transitionDismiss];
}

#pragma mark - animations

- (void)transitionPresent{
    self.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)transitionDismiss{
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self.overlayerView removeFromSuperview];
        [self removeFromSuperview];
    }];
}


@end
