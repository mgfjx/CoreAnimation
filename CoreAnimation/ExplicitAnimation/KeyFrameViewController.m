//
//  KeyFrameViewController.m
//  CoreAnimation
//
//  Created by mgfjx on 2017/4/12.
//  Copyright © 2017年 xintong. All rights reserved.
//

#import "KeyFrameViewController.h"

@interface KeyFrameViewController ()

@property (nonatomic, strong) UIView *containerView;

@end

@implementation KeyFrameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 64 + 10, self.view.width - 2*10, self.view.height - 64 - 2*10)];
    view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:view];
    
    self.containerView = view;
    
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Run" style:UIBarButtonItemStylePlain target:self action:@selector(clicked)];
    self.navigationItem.rightBarButtonItem = item;
    
}

- (void)clicked{
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(10, 64+10*2)];
    [bezierPath addCurveToPoint:CGPointMake(150, 500) controlPoint1:CGPointMake(75, 0) controlPoint2:CGPointMake(225, 300)];
    [bezierPath addCurveToPoint:CGPointMake(300, 64+10*2) controlPoint1:CGPointMake(75, 200) controlPoint2:CGPointMake(225, 100)];
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = bezierPath.CGPath;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 3.0;
    [self.containerView.layer addSublayer:pathLayer];
    
    CALayer *shipLayer = [CALayer layer];
    shipLayer.frame = CGRectMake(0, 0, 64, 64);
    shipLayer.position = CGPointMake(10, 64+10*2);
    shipLayer.contents = (__bridge id)[UIImage imageNamed:@"play"].CGImage;
    [self.containerView.layer addSublayer:shipLayer];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = bezierPath.CGPath;
    animation.duration = 4.0;
//    animation.beginTime = 0.5;
    animation.rotationMode = kCAAnimationRotateAuto;
    animation.repeatCount = CGFLOAT_MAX;
    animation.fillMode = kCAFillModeBoth;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.removedOnCompletion = NO;
    [shipLayer addAnimation:animation forKey:@"animation"];
    
}

@end
