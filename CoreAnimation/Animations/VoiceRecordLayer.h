//
//  VoiceRecordLayer.h
//  CoreAnimation
//
//  Created by mgfjx on 16/8/4.
//  Copyright © 2016年 xintong. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface VoiceRecordLayer : CALayer

/**
 percent	value 0~1.0
 */
- (void)setProgressWithPercent:(CGFloat)percent;

@end
