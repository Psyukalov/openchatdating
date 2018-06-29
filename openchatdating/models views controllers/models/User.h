//
//  User.h
//  openchatdating
//
//  Created by Vladimir Psyukalov on 28.06.2018.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger, UserGender) {
    UserGenderMale = 0,
    UserGenderFemale
};


@interface User : NSObject

@property (strong, nonatomic) NSString *identifier;

@property (strong, nonatomic) NSString *name;

@property (strong, nonatomic) NSString *information;

@property (strong, nonatomic) NSString *imageBase64;

@property (assign, nonatomic) NSUInteger age;

@property (assign, nonatomic) NSUInteger tokensCount;

@property (assign, nonatomic) UserGender gender;

@property (assign, nonatomic) UserGender preferGender;

@property (assign, nonatomic, readonly) BOOL male;

@property (assign, nonatomic, readonly) BOOL female;

@property (assign, nonatomic, readonly) BOOL preferMale;

@property (assign, nonatomic, readonly) BOOL preferFemale;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
