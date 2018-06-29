//
//  UserManager.h
//  openchatdating
//
//  Created by Vladimir Psyukalov on 28.06.2018.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "CustomObject.h"

#import "User.h"


@class UserManager;


@protocol UserManagerObserverProtocol <CustomObjectObserverProtocol>

@optional

- (void)userManager:(UserManager *)userManager didAuthorizedWithEmailVerified:(BOOL)emailVerified;

- (void)userManager:(UserManager *)userManager didUnauthorizedWithEmailVerified:(BOOL)emailVerified;

@end

@interface UserManager : CustomObject

@property (strong, nonatomic) User *currentUser;

+ (instancetype)shared;

- (void)startObservingAuthorizationState;

- (void)stopObservingAuthorizationState;

@end
