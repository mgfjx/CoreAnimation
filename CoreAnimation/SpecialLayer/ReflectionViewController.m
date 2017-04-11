//
//  ReflectionViewController.m
//  CoreAnimation
//
//  Created by 谢小龙 on 16/6/12.
//  Copyright © 2016年 xintong. All rights reserved.
//

#import "ReflectionViewController.h"
#import "ReflectionView.h"

@interface ReflectionViewController ()

@property (nonatomic, strong) ReflectionView *reflectionView;

@end

@implementation ReflectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat btnWidth = (self.view.width - 5*10)/4;
    CGFloat btnHeight = 30;
    
    UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectMake(10, 64 + 10, btnWidth, btnHeight)];
    [switchView addTarget:self action:@selector(toggleDynamic:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:switchView];
    
    {
        UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(switchView.frame) + 10, 200, 30)];
        [slider addTarget:self action:@selector(updateAlpha:) forControlEvents:UIControlEventValueChanged];
        slider.maximumValue = 1.0;
        slider.minimumValue = 0.0;
        slider.value = 0.5;
        [self.view addSubview:slider];
    }
    
    {
        UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(switchView.frame) + 50, 200, 30)];
        [slider addTarget:self action:@selector(updateGap:) forControlEvents:UIControlEventValueChanged];
        slider.maximumValue = 10.0;
        slider.minimumValue = 0.0;
        slider.value = 4;
        [self.view addSubview:slider];
    }
    
    {
        UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(switchView.frame) + 50*2, 200, 30)];
        [slider addTarget:self action:@selector(updateScale:) forControlEvents:UIControlEventValueChanged];
        slider.maximumValue = 1.0;
        slider.minimumValue = 0.0;
        slider.value = 0.5;
        [self.view addSubview:slider];
    }
    
    ReflectionView *view = [[ReflectionView alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
    view.center = CGPointMake(self.view.width/2, self.view.height/2);
    view.backgroundColor = [UIColor randomColor];
    [self.view addSubview:view];
    self.reflectionView = view;
    
}

- (void)toggleDynamic:(UISwitch *)sender
{
    self.reflectionView.dynamic = sender.on;
}

- (void)updateAlpha:(UISlider *)slider
{
    self.reflectionView.reflectionAlpha = slider.value;
}

- (void)updateGap:(UISlider *)slider
{
    self.reflectionView.reflectionGap = slider.value;
}

- (void)updateScale:(UISlider *)slider
{
    self.reflectionView.reflectionScale = slider.value;
}


@end
