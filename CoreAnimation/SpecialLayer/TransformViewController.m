//
//  TransformViewController.m
//  CoreAnimation
//
//  Created by 谢小龙 on 16/6/8.
//  Copyright © 2016年 xintong. All rights reserved.
//

#import "TransformViewController.h"

@interface TransformViewController ()

@property (nonatomic, strong) UIView *containerView;

@property (strong, nonatomic) NSMutableArray *faces;


@end

@implementation TransformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.containerView = [[UIView alloc] init];
//    self.containerView.backgroundColor = [UIColor colorWithRed:0.554 green:0.771 blue:0.908 alpha:1.000];
    self.containerView.frame = CGRectMake(70, 200, 200, 200);
    [self.view addSubview:self.containerView];
    
    self.faces = [NSMutableArray array];
    
    for (int i = 0; i < 6; i++) {
        
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(0, 0, 200, 200);
        
        CGFloat r = arc4random()%255;
        CGFloat g = arc4random()%255;
        CGFloat b = arc4random()%255;
        
//        view.backgroundColor = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
        view.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc] init];
        label.text = [NSString stringWithFormat:@"%d",i];
        label.font = [UIFont systemFontOfSize:34];
        label.textColor = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
        label.textAlignment = NSTextAlignmentCenter;
        
        [view addSubview:label];
        
        [self.faces addObject:view];
        
    }
    
    //set up the container sublayer transform
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0 / 500.0;
    perspective = CATransform3DRotate(perspective, -M_PI_4, 1, 0, 0);
    perspective = CATransform3DRotate(perspective, -M_PI_4, 0, 1, 0);
    self.containerView.layer.sublayerTransform = perspective;
    //add cube face 1
    CATransform3D transform = CATransform3DMakeTranslation(0, 0, 100);
    [self addFace:0 withTransform:transform];
    //add cube face 2
    transform = CATransform3DMakeTranslation(100, 0, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
    [self addFace:1 withTransform:transform];
    //add cube face 3
    transform = CATransform3DMakeTranslation(0, -100, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 1, 0, 0);
    [self addFace:2 withTransform:transform];
    //add cube face 4
    transform = CATransform3DMakeTranslation(0, 100, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 1, 0, 0);
    [self addFace:3 withTransform:transform];
    //add cube face 5
    transform = CATransform3DMakeTranslation(-100, 0, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 0, 1, 0);
    [self addFace:4 withTransform:transform];
    //add cube face 6
    transform = CATransform3DMakeTranslation(0, 0, -100);
    transform = CATransform3DRotate(transform, M_PI, 0, 1, 0);
    [self addFace:5 withTransform:transform];
    
}

- (void)addFace:(NSInteger)index withTransform:(CATransform3D)transform
{
    //get the face view and add it to the container
    UIView *face = self.faces[index];
    [self.containerView addSubview:face];
    CGSize containerSize = self.containerView.bounds.size;
//    face.frame = CGRectMake(0, 0, 200, 200);
//    UILabel *label = [face viewWithTag:100];
//    label.frame = face.frame;
    face.center = CGPointMake(containerSize.width / 2.0, containerSize.height / 2.0);
    // apply the transform
    face.layer.transform = transform;
    face.layer.sublayerTransform = transform;
}


@end
