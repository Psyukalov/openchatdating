//
//  User.m
//  openchatdating
//
//  Created by Vladimir Psyukalov on 28.06.2018.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "User.h"


@implementation User

#pragma mark - Class properties

- (BOOL)male {
    return _gender == UserGenderMale;
}

- (BOOL)female {
    return _gender == UserGenderFemale;
}

- (BOOL)preferMale {
    return _preferGender == UserGenderMale;
}

- (BOOL)preferFemale {
    return _preferGender == UserGenderFemale;
}

#pragma mark - Class methods

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        @try {
            _identifier = dictionary[@"identifier"];
        } @catch (NSException *exception) {
            _identifier = [NSString new];
        }
        @try {
            _name = dictionary[@"name"];
        } @catch (NSException *exception) {
            _name = [NSString new];
        }
        @try {
            _imageBase64 = dictionary[@"imageBase64"];
        } @catch (NSException *exception) {
            _imageBase64 = [NSString new];
        }
        @try {
            _information = dictionary[@"information"];
        } @catch (NSException *exception) {
            _information = [NSString new];
        }
        @try {
            _age = [dictionary[@"age"] integerValue];
        } @catch (NSException *exception) {
            _age = 0;
        }
        @try {
            _tokensCount = [dictionary[@"tokensCount"] integerValue];
        } @catch (NSException *exception) {
            _tokensCount = 0;
        }
        @try {
            NSUInteger gender = [dictionary[@"gender"] integerValue];
            _gender = gender == 0 ? UserGenderMale : UserGenderFemale;
        } @catch (NSException *exception) {
            _gender = UserGenderMale;
        }
        @try {
            NSUInteger preferGender = [dictionary[@"preferGender"] integerValue];
            _preferGender = preferGender == 0 ? UserGenderMale : UserGenderFemale;
        } @catch (NSException *exception) {
            _preferGender = UserGenderFemale;
        }
    }
    return self;
}

@end
