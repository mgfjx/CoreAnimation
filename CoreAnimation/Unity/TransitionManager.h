//
//  TransitionManager.h
//  Unity
//
//  Created by mgfjx on 2016/12/12.
//  Copyright © 2016年 XXL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^GestureConifg)();

typedef NS_ENUM(NSInteger, TransitionType) {
    TransitionTypePresent,
    TransitionTypeDismiss,
    TransitionTypePush,
    TransitionTypePop
};

typedef NS_ENUM(NSInteger, TransitionGestureDirection) {
    TransitionGestureDirectionLeft,
    TransitionGestureDirectionRight,
    TransitionGestureDirectionUp,
    TransitionGestureDirectionDown
};

@interface TransitionManager : NSObject<UIViewControllerAnimatedTransitioning>

+ (instancetype)transitionWithTransitionType:(TransitionType)type forController:(UIViewController *)controller;
- (instancetype)initWithTransitionType:(TransitionType)type forController:(UIViewController *)controller;

@end

#pragma mark - 手势驱动类
@interface InteractiveTransition : UIPercentDrivenInteractiveTransition

@property (nonatomic, assign) BOOL isInteractionBegin;//标记手势驱动是否开始

/**促发手势present的时候的config，config中初始化并present需要弹出的控制器*/
@property (nonatomic, copy) GestureConifg presentConifg;
/**促发手势push的时候的config，config中初始化并push需要弹出的控制器*/
@property (nonatomic, copy) GestureConifg pushConifg;


+ (instancetype)interactiveTransitionWithTransitionType:(TransitionType)type GestureDirection:(TransitionGestureDirection)direction;
- (instancetype)initWithTransitionType:(TransitionType)type GestureDirection:(TransitionGestureDirection)direction;

- (void)addPanGestureForViewController:(UIViewController *)viewController;

@end
