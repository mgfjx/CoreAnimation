//
//  VideoPlayerView.m
//  CoreAnimation
//
//  Created by 谢小龙 on 16/6/13.
//  Copyright © 2016年 xintong. All rights reserved.
//

#import "VideoPlayerView.h"

@interface VideoPlayerView(){
    
    BOOL isControlViewShow;
    CGFloat contentOffsetX;
    CGFloat contentOffsetY;
    
    VideoSizeBlock callBack;
    
    UIButton *playBtn;
    UIProgressView *progressView;
    
    UISlider *slider;
    
}

@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (nonatomic, strong) UIView *controlView;
@property (nonatomic, strong) AVAsset *asset;
@property (nonatomic, strong) AVPlayerItem *item;

@end

@implementation VideoPlayerView

static CGFloat controlView_heightScale = 0.15;

- (instancetype)initWithFrame:(CGRect)frame videoURL:(NSURL *)videoURl{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        isControlViewShow = YES;
        
        self.clipsToBounds = YES;
        
        AVAsset *asset = [AVAsset assetWithURL:videoURl];
        
        self.asset = asset;
        
        UIActivityIndicatorView *indicate = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        indicate.frame = self.bounds;
        [self addSubview:indicate];
        
        [indicate startAnimating];
        
        [asset loadValuesAsynchronouslyForKeys:@[@"tracks"] completionHandler:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                if (asset.playable) {
                    [self loadedResourceForPlay];
                    [indicate stopAnimating];
                }
            });
        }];
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame videoURL:(NSURL *)videoURl videoSizeBlock:(VideoSizeBlock)videoSizeBlock{
    self = [super initWithFrame:frame];
    if (self) {
        
        isControlViewShow = YES;
        
        self.clipsToBounds = YES;
        
        AVAsset *asset = [AVAsset assetWithURL:videoURl];
        
        self.asset = asset;
        
        [asset loadValuesAsynchronouslyForKeys:@[@"tracks"] completionHandler:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                if (asset.playable) {
                    NSArray *array = self.asset.tracks;
                    for (AVAssetTrack *track in array) {
                        if ([track.mediaType isEqualToString:AVMediaTypeVideo]) {
                            videoSizeBlock(track.naturalSize);
                        }
                    }
                    [self loadedResourceForPlay];
                }
            });
        }];
        
    }
    return self;
}

#pragma mark - AVAsset loaded method
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
    
    AVPlayerItem *item = [AVPlayerItem playerItemWithAsset:self.asset];
    
    AVPlayer *player = [AVPlayer playerWithPlayerItem:item];
    
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:player];
    
    NSLog(@"%@",NSStringFromCGRect(layer.frame));
    
    [self.layer addSublayer:layer];
    
    self.playerLayer = layer;
    self.player = player;
    self.item = item;
    
    [item addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    
    [self initViews];

    
}

- (void)dealloc{
    [self.item removeObserver:self forKeyPath:@"loadedTimeRanges" context:nil];
}

- (void)initViews{
    
    //initControl views
    
    CGFloat controlView_height = self.frame.size.height * controlView_heightScale;
    
    UIView *controlView = [[UIView alloc] init];
    controlView.backgroundColor = [UIColor colorWithRed:0.990 green:0.996 blue:0.990 alpha:0.35];
//    controlView.frame = CGRectMake(0, self.frame.size.height - controlView_height, self.frame.size.width, controlView_height);
    [self addSubview:controlView];
    self.controlView = controlView;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(5, 0, controlView_height, controlView_height);
    [button setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(playAndPause:) forControlEvents:UIControlEventTouchUpInside];
    [controlView addSubview:button];
    playBtn = button;
    
    UIProgressView *progress = [[UIProgressView alloc] init];
    [controlView addSubview:progress];
    progressView = progress;
    
    UISlider *sliderView = [[UISlider alloc] init];
    [_controlView addSubview:sliderView];
    [sliderView setThumbImage:[UIImage imageNamed:@"slider"] forState:UIControlStateNormal];
    sliderView.minimumTrackTintColor = [UIColor clearColor];
    sliderView.maximumTrackTintColor = [UIColor clearColor];
    [sliderView addTarget:self action:@selector(progressSlider:) forControlEvents:UIControlEventValueChanged];
    slider = sliderView;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToShowControlView:)];
    [self addGestureRecognizer:tap];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandle:)];
    [self addGestureRecognizer:pan];
    
}

