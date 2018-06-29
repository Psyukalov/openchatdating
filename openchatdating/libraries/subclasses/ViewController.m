//
//  ViewController.m
//
//
//  Created by Vladimir Psyukalov on 07.12.17.
//  Copyright © 2017 YOUROCK INC. All rights reserved.
//


#import "ViewController.h"


@interface ViewController ()

@end


@implementation ViewController

#pragma mark - Class properties

- (void)setImageNamed:(NSString *)imageNamed {
    _imageNamed = imageNamed;
    UIImageView *imageView = [UIImageView new];
    [imageView setImage:[UIImage imageNamed:_imageNamed]];
    [imageView sizeToFit];
    self.navigationItem.titleView = imageView;
}

#pragma mark - Class methods

- (void)keyboardWillShow:(BOOL)show height:(CGFloat)height duration:(CGFloat)duration completion:(void (^)(void))completion {
    NSLog(@"Keyboard will show: %@; Height: %1.2f; Duration: %1.2f;", show ? @"Yes" : @"No", height, duration);
}

- (void)deviceOrientationDidChange:(UIDeviceOrientation)deviceOrientation {
    NSLog(@"Device orientation did change: %ld;", (unsigned long)deviceOrientation);
}

#pragma mark - Overriding properties

- (void)setTitle:(NSString *)title withFont:(UIFont *)font andColor:(UIColor *)color {
    [super setTitle:title];
    if (!font) {
        font = [UIFont new];
    }
    if (!color) {
        color = [UIColor whiteColor];
    }
    UILabel *label = [UILabel new];
    NSDictionary *attributes = @{NSFontAttributeName : font, NSForegroundColorAttributeName : color};
    label.attributedText = [[NSAttributedString alloc] initWithString:self.title attributes:attributes];
    [label sizeToFit];
    self.navigationItem.titleView = label;
}

#pragma mark - Overriding methods

- (BOOL)shouldAutorotate {
    if (self.presentedViewController) {
        return [self.presentedViewController shouldAutorotate];
    }
    return NO; // Default;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if (self.presentedViewController) {
        return [self.presentedViewController supportedInterfaceOrientations];
    }
    return UIInterfaceOrientationMaskPortrait; // Default;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [center addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [center addObserver:self selector:@selector(deviceOrientationDidChangeSelector:) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [center removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [center removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}

#pragma mark - Other methods

- (void)deviceOrientationDidChangeSelector:(NSNotification *)notification {
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    [self deviceOrientationDidChange:deviceOrientation];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    CGFloat height = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [self keyboardWillShow:YES height:height duration:duration completion:nil];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    CGFloat height = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [self keyboardWillShow:NO height:height duration:duration completion:nil];
}

@end
