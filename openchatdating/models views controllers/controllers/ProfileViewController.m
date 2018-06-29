//
//  ProfileViewController.m
//  openchatdating
//
//  Created by Vladimir Psyukalov on 28.06.2018.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "ProfileViewController.h"

#import "Macros.h"
#import "Colors.h"

#import "UIView+Custom.h"


@interface ProfileViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end


@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self design];
}

- (void)setup {
    [self setTitle:LOCALIZE(@"pv_title") withFont:[UIFont fontWithName:@"Montserrat-Regular" size:16.f] andColor:self.navigationController.navigationBar.tintColor];
    [self.view localize];
    [self.view resize];
}

- (void)design {
    [_imageView cornerRadius:.5f * _imageView.frame.size.width];
    [_imageView borderWithColor:[UIColor whiteColor] width:2.f];
    [_imageView shadowWithOffset:CGSizeZero color:RGB(16.f, 16.f, 16.f) opacity:.16f];
}

@end
