//
//  AVAssetViewController.m
//  CoreAnimation
//
//  Created by 谢小龙 on 16/6/16.
//  Copyright © 2016年 xintong. All rights reserved.
//

#import "AVAssetViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface AVAssetViewController ()

@property (nonatomic, strong) AVAsset *asset;

@end

@implementation AVAssetViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSURL *url = [NSURL fileURLWithPath:@"/Users/xiexiaolong1/Desktop/mv.mp4"];
//    NSURL *url = [NSURL URLWithString:@"http://srv33.clipconverter.cc/download/m7O4l4ua0XuwZWpxm5SbbG9p5KWmqWxr4pSXbm9gnmhpbG60qc%2FMqHyf1qiZpa2d2A%3D%3D/NBA%20Newest%20Bloopers%21%20Feb%202016%20%2F%201080p%20FULL%20HD%21%20MUST%20WATCH%21.mp4"];
    
    AVAsset *asset = [AVAsset assetWithURL:url];
    self.asset = asset;
    
    [asset loadValuesAsynchronouslyForKeys:@[@"tracks"] completionHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (asset.playable) {
                [self loadedResourceForPlay];
            }
            
        });
    }];
    
    
}

- (void)loadedResourceForPlay{
    
    NSArray *array = self.asset.tracks;
    
    CGSize videoSize = CGSizeZero;
    
    for (AVAssetTrack *track in array) {
        NSLog(@"mediaType:%@",track.mediaType);
        NSLog(@"naturalSize:%@",NSStringFromCGSize(track.naturalSize));
        
        if ([track.mediaType isEqualToString:AVMediaTypeVideo]) {
            videoSize = track.naturalSize;
        }
        
        if ([track.mediaType isEqualToString:AVMediaTypeAudio]) {
            
            
            
        }
    }
    
    CGFloat videoScale = videoSize.width / videoSize.height;
    
    AVPlayerItem *item = [AVPlayerItem playerItemWithAsset:self.asset];
    
    AVPlayer *player = [AVPlayer playerWithPlayerItem:item];
    
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:player];
    
    CGFloat videoWidth = self.view.bounds.size.width - 20;
    
    layer.frame = CGRectMake(10, 74, videoWidth, videoWidth / videoScale);
    
    NSLog(@"%@",NSStringFromCGRect(layer.frame));
    
    [self.view.layer addSublayer:layer];
    
    [player play];
    
}

@end
