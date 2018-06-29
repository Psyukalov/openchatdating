//
//  UserManager.m
//  openchatdating
//
//  Created by Vladimir Psyukalov on 28.06.2018.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "UserManager.h"


#import <FirebaseAuth/FirebaseAuth.h>


@interface UserManager ()

{
    FIRAuthStateDidChangeListenerHandle authStateDidChangeListenerHandle;
}

@end


@implementation UserManager

#pragma mark - Class methods

+ (instancetype)shared {
    static id instace = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instace = [[self class] new];
    });
    return instace;
}

- (void)startObservingAuthorizationState {
    authStateDidChangeListenerHandle = [[FIRAuth auth] addAuthStateDidChangeListener:^(FIRAuth * _Nonnull auth, FIRUser * _Nullable user) {
        BOOL authorized = user != nil;
        BOOL verified = user.emailVerified;
        [self sendWithCompletion:^(id<UserManagerObserverProtocol> observer) {
            if (authorized) {
                if ([observer respondsToSelector:@selector(userManager:didAuthorizedWithEmailVerified:)]) {
                    [observer userManager:self didAuthorizedWithEmailVerified:verified];
                }
            } else {
                if ([observer respondsToSelector:@selector(userManager:didUnauthorizedWithEmailVerified:)]) {
                    [observer userManager:self didUnauthorizedWithEmailVerified:verified];
                }
            }
        }];
    }];
}

- (void)stopObservingAuthorizationState {
    [[FIRAuth auth] removeAuthStateDidChangeListener:authStateDidChangeListenerHandle];
}

#pragma mark - Overriding methods

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

#pragma mark - Other methods

- (void)setup {
    [self startObservingAuthorizationState];
}

@end
