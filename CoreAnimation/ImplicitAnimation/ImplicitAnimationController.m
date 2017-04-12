//
//  ImplicitAnimationController.m
//  CoreAnimation
//
//  Created by mgfjx on 2017/4/11.
//  Copyright © 2017年 xintong. All rights reserved.
//

#import "ImplicitAnimationController.h"

@interface ImplicitAnimationController ()

@property (nonatomic, strong) UIView *layerView;
@property (nonatomic, strong) CALayer *colorLayer;

@end

@implementation ImplicitAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    //自定义动画
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    layer.actions = @{@"backgroundColor": transition};
    
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
//    [CATransaction setDisableActions:YES];
    [CATransaction begin];
    [CATransaction setAnimationDuration:1.0];
    [CATransaction setCompletionBlock:^{
        CGAffineTransform transform = self.colorLayer.affineTransform;
        transform = CGAffineTransformRotate(transform, M_PI_4);
//        self.colorLayer.affineTransform = transform;
    }];
    self.colorLayer.backgroundColor = [UIColor randomColor].CGColor;
    [CATransaction commit];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self.view];
    if ([self.colorLayer.presentationLayer hitTest:point]) {
        self.colorLayer.backgroundColor = [UIColor randomColor].CGColor;
    }else{
        [CATransaction begin];
        [CATransaction setAnimationDuration:4.0];
        self.colorLayer.position = point;
        [CATransaction commit];
    }
}

@end








