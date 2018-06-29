//
//  Colors.h
//
//
//  Created by Vladimir Psyukalov on 06.04.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#ifndef Colors_h
#define Colors_h


#define RGBA(R, G, B, A) ([UIColor colorWithRed:R / 255.f green:G / 255.f blue:B / 255.f alpha:A / 255.f])

#define RGB(R, G, B) (RGBA(R, G, B, 255.f))


#define kWindow_BackgroundColor (RGB(255.f, 255.f, 255.f))

#define kNavigationBar_BarTintColor (RGB(244.f, 244.f, 244.f))

#define kNavigationBar_TintColor (RGB(232, 16.f, 16.f))

#define kTabBar_BarTintColor (RGB(244.f, 244.f, 244.f))

#define kTabBar_TintColor (RGB(232, 16.f, 16.f))


#endif /* Colors_h */
