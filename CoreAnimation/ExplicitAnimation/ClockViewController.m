//
//  ClockViewController.m
//  CoreAnimation
//
//  Created by mgfjx on 2017/4/12.
//  Copyright © 2017年 xintong. All rights reserved.
//

#import "ClockViewController.h"

@interface ClockViewController ()<CAAnimationDelegate>

@property (nonatomic, strong) UIImageView *clockHand;
@property (nonatomic, strong) UIImageView *hourHand;
@property (nonatomic, strong) UIImageView *minuteHand;
@property (nonatomic, strong) UIImageView *secondHand;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ClockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGPoint center = CGPointMake(self.view.width/2, self.view.height/2);
    
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        imageView.center = center;
        imageView.image = [UIImage imageNamed:@"main"];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:imageView];
        self.clockHand = imageView;
    }
    
    CGPoint archorPoint = CGPointMake(0.5, 0.85);
    
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 15, 40)];
        imageView.center = center;
        imageView.image = [UIImage imageNamed:@"hour"];
        imageView.layer.anchorPoint = archorPoint;
        [self.view addSubview:imageView];
        self.hourHand = imageView;
    }
    
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 70)];
        imageView.center = center;
        imageView.image = [UIImage imageNamed:@"min"];
        imageView.layer.anchorPoint = archorPoint;
        [self.view addSubview:imageView];
        self.minuteHand = imageView;
    }
    
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 5, 100)];
        imageView.center = center;
        imageView.image = [UIImage imageNamed:@"sec"];
        imageView.layer.anchorPoint = archorPoint;
        [self.view addSubview:imageView];
        self.secondHand = imageView;
    }
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    [self updateHandsAnimated:NO];
}

- (void)tick{
    [self updateHandsAnimated:YES];
    NSLog(@"1");
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.timer invalidate];
}

- (void)updateHandsAnimated:(BOOL)animated{
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger units = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *components = [calendar components:units fromDate:[NSDate date]];
    CGFloat hourAngle = (components.hour / 12.0) * M_PI * 2;
    CGFloat minuteAngle = (components.minute / 60.0) * M_PI * 2;
    CGFloat secondAngle = (components.second / 60.0) * M_PI * 2;
    
    [self setAngle:hourAngle forHand:self.hourHand animated:animated];
    [self setAngle:minuteAngle forHand:self.minuteHand animated:animated];
    [self setAngle:secondAngle forHand:self.secondHand animated:animated];
}

- (void)setAngle:(CGFloat)angle forHand:(UIView *)handView animated:(BOOL)animated{
    CATransform3D transform = CATransform3DMakeRotation(angle, 0, 0, 1);
    if (animated) {
        CABasicAnimation *animation = [CABasicAnimation animation];
        [self updateHandsAnimated:NO];
//        animation.fillMode = @"forwards";
        animation.keyPath = @"transform";
        animation.toValue = [NSValue valueWithCATransform3D:transform];
        animation.duration = 0.5;
        animation.delegate = self;
        //添加自定义缓冲
        animation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:1 :0 :0.75 :1];
        [animation setValue:handView forKey:@"handView"];
        [handView.layer addAnimation:animation forKey:nil];
    }else{
        handView.layer.transform = transform;
    }
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag{
    UIView *handView = [anim valueForKey:@"handView"];
    handView.layer.transform = [anim.toValue CATransform3DValue];
}

@end




















