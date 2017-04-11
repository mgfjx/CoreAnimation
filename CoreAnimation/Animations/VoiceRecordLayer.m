//
//  VoiceRecordLayer.m
//  CoreAnimation
//
//  Created by mgfjx on 16/8/4.
//  Copyright © 2016年 xintong. All rights reserved.
//

#import "VoiceRecordLayer.h"
#import <UIKit/UIKit.h>

@interface VoiceRecordLayer (){
    CALayer *backgroundLayer;
    CALayer *circleLayer;
    CAShapeLayer *drawLayer;
    
    CAShapeLayer *voiceLayer;
}

@end

@implementation VoiceRecordLayer

- (instancetype)init{
    self = [super init];
    if (self) {
        
        CALayer *bgLayer = [CALayer layer];
        bgLayer.backgroundColor = [UIColor colorWithWhite:0.200 alpha:0.700].CGColor;
        [self addSublayer:bgLayer];
        backgroundLayer = bgLayer;
        
        UIColor *voiceColor = [UIColor whiteColor];
        
        CALayer *cLayer = [CALayer layer];
        cLayer.borderColor = voiceColor.CGColor;
        cLayer.masksToBounds = YES;
        [bgLayer addSublayer:cLayer];
        circleLayer = cLayer;
        
        CAShapeLayer *dLayer = [CAShapeLayer layer];
        dLayer.lineJoin = kCALineJoinRound;
        dLayer.lineCap = kCALineCapRound;
        dLayer.strokeColor = voiceColor.CGColor;
        dLayer.fillColor = nil;
        [bgLayer addSublayer:dLayer];
        drawLayer = dLayer;
        
        CAShapeLayer *vShapeLayer = [CAShapeLayer layer];
        vShapeLayer.fillColor = voiceColor.CGColor;
        [circleLayer addSublayer:vShapeLayer];
        voiceLayer = vShapeLayer;
        
    }
    return self;
}

- (void)layoutSublayers{
    [super layoutSublayers];
    
    CGFloat mainWidth  = [UIScreen mainScreen].bounds.size.width;
    CGFloat mainHeight = [UIScreen mainScreen].bounds.size.height;
    
    CGFloat bgWidth  = 100;
    CGFloat bgHeight = 100;
    CGFloat bgRadius = 20;
    
    CGFloat clWidth       = 25;
    CGFloat clHeight      = 2 * clWidth;
    CGFloat clBorderWidth = 2;
    
    CGFloat space    = 5;
    CGFloat dRadius  = clWidth/2 + space;
    CGFloat dLength  = 8;
    CGFloat lfLength = 12;
    
    CGFloat drawLineWidth = clBorderWidth + 1;
    
    CGFloat y = (bgHeight - clHeight - space - dLength)/2;
    
    self.frame = CGRectMake(0, 0, mainWidth, mainHeight);
    
    backgroundLayer.frame = CGRectMake((mainWidth - bgWidth)/2, (mainHeight - bgHeight)/2, bgWidth, bgHeight);
    backgroundLayer.cornerRadius = bgRadius;
    
    
    circleLayer.frame = CGRectMake(backgroundLayer.frame.size.width/2 - clWidth/2, y, clWidth, clHeight);
    circleLayer.cornerRadius = circleLayer.bounds.size.width / 2;
    circleLayer.borderWidth = clBorderWidth;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint center = CGPointMake(backgroundLayer.bounds.size.width/2, CGRectGetMaxY(circleLayer.frame) - dRadius + space);
    [path addArcWithCenter:center radius:dRadius startAngle:0.0 endAngle:M_PI clockwise:YES];
    
    CGPoint point1 = CGPointMake(center.x, center.y + dRadius);
    [path moveToPoint:point1];
    CGPoint point2 = CGPointMake(center.x, center.y + dRadius + dLength);
    [path addLineToPoint:point2];
    CGPoint point3 = CGPointMake(point2.x - lfLength, point2.y);
    [path addLineToPoint:point3];
    [path moveToPoint:point2];
    CGPoint point4 = CGPointMake(point2.x + lfLength, point2.y);
    [path addLineToPoint:point4];
    
    drawLayer.lineWidth = drawLineWidth;
    drawLayer.path = path.CGPath;
    
}

- (void)setProgressWithPercent:(CGFloat)percent{
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    CGRect rect = CGRectMake(0, circleLayer.frame.size.height*(1 - percent), circleLayer.frame.size.width, circleLayer.frame.size.height * percent);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:0];
    voiceLayer.path = path.CGPath;
    
    [CATransaction commit];
}

@end



