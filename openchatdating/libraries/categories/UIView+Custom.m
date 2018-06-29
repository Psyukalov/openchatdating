//
//  UIView+Custom.m
//
//
//  Created by unregister user on 22.09.17.
//  Copyright © 2017 YOUROCK INC. All rights reserved.
//


#import "UIView+Custom.h"

#import "UITextField+Custom.h"


@implementation UIView (Custom)

- (void)addConstraintsWithView:(UIView *)view {
    [self addConstraintsWithView:view customInsert:NO];
}

- (void)addConstraintsWithView:(UIView *)view customInsert:(BOOL)customInsert {
    view.translatesAutoresizingMaskIntoConstraints = NO;
    if (!customInsert) {
        [self addSubview:view];
    }
    NSArray *attributes = @[@(NSLayoutAttributeLeft), @(NSLayoutAttributeTop), @(NSLayoutAttributeRight), @(NSLayoutAttributeBottom)];
    for (NSNumber *attribute in attributes) {
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:[attribute unsignedIntegerValue] relatedBy:NSLayoutRelationEqual toItem:self attribute:[attribute unsignedIntegerValue] multiplier:1.f constant:0.f]];
    }
}

- (void)cornerRadius:(CGFloat)cornerRadius {
    [self.layer setCornerRadius:cornerRadius];
    self.layer.masksToBounds = YES;
}

- (void)borderWithColor:(UIColor *)color {
    [self borderWithColor:color width:1.f];
}

- (void)borderWithColor:(UIColor *)color width:(CGFloat)width {
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
}

- (void)shadowWithOffset:(CGSize)offset {
    [self shadowWithOffset:offset color:[UIColor blackColor]];
}

- (void)shadowWithOffset:(CGSize)offset color:(UIColor *)color {
    [self shadowWithOffset:offset color:color opacity:.64f];
}

- (void)shadowWithOffset:(CGSize)offset color:(UIColor *)color opacity:(CGFloat)opacity {
    self.layer.shadowOffset = offset;
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowRadius = 6.4f;
    self.layer.masksToBounds = NO;
}

- (void)gradientLayerWithColors:(NSArray *)colors {
    [self gradientLayerWithColors:colors horizontal:YES];
}

- (void)gradientLayerWithColors:(NSArray *)colors horizontal:(BOOL)horizontal {
    CGPoint startPoint = horizontal ? CGPointMake(0.f, .5f) : CGPointMake(.5f, 0.f);
    CGPoint endPoint = horizontal ? CGPointMake(1.f, .5f) :  CGPointMake(.5f, 1.f);
    [self gradientLayerWithColors:colors startPoint:startPoint endPoint:endPoint];
}

- (void)gradientLayerWithColors:(NSArray *)colors startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    [self gradientLayerWithColors:colors startPoint:startPoint endPoint:endPoint locations:@[@(0.f), @(1.f)]];
}

- (void)gradientLayerWithColors:(NSArray *)colors startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint locations:(NSArray *)locations {
    CAGradientLayer *layer = [CAGradientLayer layer];
    [layer setFrame:self.bounds];
    layer.colors = colors;
    layer.locations = locations;
    layer.startPoint = startPoint;
    layer.endPoint = endPoint;
    [self.layer insertSublayer:layer atIndex:0];
}

- (void)resize {
    CGFloat rate = [UIScreen mainScreen].bounds.size.height / 667.f;
    for (NSLayoutConstraint *constraint in self.constraints) {
        CGFloat constant = constraint.constant;
        if (constant != 0.f && constant != 1.f) {
            [constraint setConstant:rate * constraint.constant];
        }
    }
    for (UIView *subview in self.subviews) {
        if ([subview isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)subview;
            label.font = [label.font fontWithSize:rate * label.font.pointSize];
        } else if ([subview isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)subview;
            UIFont *font = button.titleLabel.font;
            button.titleLabel.font = [font fontWithSize:rate * font.pointSize];
        } else if ([subview isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField *)subview;
            UIFont *font = textField.font;
            textField.font = [font fontWithSize:rate * font.pointSize];
            [textField placeholderWithDefaultColor];
        } else {
            [subview resize];
        }
    }
}

- (void)localize {
    for (UIView *subview in self.subviews) {
        if ([subview isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)subview;
            label.text = NSLocalizedString(label.text, nil);
        } else if ([subview isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)subview;
            [button setTitle:NSLocalizedString(button.titleLabel.text, nil) forState:UIControlStateNormal];
        } else if ([subview isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField *)subview;
            textField.placeholder = NSLocalizedString(textField.placeholder, nil);
            [textField placeholderWithDefaultColor];
        } else {
            [subview localize];
        }
    }
}

+ (void)animate:(void (^)(void))animate {
    [self animate:animate completion:nil];
}

+ (void)animate:(void (^)(void))animate completion:(void (^)(void))completion {
    [self animate:animate completion:completion duration:.32f];
}

+ (void)animate:(void (^)(void))animate completion:(void (^)(void))completion duration:(CGFloat)duration {
    [UIView animateWithDuration:duration delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        if (animate) {
            animate();
        }
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];
}

+ (UIImage *)imageWithView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.f);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
