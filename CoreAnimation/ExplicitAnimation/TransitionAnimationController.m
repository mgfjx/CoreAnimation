//
//  TransitionAnimationController.m
//  CoreAnimation
//
//  Created by mgfjx on 2017/4/13.
//  Copyright © 2017年 xintong. All rights reserved.
//

#import "TransitionAnimationController.h"

@interface TransitionAnimationController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) NSArray *images;

@end

@implementation TransitionAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(10, 64 + 10, self.view.width - 2*10, self.view.height - 64 - 2*10)];
    view.backgroundColor = [UIColor lightGrayColor];
    view.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:view];
    
    self.images = @[[UIImage imageNamed:@"2.jpg"],
                    [UIImage imageNamed:@"launchImage"],
                    [UIImage imageNamed:@"main"],
                    [UIImage imageNamed:@"exp"],
                    ];
    
    self.imageView = view;
    
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Run" style:UIBarButtonItemStylePlain target:self action:@selector(clicked)];
    self.navigationItem.rightBarButtonItem = item;
    
}

- (void)clicked{
    
    [UIView transitionWithView:self.imageView duration:1.0 options:UIViewAnimationOptionTransitionFlipFromLeft | UIViewAnimationOptionTransitionCrossDissolve animations:^{
        NSInteger index = [self.images indexOfObject:self.imageView.image];
        index = (index + 1)%(self.images.count);
        self.imageView.image = self.images[index];
    } completion:NULL];
    
    return;
    
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    transition.duration = 0.25;
    [self.imageView.layer addAnimation:transition forKey:nil];
    
    NSInteger index = [self.images indexOfObject:self.imageView.image];
    index = (index + 1)%(self.images.count);
    self.imageView.image = self.images[index];
    
}

@end
