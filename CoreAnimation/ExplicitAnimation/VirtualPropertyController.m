//
//  VirtualPropertyController.m
//  CoreAnimation
//
//  Created by mgfjx on 2017/4/13.
//  Copyright © 2017年 xintong. All rights reserved.
//

#import "VirtualPropertyController.h"

@interface VirtualPropertyController ()<CAAnimationDelegate>
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) CALayer *shipLayer;
@end

@implementation VirtualPropertyController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 64 + 10, self.view.width - 2*10, self.view.height - 64 - 2*10)];
    view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:view];
    
    self.containerView = view;
    
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"Run" style:UIBarButtonItemStylePlain target:self action:@selector(clicked)];
    self.navigationItem.rightBarButtonItem = item1;
    
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithTitle:@"Stop" style:UIBarButtonItemStylePlain target:self action:@selector(stopAnimate)];
    self.navigationItem.rightBarButtonItems = @[item1,item2];
    
}

- (void)clicked{
    
    CALayer *shipLayer = [CALayer layer];
    shipLayer.frame = CGRectMake(0, 0, 100, 100);
    shipLayer.position = CGPointMake(self.containerView.width/2, self.containerView.height/2);
    shipLayer.contents = (__bridge id)[UIImage imageNamed:@"2.jpg"].CGImage;
    [self.containerView.layer addSublayer:shipLayer];
    self.shipLayer = shipLayer;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation.duration = 2.0;
//    animation.repeatDuration = INFINITY;
//    animation.autoreverses = YES;
    animation.timeOffset = 1.0;
    animation.repeatCount = CGFLOAT_MAX;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.byValue = @(2*M_PI);
    animation.delegate = self;
    [shipLayer addAnimation:animation forKey:@"rotation"];
    
}

- (void)stopAnimate{
    
    [self.shipLayer removeAnimationForKey:@"rotation"];
    
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSLog(@"animtion finished: %@", flag ? @"YES" : @"NO");
}

@end
