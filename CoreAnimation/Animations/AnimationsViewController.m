//
//  AnimationsViewController.m
//  CoreAnimation
//
//  Created by mgfjx on 2017/4/11.
//  Copyright © 2017年 xintong. All rights reserved.
//

#import "AnimationsViewController.h"
#import "TransformViewController.h"
#import "VoiceRecordLayer.h"

@interface AnimationsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSDictionary *controllerDict;

@end

@implementation AnimationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.controllerDict = @{@"录音动画":@"VoiceRecordViewController",
                            @"CATextLayer":@"CATextLayerController",
                            @"AVAssetView":@"AVAssetViewController",
                            @"AVPlayerLayer":@"AVPlayerLayerController",
                            @"CAEmitterLayer":@"CAEmitterLayerController",
                            @"CAGradientLayer":@"CAGradientLayerController",
                            @"ReflectionView":@"ReflectionViewController",
                            };
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView *table = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    self.tableView = table;
    
}

#pragma mark - UITableViewDelegate and UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.controllerDict.allKeys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.controllerDict.allKeys[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSArray *keys = self.controllerDict.allKeys;
    [self pushControlllerWithName:self.controllerDict[keys[indexPath.row]]];
}

- (void)pushControlllerWithName:(NSString *)controllerName{
    UIViewController *vc = [[NSClassFromString(controllerName) alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