#pragma mark - slider滑动事件
- (void)progressSlider:(UISlider *)sliderView
{
    //拖动改变视频播放进度
    if (_player.status == AVPlayerStatusReadyToPlay) {
        
        //    //计算出拖动的当前秒数
        CGFloat total = (CGFloat)self.player.currentItem.duration.value / self.player.currentItem.duration.timescale;
        
        //    NSLog(@"%f", total);
        
        NSInteger dragedSeconds = floorf(total * sliderView.value);
        
        //    NSLog(@"dragedSeconds:%ld",dragedSeconds);
        
        //转换成CMTime才能给player来控制播放进度
        
        CMTime dragedCMTime = CMTimeMake(dragedSeconds, 1);
        
        [_player pause];
        
        [_player seekToTime:dragedCMTime completionHandler:^(BOOL finish){
            
            [_player play];
            
        }];
        
    }
}

#pragma mark - 布局当前view及子view
- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat controlView_height = self.frame.size.height * controlView_heightScale;
    
    self.playerLayer.frame = self.bounds;
    
    self.playerLayer.frame = self.bounds;
    _controlView.frame = CGRectMake(0, self.frame.size.height - controlView_height, self.frame.size.width, controlView_height);
    
    playBtn.frame = CGRectMake(5, 0, controlView_height, controlView_height);
    progressView.frame = CGRectMake(CGRectGetMaxX(playBtn.frame) + 10, 0, self.bounds.size.width - CGRectGetMaxX(playBtn.frame) - 20, 10);
    NSLog(@"%@",NSStringFromCGRect(progressView.frame));
    progressView.center = CGPointMake(progressView.center.x, CGRectGetMidY(_controlView.bounds));
    
    slider.frame = CGRectMake(progressView.frame.origin.x, 0, progressView.frame.size.width, 10);
    slider.center = CGPointMake(slider.center.x, CGRectGetMidY(_controlView.bounds));
    
}

#pragma mark - controlView event
- (void)playAndPause:(UIButton *)sender{
    
    if (!self.asset.isPlayable) {
        return;
    }
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self.player play];
    }else{
        [self.player pause];
    }
}

#pragma mark - UIGestureRecognizer method
- (void)tapToShowControlView:(UITapGestureRecognizer *)tap{
    CGPoint point = [tap locationInView:self];
    if (!CGRectContainsPoint(_controlView.frame, point)) {
        CGFloat controlView_height = self.frame.size.height * controlView_heightScale;
        
        CGRect controlViewFrame = self.controlView.frame;
        controlViewFrame.origin.y = controlViewFrame.origin.y + controlView_height * (isControlViewShow ? 1 : -1);
        
        [UIView animateWithDuration:0.25 animations:^{
            
            self.controlView.frame = controlViewFrame;
            
        }];
        
        isControlViewShow = !isControlViewShow;
    }
}

- (void)panHandle:(UIPanGestureRecognizer *)pan{
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        CGPoint origin = [pan locationInView:pan.view];
        
        contentOffsetX = origin.x;
        contentOffsetY = origin.y;
    }
    
    if (pan.state == UIGestureRecognizerStateChanged) {
        CGPoint point = [pan locationInView:self.superview];
        CGRect frame = pan.view.frame;
        frame.origin = CGPointMake(point.x - contentOffsetX, point.y - contentOffsetY);
        pan.view.frame = frame;
    }
    
    
}


#pragma mark - KVO 
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        
        NSTimeInterval timeInterval = [self availableDuration];
        CMTime duration = [_player.currentItem duration];
        CGFloat totalDuration = CMTimeGetSeconds(duration);
        
        [progressView setProgress:timeInterval / totalDuration animated:NO];
    }
    
}

//缓存进度计算
- (NSTimeInterval)availableDuration{
    
    NSArray *loadedTimeRanges = [[_player currentItem] loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result = startSeconds + durationSeconds;
    
    return result;
}


@end
