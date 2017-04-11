//
//  AVPlayerLayerController.m
//  CoreAnimation
//
//  Created by mgfjx on 2017/4/11.
//  Copyright © 2017年 xintong. All rights reserved.
//AVPlayerLayerController

#import "AVPlayerLayerController.h"
#import "TransformViewController.h"
#import <CoreText/CoreText.h>
#import <AVFoundation/AVFoundation.h>
#import "VideoPlayerView.h"

@interface AVPlayerLayerController ()

@property (nonatomic, strong) VideoPlayerView *videoView;

@end

@implementation AVPlayerLayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(120, 300, 80, 50);
    btn.backgroundColor = [UIColor brownColor];
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
}

- (void)btnClicked:(UIButton *)sender {
    
    NSString *path = @"http://112.33.2.60:8082/mediamp4/6dbb3632-de68-4ba5-9775-0a3a60ba36ee=/480x240_1000k.mp4";
    NSURL *url = [NSURL URLWithString:path];
    
    //    NSURL *url = [[NSBundle mainBundle] URLForResource:@"m" withExtension:@"mp4"];
    //    NSURL *url = [NSURL fileURLWithPath:@"/Users/xiexiaolong1/Desktop/mv.mp4"];
    
    CGRect videoFrame = CGRectMake(10, 74, self.view.bounds.size.width - 20, 200);
    
    VideoPlayerView *videoView = [[VideoPlayerView alloc] initWithFrame:CGRectZero videoURL:url videoSizeBlock:^(CGSize videoSize) {
        
        CGFloat baseWidth = videoSize.width > videoSize.height ? videoFrame.size.width : videoFrame.size.height;
        
        self.videoView.frame = CGRectMake(10, 74, baseWidth, baseWidth / (videoSize.width / videoSize.height));
        
    }];
    [self.view addSubview:videoView];
    self.videoView = videoView;
    
}

@end
