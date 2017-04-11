//
//  CAGradientLayerController.m
//  CoreAnimation
//
//  Created by mgfjx on 2017/4/11.
//  Copyright © 2017年 xintong. All rights reserved.
//

#import "CAGradientLayerController.h"
#import "TransformViewController.h"
#import <CoreText/CoreText.h>
#import "ReflectionViewController.h"
#import "ReflectionView.h"

@interface CAGradientLayerController (){
    
    UIView *sizeView;
    
}

@property (nonatomic, strong) UIView *containerView;

@end

@implementation CAGradientLayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *view = [[UIView alloc] init];
    //    view.frame = CGRectMake(10, 64, self.view.bounds.size.width - 20, self.view.bounds.size.height - 64);
    view.frame = CGRectMake(10, 64, 100, 100);
    [self.view addSubview:view];
    
    self.containerView = view;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(120, 300, 80, 50);
    btn.backgroundColor = [UIColor brownColor];
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
}

- (void)btnClicked:(UIButton *)sender {
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.containerView.bounds;
    [self.containerView.layer addSublayer:gradientLayer];
    
    //set gradient colors
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id) [UIColor yellowColor].CGColor, (__bridge id)[UIColor greenColor].CGColor];
    
    //set locations
    gradientLayer.locations = @[@0.0, @0.25, @0.5];
    
    //set gradient start and end points
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    
}

@end
