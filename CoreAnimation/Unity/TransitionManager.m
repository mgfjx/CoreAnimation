//
//  TransitionManager.m
//  Unity
//
//  Created by mgfjx on 2016/12/12.
//  Copyright © 2016年 XXL. All rights reserved.
//

#import "TransitionManager.h"

#define TRANSITIONDURATION 0.5

@interface TransitionManager ()

@property (nonatomic, assign) TransitionType type;

@end

@implementation TransitionManager

+ (instancetype)transitionWithTransitionType:(TransitionType)type forController:(UIViewController *)controller{
    return [[TransitionManager alloc] initWithTransitionType:type forController:controller];
}

- (instancetype)initWithTransitionType:(TransitionType)type forController:(UIViewController *)controller{
    self = [super init];
    if (self) {
        self.type = type;
    }
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return TRANSITIONDURATION;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    switch (_type) {
        case TransitionTypePresent:
            [self presentAnimation:transitionContext];
            break;
        case TransitionTypeDismiss:
            [self dismissAnimation:transitionContext];
            break;
        case TransitionTypePush:
            [self pushAnimation:transitionContext];
            break;
        case TransitionTypePop:
            [self popAnimation:transitionContext];
            break;
            
        default:
            break;
    }
}


#pragma mark - 各种跳转动画处理
- (void)presentAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    //通过viewControllerForKey取出转场前后的两个控制器，这里toVC就是vc1、fromVC就是vc2
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //snapshotViewAfterScreenUpdates可以对某个视图截图，我们采用对这个截图做动画代替直接对vc1做动画，因为在手势过渡中直接使用vc1动画会和手势有冲突，    如果不需要实现手势的话，就可以不是用截图视图了，大家可以自行尝试一下
    UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    tempView.frame = fromVC.view.frame;
    //因为对截图做动画，vc1就可以隐藏了
    fromVC.view.hidden = YES;
    //这里有个重要的概念containerView，如果要对视图做转场动画，视图就必须要加入containerView中才能进行，可以理解containerView管理着所有做转场动画的视图
    UIView *containerView = [transitionContext containerView];
    //将截图视图和vc2的view都加入ContainerView中
    [containerView addSubview:tempView];
    [containerView addSubview:toVC.view];
    
    toVC.view.frame = CGRectMake(containerView.bounds.size.width, 0, containerView.bounds.size.width, containerView.bounds.size.height);
    
    [UIView animateWithDuration:TRANSITIONDURATION animations:^{
        toVC.view.frame = CGRectMake(0, 0, containerView.bounds.size.width, containerView.bounds.size.height);
    } completion:^(BOOL finished) {
        //使用如下代码标记整个转场过程是否正常完成[transitionContext transitionWasCancelled]代表手势是否取消了，如果取消了就传NO表示转场失败，反之亦然，如果不用手势present的话直接传YES也是可以的，但是无论如何我们都必须标记转场的状态，系统才知道处理转场后的操作，否者认为你一直还在转场中，会出现无法交互的情况，切记！
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        //转场失败后的处理
        if ([transitionContext transitionWasCancelled]) {
            //失败后，我们要把vc1显示出来
            fromVC.view.hidden = NO;
            //然后移除截图视图，因为下次触发present会重新截图
            [tempView removeFromSuperview];
        }
    }];
    
}

- (void)dismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //参照present动画的逻辑，present成功后，containerView的最后一个子视图就是截图视图，我们将其取出准备动画
    UIView *tempView = [transitionContext containerView].subviews[0];
    
    [UIView animateWithDuration:TRANSITIONDURATION animations:^{
        fromVC.view.frame = CGRectMake(tempView.frame.size.width, 0, tempView.frame.size.width, tempView.frame.size.height);
    } completion:^(BOOL finished) {
        if ([transitionContext transitionWasCancelled]) {
            //失败了标记失败
            [transitionContext completeTransition:NO];
        }else{
            //如果成功了，我们需要标记成功，同时让vc1显示出来，然后移除截图视图，
            [transitionContext completeTransition:YES];
            toVC.view.hidden = NO;
            [tempView removeFromSuperview];
        }
    }];
}

