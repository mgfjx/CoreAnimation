//
//  VoiceRecordViewController.m
//  CoreAnimation
//
//  Created by mgfjx on 16/8/19.
//  Copyright © 2016年 xintong. All rights reserved.
//

#import "VoiceRecordViewController.h"
#import "VoiceRecordLayer.h"

@interface VoiceRecordViewController (){
    NSTimer *timer;
}

@property (nonatomic, strong) VoiceRecordLayer *voiceLayer;

@end

@implementation VoiceRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(120, 300, 80, 50);
    btn.backgroundColor = [UIColor brownColor];
    [btn setTitle:@"按住不放" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnTouchIn) forControlEvents:UIControlEventTouchDown];
    [btn addTarget:self action:@selector(btnTouchOut) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
    
    [self.view addSubview:btn];
    
}

- (void)btnTouchIn{
    if (_voiceLayer) {
        return;
    }
    VoiceRecordLayer *layer = [VoiceRecordLayer layer];
    [self.view.layer addSublayer:layer];
    _voiceLayer = layer;
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(btnClicked:) userInfo:nil repeats:YES];
    
}

- (void)btnTouchOut{
    
    [timer invalidate];
    [_voiceLayer removeFromSuperlayer];
    _voiceLayer = nil;
    
}

- (void)btnClicked:(UIButton *)sender {
    
    NSInteger r = random()%100;
    [_voiceLayer setProgressWithPercent:(CGFloat)r/100.0];
    
}

@end
