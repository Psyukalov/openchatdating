//
//  UIView+FloatingLikes.m
//
//
//  Created by Vladimir Psyukalov on 28.06.2018.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "UIView+FloatingLikes.h"


@implementation UIView (FloatingLikes)

- (void)addLikeWithPoint:(CGPoint)point {
    UIImage *image = [UIImage imageNamed:kLikeImageName];
    [self addImage:image withPoint:point];
}

- (void)addImage:(UIImage *)image withPoint:(CGPoint)point {
    [self addImage:image withPoint:point duration:kDefaultDuration];
}

- (void)addImage:(UIImage *)image withPoint:(CGPoint)point duration:(CGFloat)duration {
    CALayer *layer = [CALayer new];
    layer.frame = CGRectMake(point.x, point.y, image.size.width, image.size.height);
    layer.contents = (__bridge id _Nullable)[image CGImage];
    [self.layer addSublayer:layer];
    __weak CALayer *weakLayer = layer;
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        [weakLayer removeFromSuperlayer];
    }];
    CAAnimationGroup *animationGroup = [self animationWithFrame:layer.frame];
    animationGroup.duration = duration + (arc4random() % (NSUInteger)duration - 2.f);
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.removedOnCompletion = NO;
    [layer addAnimation:animationGroup forKey:nil];
    [CATransaction commit];
}

- (CAAnimationGroup *)animationWithFrame:(CGRect)frame {
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef path = CGPathCreateMutable();
    NSInteger height = (NSInteger)(-100.f + arc4random() % 40 - 20.f);
    NSInteger xOffset = (NSInteger)frame.origin.x;
    NSInteger yOffset = (NSInteger)frame.origin.y;
    NSInteger waveWidth = 40;
    CGPoint point_0 = CGPointMake(xOffset, height * 0 + yOffset);
    CGPoint point_1 = CGPointMake(xOffset, height * 1 + yOffset);
    CGPoint point_2 = CGPointMake(xOffset, height * 2 + yOffset);
    CGPoint point_3 = CGPointMake(xOffset, height * 2 + yOffset);
    CGPathMoveToPoint(path, NULL, point_0.x, point_0.y);
    if (arc4random() % 2) {
        CGPathAddQuadCurveToPoint(path, NULL, point_0.x - arc4random() % waveWidth, point_0.y + height / 2.f, point_1.x, point_1.y);
        CGPathAddQuadCurveToPoint(path, NULL, point_1.x + arc4random() % waveWidth, point_1.y + height / 2.f, point_2.x, point_2.y);
        CGPathAddQuadCurveToPoint(path, NULL, point_2.x - arc4random() % waveWidth, point_2.y + height / 2.f, point_3.x, point_3.y);
    } else {
        CGPathAddQuadCurveToPoint(path, NULL, point_0.x + arc4random() % waveWidth, point_0.y + height / 2.f, point_1.x, point_1.y);
        CGPathAddQuadCurveToPoint(path, NULL, point_1.x - arc4random() % waveWidth, point_1.y + height / 2.f, point_2.x, point_2.y);
        CGPathAddQuadCurveToPoint(path, NULL, point_2.x + arc4random() % waveWidth, point_2.y + height / 2.f, point_3.x, point_3.y);
    }
    positionAnimation.path = path;
    positionAnimation.calculationMode = kCAAnimationCubicPaced;
    CGPathRelease(path);
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = @(.94f);
    opacityAnimation.toValue = @(0.f);
    opacityAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[positionAnimation, opacityAnimation];
    return animationGroup;
}

@end
