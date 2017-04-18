//
//  MainViewController.m
//  CoreAnimation
//
//  Created by mgfjx on 2017/4/10.
//  Copyright © 2017年 xintong. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()<UITableViewDelegate, UITableViewDataSource>{
    NSDictionary *titleVCDict;
}


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"CoreAnimation";
    
    titleVCDict = @{
                    @"专用图层":@"AnimationsViewController",
                    @"隐式动画":@"ImplicitAnimationController",
                    @"显式动画":@"ExplicitAnimationController",
                    @"高效绘图":@"EfficientGraphicController",
                    @"图像IO":@"LoadAndLatentController",
                    };
    
    UITableView *table = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    
}

#pragma mark - UITableViewDelegate and UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return titleVCDict.allKeys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = titleVCDict.allKeys[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self jumpToViewController:titleVCDict.allValues[indexPath.row]];
}

- (void)jumpToViewController:(NSString *)VCName{
    UIViewController *vc = [[NSClassFromString(VCName) alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