- (void)pushAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *toVC = (UIViewController*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = (UIViewController*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView * containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    
    CGFloat width = containerView.bounds.size.width;
    CGFloat height = containerView.bounds.size.height;
    
    toVC.view.frame = CGRectMake(width, 0, width, height);
    
    [UIView animateWithDuration:TRANSITIONDURATION animations:^{
        toVC.view.frame = CGRectMake(0, 0, containerView.bounds.size.width, containerView.bounds.size.height);
    } completion:^(BOOL finished) {
        //使用如下代码标记整个转场过程是否正常完成[transitionContext transitionWasCancelled]代表手势是否取消了，如果取消了就传NO表示转场失败，反之亦然，如果不用手势present的话直接传YES也是可以的，但是无论如何我们都必须标记转场的状态，系统才知道处理转场后的操作，否者认为你一直还在转场中，会出现无法交互的情况，切记！
        //由于加入了手势必须判断
        if ([transitionContext transitionWasCancelled]) {
            //失败了标记失败
            [transitionContext completeTransition:NO];
        }else{
            //如果成功了，我们需要标记成功，同时让vc1显示出来，然后移除截图视图，
            [transitionContext completeTransition:YES];
        }
    }];
    
}

- (void)popAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *toVC = (UIViewController*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = (UIViewController*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView * containerView = [transitionContext containerView];
    
    [containerView addSubview:toVC.view];
    [containerView bringSubviewToFront:fromVC.view];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    fromVC.view.frame = CGRectMake(0, 0, width, height);
    
    [UIView animateWithDuration:TRANSITIONDURATION animations:^{
        fromVC.view.frame = CGRectMake(width, 0, width, height);
//        fromVC.view.transform = CGAffineTransformMakeRotation(M_PI);
    } completion:^(BOOL finished) {
        //由于加入了手势必须判断
        if ([transitionContext transitionWasCancelled]) {
            //失败了标记失败
            [transitionContext completeTransition:NO];
        }else{
            //如果成功了，我们需要标记成功，同时让vc1显示出来，然后移除截图视图，
            [transitionContext completeTransition:YES];
        }
    }];
    
}

@end

#pragma mark - 手势驱动类

@interface InteractiveTransition ()

@property (nonatomic, weak) UIViewController *vc;
@property (nonatomic, assign) TransitionType type;
@property (nonatomic, assign) TransitionGestureDirection direction;

@end

@implementation InteractiveTransition

+ (instancetype)interactiveTransitionWithTransitionType:(TransitionType)type GestureDirection:(TransitionGestureDirection)direction{
    return [[InteractiveTransition alloc] initWithTransitionType:type GestureDirection:direction];
}

- (instancetype)initWithTransitionType:(TransitionType)type GestureDirection:(TransitionGestureDirection)direction{
    self = [super init];
    if (self) {
        _type = type;
        _direction = direction;
    }
    return self;
}

- (void)addPanGestureForViewController:(UIViewController *)viewController{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    self.vc = viewController;
    [viewController.view addGestureRecognizer:pan];
}

- (void)handleGesture:(UIPanGestureRecognizer *)panGesture{
    
    CGFloat persent;//手势百分比
    switch (_direction) {
        case TransitionGestureDirectionLeft:{
            CGFloat transitionX = -[panGesture translationInView:panGesture.view].x;
            persent = transitionX / panGesture.view.frame.size.width;
        }
            break;
            
        case TransitionGestureDirectionRight:{
            CGFloat transitionX = [panGesture translationInView:panGesture.view].x;
            persent = transitionX / panGesture.view.frame.size.width;
        }
            break;
            
        case TransitionGestureDirectionUp:{
            CGFloat transitionY = -[panGesture translationInView:panGesture.view].y;
            persent = transitionY / panGesture.view.frame.size.height;
        }
            break;
            
        case TransitionGestureDirectionDown:{
            CGFloat transitionY = [panGesture translationInView:panGesture.view].y;
            persent = transitionY / panGesture.view.frame.size.height;
        }
            break;
            
        default:
            break;
    }
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
            self.isInteractionBegin = YES;
            [self startGesture];
            break;
            
        case UIGestureRecognizerStateChanged:
            //手势过程中，通过updateInteractiveTransition设置pop过程进行的百分比
            [self updateInteractiveTransition:persent];
            NSLog(@"percent == %f",persent);
            break;
            
        case UIGestureRecognizerStateEnded:
            //手势完成后结束标记并且判断移动距离是否过半，过则finishInteractiveTransition完成转场操作，否者取消转场操作
            self.isInteractionBegin = NO;
            if (persent > 0.5) {
                [self finishInteractiveTransition];
            }else{
                [self cancelInteractiveTransition];
            }
            break;
            
        default:
            break;
    }
    
}

- (void)startGesture{
    switch (_type) {
        case TransitionTypePresent:{
            if (_presentConifg) {
                _presentConifg();
            }
        }
            break;
            
        case TransitionTypeDismiss:
            [_vc dismissViewControllerAnimated:YES completion:nil];
            break;
            
        case TransitionTypePush:{
            if (_pushConifg) {
                _pushConifg();
            }
        }
            break;
        case TransitionTypePop:
            [_vc.navigationController popViewControllerAnimated:YES];
            break;
    }
}

@end










