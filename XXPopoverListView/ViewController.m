//
//  ViewController.m
//  XXPopoverListView
//
//  Created by Wangyun on 17/2/21.
//  Copyright © 2017年 Wangyun. All rights reserved.
//

#import "ViewController.h"
#import "XXPopoverListView.h"

@interface ViewController ()<XXPopoverListViewDelegate,XXPopoverListViewDataSourse>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *popItem = [[UIBarButtonItem alloc] initWithTitle:@"搜索" style:UIBarButtonItemStylePlain target:self action:@selector(popShow)];
    self.navigationItem.rightBarButtonItem = popItem;
    [self popShow];
}

- (void)popShow{
    XXPopoverListView *poplistview = [[XXPopoverListView alloc] initWithFrame:CGRectMake(100, 100, 200, 300)];
//    poplistview.xwidth = 200;
//    poplistview.xheight = 200;
    [poplistview.listView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    poplistview.delegate = self;
    poplistview.dataSourse = self;
    [poplistview setTitle:@"XX列表"];
    [poplistview show];
}

- (NSInteger)popoverListView:(XXPopoverListView *)popoverListView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)popoverListView:(XXPopoverListView *)popoverListView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [popoverListView.listView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if(indexPath.row == 0){
        cell.textLabel.text = @"XXFirst";
    }else if (indexPath.row == 1){
        cell.textLabel.text = @"XXSecond";
    }else {
        cell.textLabel.text = @"XXNext";
    }
    return  cell;
}

- (CGFloat)popoverListView:(XXPopoverListView *)popoverListView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)popoverListView:(XXPopoverListView *)popoverListView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)popoverListViewCancel:(XXPopoverListView *)popoverListView{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
