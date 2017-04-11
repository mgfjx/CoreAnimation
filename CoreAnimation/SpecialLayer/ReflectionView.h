//
//  ReflectionView.h
//  CoreAnimation
//
//  Created by 谢小龙 on 16/6/12.
//  Copyright © 2016年 xintong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReflectionView : UIView

@property (nonatomic, assign) CGFloat reflectionGap;
@property (nonatomic, assign) CGFloat reflectionScale;
@property (nonatomic, assign) CGFloat reflectionAlpha;
@property (nonatomic, assign) BOOL dynamic;

- (void)update;

@end
