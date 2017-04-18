//
//  DrawingView.m
//  CoreAnimation
//
//  Created by mgfjx on 2017/4/14.
//  Copyright © 2017年 xintong. All rights reserved.
//

#import "DrawingView.h"
#define BRUSH_SIZE 32

@interface DrawingView ()

@property (nonatomic, strong) NSMutableArray *strokes;

@end

@implementation DrawingView

- (NSMutableArray *)strokes{
    if (!_strokes) {
        _strokes = [NSMutableArray array];
    }
    return _strokes;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self];
    [self addBrushStrokeAtPoint:point];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self];
    [self addBrushStrokeAtPoint:point];
}

- (void)addBrushStrokeAtPoint:(CGPoint)point{
    [self.strokes addObject:[NSValue valueWithCGPoint:point]];
    [self setNeedsDisplayInRect:[self brushRectForPoint:point]];
}

- (CGRect)brushRectForPoint:(CGPoint)point{
    return CGRectMake(point.x - BRUSH_SIZE/2, point.y - BRUSH_SIZE/2, BRUSH_SIZE, BRUSH_SIZE);
}

- (void)drawRect:(CGRect)rect{
    for (NSValue *value in self.strokes) {
        CGPoint point = [value CGPointValue];
        CGRect brushRect = [self brushRectForPoint:point];
        if (CGRectIntersectsRect(rect, brushRect)) {
            [[UIImage imageNamed:@"exp"] drawInRect:brushRect];
        }
    }
}

@end
