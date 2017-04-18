//
//  BufferAnimationController.m
//  CoreAnimation
//
//  Created by mgfjx on 2017/4/13.
//  Copyright © 2017年 xintong. All rights reserved.
//

#import "BufferAnimationController.h"

@interface BufferAnimationController ()

@property (nonatomic, strong) UIView *layerView;
@property (nonatomic, strong) CALayer *colorLayer;
@property (nonatomic, strong) UIImageView *ballView;

@end

@implementation BufferAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"scene1" style:UIBarButtonItemStylePlain target:self action:@selector(scene1)];
    
    self.navigationItem.rightBarButtonItems = @[item1];
    
    
}

- (void)scene1{
    CGPoint center = CGPointMake(self.view.width/2, self.view.height/2);
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height)];
    view.backgroundColor = [UIColor lightGrayColor];
    view.center = center;
    [self.view addSubview:view];
    self.layerView = view;
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, 150, 150);
    layer.position = center;
    layer.backgroundColor = [UIColor randomColor].CGColor;
    
    [view.layer addSublayer:layer];
    
    self.colorLayer = layer;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(CGRectGetMinX(layer.frame), CGRectGetMaxY(layer.frame) + 10, 150, 25);
    [btn setTitle:@"Change Color" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor randomColor];
    [btn addTarget:self action:@selector(changeColor) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:btn];
}

- (void)changeColor{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"backgroundColor";
    animation.duration = 2.0;
    animation.values = @[(__bridge id)[UIColor randomColor].CGColor,
                         (__bridge id)[UIColor randomColor].CGColor,
                         (__bridge id)[UIColor randomColor].CGColor,
                         (__bridge id)[UIColor randomColor].CGColor,
                         ];
    CAMediaTimingFunction *tf = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.timingFunctions = @[tf,tf,tf];
    animation.repeatCount = CGFLOAT_MAX;
    [self.colorLayer addAnimation:animation forKey:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [CATransaction begin];
    [CATransaction setAnimationDuration:0.5];
    self.colorLayer.position = [[touches anyObject] locationInView:self.layerView];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [CATransaction commit];
}

@end




















