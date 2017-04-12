//
//  ExplicitAnimationController.m
//  CoreAnimation
//
//  Created by mgfjx on 2017/4/12.
//  Copyright © 2017年 xintong. All rights reserved.
//

#import "ExplicitAnimationController.h"

@interface ExplicitAnimationController ()<CAAnimationDelegate>

@property (nonatomic, strong) UIView *layerView;
@property (nonatomic, strong) CALayer *colorLayer;

@end

@implementation ExplicitAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    titleVCDict = @{
                    @"时钟":@"ClockViewController",
                    @"KeyFrameAnimation":@"KeyFrameViewController",
                    };
    
}

@end














