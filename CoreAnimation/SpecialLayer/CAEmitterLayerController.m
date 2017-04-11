//
//  CAEmitterLayerController.m
//  CoreAnimation
//
//  Created by mgfjx on 2017/4/11.
//  Copyright © 2017年 xintong. All rights reserved.
//

#import "CAEmitterLayerController.h"
#import "TransformViewController.h"
#import <CoreText/CoreText.h>
#import <AVFoundation/AVFoundation.h>
#import "VideoPlayerView.h"

@interface CAEmitterLayerController (){
    
    UIView *sizeView;
    
}

@property (nonatomic, strong) UIView *containerView;

@end

@implementation CAEmitterLayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor lightGrayColor];
    view.frame = CGRectMake(10, 100, 200, 150);
    [self.view addSubview:view];
    
    self.containerView = view;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(120, 300, 80, 50);
    btn.backgroundColor = [UIColor brownColor];
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
}

- (void)btnClicked:(UIButton *)sender {
    //create particle emitter layer
    CAEmitterLayer *emitter = [CAEmitterLayer layer];
    emitter.frame = self.containerView.bounds;
    [self.containerView.layer addSublayer:emitter];
    
    //configure emitter
    emitter.renderMode = kCAEmitterLayerOldestFirst;
    emitter.emitterPosition = CGPointMake(emitter.frame.size.width / 2.0, emitter.frame.size.height / 2.0);
    
    //create a particle template
    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    cell.contents = (__bridge id)[UIImage imageNamed:@"f"].CGImage;
    cell.birthRate = 300;
    cell.lifetime = 2.0;
    cell.color = [UIColor colorWithRed:0.932 green:0.339 blue:0.077 alpha:1.000].CGColor;
    cell.alphaSpeed = -0.4;
    cell.velocity = 50;
    cell.velocityRange = 50;
    cell.emissionRange = M_PI * 2.0;
    
    //add particle template to emitter
    emitter.emitterCells = @[cell];
    
}

@end
