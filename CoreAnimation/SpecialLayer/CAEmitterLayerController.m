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
#import "CAEmitterController.h"

@interface CAEmitterLayerController (){
    
    UIView *sizeView;
    
}

@property (nonatomic, strong) UIView *containerView;

@end

@implementation CAEmitterLayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.228 green:0.572 blue:0.889 alpha:1.000];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, 20+ 64, 60, 40);
    [btn addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor randomColor];
    [self.view addSubview:btn];
    
}

- (void)test{
    CAEmitterController *vc = [[CAEmitterController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
