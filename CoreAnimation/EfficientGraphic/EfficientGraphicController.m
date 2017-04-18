//
//  EfficientGraphicController.m
//  CoreAnimation
//
//  Created by mgfjx on 2017/4/14.
//  Copyright © 2017年 xintong. All rights reserved.
//

#import "EfficientGraphicController.h"
#import "DrawingView.h"

@interface EfficientGraphicController ()



@end

@implementation EfficientGraphicController

- (void)viewDidLoad {
    [super viewDidLoad];

    DrawingView *view = [[DrawingView alloc] initWithFrame:self.view.bounds];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
}

@end
