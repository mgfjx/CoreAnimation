//
//  VideoPlayerView.h
//  CoreAnimation
//
//  Created by 谢小龙 on 16/6/13.
//  Copyright © 2016年 xintong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

typedef void(^VideoSizeBlock)(CGSize videoSize);

@interface VideoPlayerView : UIView

- (instancetype)initWithFrame:(CGRect)frame videoURL:(NSURL *)videoURl;

- (instancetype)initWithFrame:(CGRect)frame videoURL:(NSURL *)videoURl videoSizeBlock:(VideoSizeBlock)videoSizeBlock;

@end
