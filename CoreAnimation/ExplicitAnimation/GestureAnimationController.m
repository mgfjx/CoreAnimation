//
//  GestureAnimationController.m
//  CoreAnimation
//
//  Created by mgfjx on 2017/4/13.
//  Copyright © 2017年 xintong. All rights reserved.
//

#import "GestureAnimationController.h"

@interface GestureAnimationController ()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) CALayer *doorLayer;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation GestureAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 64 + 10, self.view.width - 2*10, self.view.height - 64 - 2*10)];
    view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:view];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    imageView.center = CGPointMake(view.width/2, view.height/2);
    imageView.image = [UIImage imageNamed:@"2.jpg"];
    imageView.userInteractionEnabled = YES;
    imageView.layer.anchorPoint = CGPointMake(0, 0.5);
    [view addSubview:imageView];
    self.imageView = imageView;
    
    self.containerView = view;
    
    self.doorLayer = [CALayer layer];
    self.doorLayer.frame = CGRectMake(0, 0, view.width - 20, view.height - 20);
    self.doorLayer.position = CGPointMake(10, view.height/2);
    self.doorLayer.anchorPoint = CGPointMake(0, 0.5);
    self.doorLayer.contents = (__bridge id)[UIImage imageNamed:@"launchImage"].CGImage;
    [self.containerView.layer addSublayer:self.doorLayer];
    //apply perspective transform
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0 / 500.0;
    self.containerView.layer.sublayerTransform = perspective;
    //add pan gesture recognizer to handle swipes
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] init];
    [pan addTarget:self action:@selector(pan:)];
    [view addGestureRecognizer:pan];
    //pause all layer animations
    self.doorLayer.speed = 0.0;
    //apply swinging animation (which won't play because layer is paused)
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation.y";
    animation.toValue = @(-M_PI_2);
    animation.duration = 1.0;
    [self.doorLayer addAnimation:animation forKey:nil];
    
    
    self.imageView.layer.speed =0;
    self.imageView.layer.sublayerTransform = perspective;
    [self.imageView.layer addAnimation:animation forKey:nil];
    UIPanGestureRecognizer *pan2 = [[UIPanGestureRecognizer alloc] init];
    [pan2 addTarget:self action:@selector(pan2:)];
    [view addGestureRecognizer:pan2];
    [self.imageView addGestureRecognizer:pan2];
}


- (void)pan:(UIPanGestureRecognizer *)pan
{
    //get horizontal component of pan gesture
    CGFloat x = [pan translationInView:self.containerView].x;
    //convert from points to animation duration //using a reasonable scale factor
    x /= 200.0f;
    //update timeOffset and clamp result
    CFTimeInterval timeOffset = self.doorLayer.timeOffset;
    timeOffset = MIN(0.999, MAX(0.0, timeOffset - x));
    self.doorLayer.timeOffset = timeOffset;
    
    //reset pan gesture
    [pan setTranslation:CGPointZero inView:self.containerView];
}

- (void)pan2:(UIPanGestureRecognizer *)pan
{
    //get horizontal component of pan gesture
    CGFloat x = [pan translationInView:self.containerView].x;
    //convert from points to animation duration //using a reasonable scale factor
    x /= 200.0f;
    //update timeOffset and clamp result
    
    CFTimeInterval imgTimeOffset = self.imageView.layer.timeOffset;
    imgTimeOffset = MIN(0.999, MAX(0.0, imgTimeOffset - x));
    self.imageView.layer.timeOffset = imgTimeOffset;
    
    //reset pan gesture
    [pan setTranslation:CGPointZero inView:self.containerView];
}

@end
