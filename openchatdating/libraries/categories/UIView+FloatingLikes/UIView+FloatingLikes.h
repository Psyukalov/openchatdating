//
//  UIView+FloatingLikes.h
//
//
//  Created by Vladimir Psyukalov on 28.06.2018.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import <UIKit/UIKit.h>


#define kLikeImageName (@"uiview_floatinglikes_like_image.png")

#define kDefaultDuration (3.2f)


@interface UIView (FloatingLikes)

- (void)addLikeWithPoint:(CGPoint)point;

- (void)addImage:(nonnull UIImage *)image withPoint:(CGPoint)point;

- (void)addImage:(nonnull UIImage *)image withPoint:(CGPoint)point duration:(CGFloat)duration;

@end
